# typed: false
RSpec.describe InteractAction do
  let(:session) { Natural20::Session.new }
  let(:entity) { Natural20::PlayerCharacter.load(session, File.join("fixtures", "high_elf_fighter.yml")) }

  before do
    @battle_map = Natural20::BattleMap.new(session, "fixtures/battle_sim_objects")
    @battle_map.place(0, 5, entity, "G")
    @door = @battle_map.object_at(1, 4)
    @action = auto_build_self(entity, session, described_class,
                              select_object: @door,
                              interact: :open)
  end

  context "opening doors" do
    specify "resolve and apply" do
      expect(@door.opened?).to_not be
      @action.resolve(session)
      @action.apply!(nil)
      expect(@door.opened?).to be
      expect(@battle_map.objects_near(entity, nil)).to include @door
    end
  end
end
