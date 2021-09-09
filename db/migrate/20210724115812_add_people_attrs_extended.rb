# frozen_text_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_jamda_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/mwppoe/jamda_2023.

class AddPeopleAttrsExtended < ActiveRecord::Migration[4.2]
    def change
      add_column :people, :motivation, :text
      add_column :people, :languages_spoken, :string
      add_column :people, :shirt_size, :string
      add_column :people, :uniform_size, :string
      add_column :people, :can_swim, :boolean
      add_column :people, :buddy1_firstname, :string
      add_column :people, :buddy1_lastname, :string
      add_column :people, :buddy1_scoutcard, :string
      add_column :people, :buddy2_firstname, :string
      add_column :people, :buddy2_lastname, :string
      add_column :people, :buddy2_scoutcard, :string
      add_column :people, :buddy3_firstname, :string
      add_column :people, :buddy3_lastname, :string                  
      add_column :people, :buddy3_scoutcard, :string                        
    end
end