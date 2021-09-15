# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_jamda_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/mwppoe/jamda_2023.

class AddPeopleAttrsAdditionalContact < ActiveRecord::Migration[4.2]
    def change
      add_column :people, :additional_contact_name_a, :string, :limit => 64
      add_column :people, :additional_contact_adress_a, :string
      add_column :people, :additional_contact_phone_a, :string, :limit => 32
      add_column :people, :additional_contact_email_a, :string, :limit => 64
      add_column :people, :additional_contact_whatsapp_a, :boolean
      add_column :people, :additional_contact_relationship_a, :string, :limit => 32
      add_column :people, :additional_contact_relationship_b, :string, :limit => 32
      add_column :people, :additional_contact_name_b, :string, :limit => 64
      add_column :people, :additional_contact_adress_b, :string
      add_column :people, :additional_contact_phone_b, :string,  :limit => 32
      add_column :people, :additional_contact_email_b, :string, :limit => 64
      add_column :people, :additional_contact_whatsapp_b, :boolean
      add_column :people, :additional_contact_single, :boolean
    end
end

