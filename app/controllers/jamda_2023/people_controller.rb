# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_jamda_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/mwppoe/jamda_2023.

module Jamda2023
  module PeopleController
    extend ActiveSupport::Concern
    included do
      self.permitted_attrs += [
        :rdp_association,
        :rdp_association_region,
        :rdp_association_group,
        :rdp_association_number,
        :airport,
        :add_good_1,
        :add_good_2,
        :add_good_3,                
        :add_good_4,                
        :add_good_5,                                
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
        :buddy1_firstname,
        :buddy1_lastname,
        :buddy1_scoutcard,
        :buddy2_firstname,
        :buddy2_lastname,
        :buddy2_scoutcard,
        :buddy3_firstname,
        :buddy3_lastname,
        :buddy3_scoutcard,   
        :can_swim, 
        :phone,    
        :medicine_social_number,
        :medicine_social_joined,
        :medicine_social_joined_number,
        :medicine_bloodtype,
        :medicine_vaccination,
        :medicine_vaccination_tetanus,
        :medicine_vaccination_tetanus_date,
        :medicine_vaccination_fsme,
        :medicine_vaccination_fsme_date,
        :medicine_vaccination_masern,
        :medicine_vaccination_masern_date,
        :medicine_vaccination_meningokokken,
        :medicine_vaccination_meningokokken_date,
        :medicine_vaccination_hepatitisa,
        :medicine_vaccination_hepatitisa_date,
        :medicine_vaccination_hepatitisb,
        :medicine_vaccination_hepatitisb_date,
        :medicine_vaccination_covid19,
        :medicine_vaccination_covid19_date,
        :medicine_stiko_vaccination,
        :medicine_preexisting_conditions,
        :medicine_abnormalities,
        :medicine_allergies,
        :medicine_eating_disorders,
        :medicine_mobility_needs,
        :medicine_medical_treatment_contact,
        :medicine_continous_medication,
        :medicine_needs_medication,
        :medicine_spies,
        :medicine_other,
        :medicine_important,
        :medicine_therapies,
        :medicine_support,
        :medicine_filled,
        :upload_passport_pdf,
        :upload_registration_pdf,
        :upload_data_processing_pdf,
        :generated_registration_pdf,
        :upload_sepa_pdf,
        :upload_recommondation_pdf,
        :upload_good_conduct_pdf,
        :passport_nationality,
        :passport_number,
        :passport_austria,
        :passport_valid,
        :status,
        :unit_keys,
        :role_wish,
        :languages_spoken,
        :shirt_size,
        :size,
        :skills,
        :weight
      ]

      # Override crud_controller
      # Display a form to edit an exisiting entry of this model.
      #   GET /entries/1/edit
      def edit(&block)

        @manage = manage
        @rdp_groups = YAML.load_file(Rails.root.join('' \
                                    '../hitobito_jamda_2023/config/ppoe_groups.yml'))[Rails.env]
        @possible_airports = Settings.person.airports
        respond_with(entry, &block)
      end

      def manage
        current_user.role?('Group::Root::Admin') ||
        current_user.role?('Group::Root::Leader') ||
        current_user.role?('Group::Root::Dataadmin') ||        
        current_user.role?('Group::UnitSupport::Leader') ||
        current_user.role?('Group::UnitSupport::Member') ||
        current_user.role?('Group::Ist::Leader')
      end

    end
  end
end
