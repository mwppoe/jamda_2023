# frozen_text_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_jamda_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/mwppoe/jamda_2023.

class AddPeopleAttrsPassport < ActiveRecord::Migration[4.2]
    def change
      add_column :people, :passport_nationality, :string
      add_column :people, :passport_number, :string
      add_column :people, :passport_austria, :boolean
      add_column :people, :passport_valid, :date
    end
end