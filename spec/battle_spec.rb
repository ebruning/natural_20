# typed: false
RSpec.describe Natural20::Battle do
  let(:session) { Natural20::Session.new }
  context "Simple Natural20::Battle" do
    before do
      @map = Natural20::BattleMap.new(session, "fixtures/battle_sim")
      @battle = Natural20::Battle.new(session, @map)
      @fighter = Natural20::PlayerCharacter.load(session, File.join("fixtures", "high_elf_fighter.yml"))
      @npc = session.npc(:goblin, name: "a")
      @npc2 = session.npc(:goblin, name: "b")
      @npc3 = session.npc(:ogre, name: "c")
      @battle.add(@fighter, :a, position: :spawn_point_1, token: "G")
      @battle.add(@npc, :b, position: :spawn_point_2, token: "g")
      @battle.add(@npc2, :b, position: :spawn_point_3, token: "O")
      @fighter.reset_turn!(@battle)
      @npc.reset_turn!(@battle)
      @npc2.reset_turn!(@battle)

      Natural20::EventManager.register_event_listener([:died], ->(event) { puts "#{event[:source].name} died." })
      Natural20::EventManager.register_event_listener([:unconsious], ->(event) { puts "#{event[:source].name} unconsious." })
      Natural20::EventManager.register_event_listener([:initiative], ->(event) { puts "#{event[:source].name} rolled a #{event[:roll]} = (#{event[:value]}) with dex tie break for initiative." })
      srand(7000)
    end

    specify "attack" do
      @battle.start
      srand(7000)
      action = @battle.action(@fighter, :attack, target: @npc, using: "vicious_rapier")
      expect(action.result).to eq([{
                                 ammo: nil,
                                 battle: @battle,
                                 attack_name: "Vicious Rapier",
                                 source: @fighter,
                                 type: :miss,
                                 attack_roll: Natural20::DieRoll.new([2], 8, 20),
                                 target: @npc,
                                 npc_action: nil,
                               }])
      action = @battle.action(@fighter, :attack, target: @npc, using: "vicious_rapier")
      expect(action.result).to eq([{
                                 ammo: nil,
                                 attack_name: "Vicious Rapier",
                                 type: :damage,
                                 source: @fighter,
                                 battle: @battle,
                                 attack_roll: Natural20::DieRoll.new([10], 8, 20),
                                 hit?: true,
                                 damage: Natural20::DieRoll.new([2], 7, 8),
                                 damage_type: "piercing",
                                 target_ac: 15,
                                 target: @npc,
                                 sneak_attack: nil,
                                 npc_action: nil,
                               }])

      expect(@fighter.item_count("arrows")).to eq(20)
      @battle.commit(action)
      expect(@fighter.item_count("arrows")).to eq(20)

      expect(@npc.hp).to eq(0)
      expect(@npc.dead?).to be
      action = @battle.action(@npc2, :attack, target: @fighter, npc_action: @npc2.npc_actions[1])
      @battle.commit(action)

      @battle.add(@npc3, :c, position: [0, 0])

      expect(@battle.combat_order.map(&:name)).to eq(%w[a b Gomerin])
    end
  end

  context "#valid_targets_for" do
    before do
      @battle_map = Natural20::BattleMap.new(session, "fixtures/battle_sim_objects")
      @battle = Natural20::Battle.new(session, @battle_map)
      @fighter = Natural20::PlayerCharacter.load(session, File.join("fixtures", "high_elf_fighter.yml"))
      @npc = session.npc(:goblin, name: "a")
      @battle_map.place(0, 5, @fighter, "G")
      @battle.add(@fighter, :a)
      @door = @battle_map.object_at(1, 4)
    end

    it "shows all valid targets for attack action" do
      action = AttackAction.new(session, @fighter, :attack)
      action.using = "vicious_rapier"
      puts @battle_map.render
      expect(@battle.valid_targets_for(@fighter, action)).to eq([])
      @battle.add(@npc, :b, position: [1, 5])
      puts @battle_map.render
      expect(@battle.valid_targets_for(@fighter, action)).to eq([@npc])
      expect(@battle.valid_targets_for(@fighter, action, include_objects: true)).to eq([@npc, @door])
    end
  end
end
