require 'dm-migrations'
require 'dm-migrations/migration_runner'
require 'trophy_calculations'

class Trophy
    include DataMapper::Resource

    property :id,        Serial
    property :variant,   String, :required => false
    property :trophy,    String, :required => true
    property :text,      String, :required => true
    property :icon,      String, :required => true

    def Trophy.cross_variant_trophies
        Trophy.all :conditions => ["variant is null"]
    end

    # used for href
    def anchor
        self.icon[0 ..-5]
    end
    def light_icon
        anchor+"_light.png"
    end
end

DataMapper::MigrationRunner.migration( 1, :create_trophies ) do
  up do
    # Cross Variant
    Trophy.create :trophy => "king_of_the_world", :text => "King of the world: ascend in all variants", :icon => "king.png"
    Trophy.create :trophy => "anti_stoner",       :text => "Anti-Stoner: defeated Medusa in all variants", :icon => "anti-stoner.png"
    Trophy.create :trophy => "globetrotter",      :text => "Globetrotter: get a trophy for each variant", :icon => "globetrotter.png"
    Trophy.create :trophy => "sightseeing_tour",  :text => "Sightseeing Tour: finish a game in all variants", :icon => "sightseeing.png"
    
    # NetHack 1.3d
    Trophy.create :variant => "NH-1.3d", :trophy => "ascended_old", :text => "ascended", :icon => "old-ascension.png"
    Trophy.create :variant => "NH-1.3d", :trophy => "crowned", :text => "got crowned", :icon => "old-crowned.png"
    Trophy.create :variant => "NH-1.3d", :trophy => "entered_hell", :text => "entered Hell", :icon => "old-hell.png"
    Trophy.create :variant => "NH-1.3d", :trophy => "defeated_old_rodney", :text => "defeated Rodney", :icon => "old-wizard.png"
    
    # Clan
    Trophy.create :variant => "clan", :trophy => "most_ascensions_in_a_24_hour_period", :text => "Most ascensions in a 24 hour period", :icon => "clan-24h.png"
    Trophy.create :variant => "clan", :trophy => "most_ascended_combinations", :text => "Most ascended variant/role/race/alignment/gender combinations (starting)", :icon => "clan-combinations.png"
    Trophy.create :variant => "clan", :trophy => "most_points", :text => "Most points", :icon => "clan-points.png"
    Trophy.create :variant => "clan", :trophy => "most_unique_deaths", :text => "Most unique deaths", :icon => "clan-deaths.png"
    
    # Standard achievements
    acehack = '3.6.0'
    unnethack = 'UNH-3.5.4'
    for variant in $variants do
      Trophy.create :variant => variant, :trophy => "ascended", :text => "ascended", :icon => "ascension.png"
      Trophy.create :variant => variant, :trophy => "escapologist", :text => "escaped in celestial disgrace", :icon => "escapologist.png"
      Trophy.create :variant => variant, :trophy => "entered_astral_plane", :text => "entered Astral Plane", :icon => "m-astral.png" if variant != acehack
      Trophy.create :variant => variant, :trophy => "entered_astral", :text => "entered Astral Plane", :icon => "m-astral.png" if variant == acehack
      Trophy.create :variant => variant, :trophy => "entered_elemental_planes", :text => "entered Elemental Planes", :icon => "m-planes.png" if variant != acehack
      Trophy.create :variant => variant, :trophy => "entered_planes", :text => "entered Elemental Planes", :icon => "m-planes.png" if variant == acehack
      Trophy.create :variant => variant, :trophy => "obtained_the_amulet_of_yendor", :text => "obtained the Amulet of Yendor", :icon => "m-amulet.png" if variant != acehack
      Trophy.create :variant => variant, :trophy => "defeated_a_high_priest", :text => "defeated a High Priest", :icon => "m-amulet.png" if variant == acehack
      Trophy.create :variant => variant, :trophy => "performed_the_invocation_ritual", :text => "performed the Invocation Ritual", :icon => "m-invocation.png" if variant != acehack
      Trophy.create :variant => variant, :trophy => "did_invocation", :text => "performed the Invocation Ritual", :icon => "m-invocation.png" if variant == acehack
      Trophy.create :variant => variant, :trophy => "obtained_the_book_of_the_dead", :text => "obtained the Book of the Dead", :icon => "m-book.png" if variant != acehack
      Trophy.create :variant => variant, :trophy => "defeated_rodney", :text => "defeated Rodney at least once", :icon => "m-book.png" if variant == acehack
      Trophy.create :variant => variant, :trophy => "obtained_the_candelabrum_of_invocation", :text => "obtained the Candelabrum of Invocation", :icon => "m-candelabrum.png" if variant != acehack
      Trophy.create :variant => variant, :trophy => "defeated_vlad", :text => "defeated Vlad", :icon => "m-candelabrum.png" if variant == acehack
      Trophy.create :variant => variant, :trophy => "entered_gehennom", :text => "entered Gehennom", :icon => "m-gehennom.png" if variant != acehack
      Trophy.create :variant => variant, :trophy => "event_entered_gehennom_front_way", :text => "entered Gehennom the front way", :icon => "m-gehennom.png" if variant == acehack
      Trophy.create :variant => variant, :trophy => "defeated_medusa", :text => "defeated Medusa", :icon => "m-medusa.png"
      Trophy.create :variant => variant, :trophy => "obtained_bell_of_opening", :text => "obtained the Bell of Opening", :icon => "m-bell.png" if variant != acehack
      Trophy.create :variant => variant, :trophy => "defeated_quest_nemesis", :text => "defeated the Quest Nemesis", :icon => "m-bell.png" if variant == acehack
      Trophy.create :variant => variant, :trophy => "obtained_the_luckstone_from_the_mines", :text => "obtained the luckstone from the Mines", :icon => "m-luckstone.png" if variant != acehack
      Trophy.create :variant => variant, :trophy => "accepted_for_quest", :text => "get accepted to the Quest", :icon => "m-luckstone.png" if variant == acehack
      Trophy.create :variant => variant, :trophy => "obtained_the_sokoban_prize", :text => "obtained the Sokoban Prize", :icon => "m-soko.png" if variant != acehack
      Trophy.create :variant => variant, :trophy => "bought_oracle_consultation", :text => "got an Oracle consultation", :icon => "m-soko.png" if variant == acehack
    end
    
    # AceHack and UnNetHack
    for variant in [acehack, unnethack] do
      Trophy.create :variant => variant, :trophy => "ascended_without_defeating_nemesis", :text => "Too good for quests (ascended without defeating the quest nemesis)", :icon => "m-no-nemesis.png"
      Trophy.create :variant => variant, :trophy => "ascended_without_defeating_vlad", :text => "Too good for Vladbanes (ascended without defeating Vlad)", :icon => "m-no-vlad.png"
      Trophy.create :variant => variant, :trophy => "ascended_without_defeating_rodney", :text => "Too good for... wait, what? How? (ascended without defeating Rodney)", :icon => "m-no-wizard.png"
      Trophy.create :variant => variant, :trophy => "ascended_with_all_invocation_items", :text => "Hoarder (ascended carrying all the invocation items)", :icon => "m-hoarder.png"
      Trophy.create :variant => variant, :trophy => "defeated_croesus", :text => "Assault on Fort Knox (defeated Croesus)", :icon => "m-croesus.png"
      Trophy.create :variant => variant, :trophy => "defeated_one_eyed_sam", :text => "No membership card (defeated One-Eyed Sam)", :icon => "m-sam.png" if variant == unnethack
      Trophy.create :variant => variant, :trophy => "ascended_without_defeating_cthulhu", :text => "Too good for a brain (ascended without defeating Cthulhu)", :icon => "m-no-cthulhu.png" if variant == unnethack
    end

  end
  down do
    Trophy.all.destroy
  end
end
