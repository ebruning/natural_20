# typed: strict
require 'natural_20/version'
require 'natural_20/session'
require 'colorize'
require 'natural_20/die_roll'
require 'natural_20/concerns/notable'
require 'natural_20/concerns/container'
require 'natural_20/concerns/lootable'
require 'natural_20/concerns/evaluator/entity_state_evaluator'
require 'natural_20/concerns/entity'
require 'natural_20/item_library/object'
require 'natural_20/concerns/movement_helper'
require 'natural_20/utils/cover'
require 'natural_20/utils/weapons'
require 'natural_20/actions/action'
require 'natural_20/concerns/fighter_class'
require 'natural_20/concerns/rogue_class'
require 'natural_20/actions/look_action'
require 'natural_20/actions/attack_action'
require 'natural_20/actions/multiattack_action'
require 'natural_20/actions/dodge_action'
require 'natural_20/actions/help_action'
require 'natural_20/actions/disengage_action'
require 'natural_20/actions/move_action'
require 'natural_20/actions/dash_action'
require 'natural_20/actions/use_item_action'
require 'natural_20/actions/interact_action'
require 'natural_20/actions/inventory_action'
require 'natural_20/actions/hide_action'
require 'natural_20/actions/prone_action'
require 'natural_20/actions/stand_action'
require 'natural_20/actions/grapple_action'
require 'natural_20/actions/escape_grapple_action'
require 'natural_20/actions/ground_interact_action'
require 'natural_20/actions/first_aid_action'
require 'natural_20/battle'
require 'natural_20/utils/ray_tracer'
require 'natural_20/battle_map'
require 'natural_20/cli/map_renderer'
require 'natural_20/event_manager'
require 'natural_20/concerns/health_flavor'
require 'natural_20/concerns/multiattack'
require 'natural_20/player_character'
require 'natural_20/npc'
require 'natural_20/controller'
require 'natural_20/ai_controller/path_compute'
require 'natural_20/ai_controller/standard'
require 'natural_20/item_library/base_item'
require 'natural_20/item_library/healing_potion'
require 'natural_20/item_library/door_object'
require 'natural_20/item_library/pit_trap'
require 'natural_20/item_library/stone_wall'
require 'natural_20/item_library/chest'
require 'natural_20/item_library/ground'
require 'natural_20/utils/static_light_builder'
require 'active_support'
require 'active_support/all'
require 'yaml'

module Natural20
  class Error < StandardError; end

  # Your code goes here...
end
