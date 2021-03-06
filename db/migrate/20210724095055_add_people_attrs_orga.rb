# frozen_text_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_jamda_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/mwppoe/jamda_2023.

class AddPeopleAttrsOrga < ActiveRecord::Migration[4.2]
    def change
      add_column :people, :status, :string, :default => 'registriert'
      add_column :people, :unit_keys, :string,  :limit => 64
      add_column :people, :role_wish, :string,  :limit => 32
    end
end