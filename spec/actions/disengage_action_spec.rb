# typed: false
RSpec.describe DisengageAction do
  let(:session) { Natural20::Session.new }
  before do
    @battle = Natural20::Battle.new(session, nil)
    @fighter = Natural20::PlayerCharacter.load(session, File.join("fixtures", "high_elf_fighter.yml"))
    @npc = session.npc(:goblin)
    @battle.add(@fighter, :a)
    @battle.add(@npc, :b)
    @npc.reset_turn!(@battle)
    @fighter.reset_turn!(@battle)
  end

  it "auto build" do
    expect(@npc.dodge?(@battle)).to_not be
    cont = DisengageAction.build(session, @npc)
    dodge_action = cont.next.call()
    dodge_action.resolve(session, nil, battle: @battle)
    dodge_action.apply!(@battle)
    expect(@npc.disengage?(@battle)).to be
  end
end
