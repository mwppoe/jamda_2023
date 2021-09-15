# frozen_text_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_jamda_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/mwppoe/jamda_2023.

class AddPeopleAttrsMedicine < ActiveRecord::Migration[4.2]
    def change
      add_column :people, :medicine_social_number, :string, :limit => 32
      add_column :people, :medicine_social_joined, :string, :limit => 64
      add_column :people, :medicine_social_joined_number, :string,  :limit => 32
      add_column :people, :medicine_bloodtype, :string, :limit => 32
      add_column :people, :medicine_vaccination, :text
      add_column :people, :medicine_vaccination_tetanus, :boolean
      add_column :people, :medicine_vaccination_tetanus_date, :date
      add_column :people, :medicine_vaccination_fsme, :boolean
      add_column :people, :medicine_vaccination_fsme_date, :date
      add_column :people, :medicine_vaccination_masern, :boolean
      add_column :people, :medicine_vaccination_masern_date, :date
      add_column :people, :medicine_vaccination_meningokokken, :boolean
      add_column :people, :medicine_vaccination_meningokokken_date, :date
      add_column :people, :medicine_vaccination_hepatitisa, :boolean
      add_column :people, :medicine_vaccination_hepatitisa_date, :date
      add_column :people, :medicine_vaccination_hepatitisb, :boolean
      add_column :people, :medicine_vaccination_hepatitisb_date, :date
      add_column :people, :medicine_vaccination_covid19, :boolean
      add_column :people, :medicine_vaccination_covid19_date, :date
      add_column :people, :medicine_preexisting_conditions, :text
      add_column :people, :medicine_abnormalities, :text
      add_column :people, :medicine_allergies, :text
      add_column :people, :medicine_eating_disorders, :text
      add_column :people, :medicine_mobility_needs, :text
      add_column :people, :medicine_continous_medication, :text
      add_column :people, :medicine_needs_medication, :text
      add_column :people, :medicine_therapies, :text 
      add_column :people, :medicine_other, :text 
      add_column :people, :medicine_important, :text 
      add_column :people, :medicine_support, :text
      add_column :people, :medicine_filled, :boolean
    end
end