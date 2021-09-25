# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_jamda_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/mwppoe/jamda_2023.

module Jamda2023::PersonSerializer
  extend ActiveSupport::Concern
  included do
    extension(:details) do |_|
      map_properties :old_id,
                     :rdp_association,
                     :rdp_association_region,
                     :rdp_association_group,
                     :rdp_association_number,
                     :additional_contact_name_a,
                     :additional_contact_adress_a,
                     :additional_contact_phone_a,
                     :additional_contact_email_a,
                     :additional_contact_whatsapp_a,
                     :additional_contact_relationship_a,
                     :additional_contact_relationship_b,
                     :additional_contact_name_b,
                     :additional_contact_adress_b,
                     :additional_contact_phone_b,
                     :additional_contact_email_b,
                     :additional_contact_whatsapp_b,
                     :additional_contact_single,
                     :additional_contact_address_info,
                     :passport_nationality,
                     :passport_number,
                     :passport_austria,
                     :passport_valid,
                     :status,
                     :skills,
                     :unit_keys,
                     :role_wish,
                     :languages_spoken,
                     :shirt_size,
                     :can_swim,
                     :phone
    end
  end
end
