# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_jamda_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/mwppoe/jamda_2023.

module Jamda2023
  module Export::Pdf::Registration
    # rubocop:disable Metrics/ClassLength
    class Medicin < Section
      def render
        pdf.y = bounds.height - 60
        bounding_box([0, 230.mm], width: bounds.width, height: bounds.height - 200) do
          font_size(8) do
            text list, style: :italic, width: bounds.width
          end
        end
      end

      # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Style/MultilineTernaryOperator,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
      def list
        of_legal_age = @person.years.to_i >= 18
        if of_legal_age
          signature = pdf.make_table([
                                       [{ content: @person.town + ' den ' \
                                        + Time.zone.today.strftime('%d.%m.%Y'), height: 30 }],
                                       ['______________________________', ''],
                                       [{ content: @person.full_name, height: 30 }, '']
                                     ],
                                     cell_style: { width: 240, padding: 1, border_width: 0,
                                                   inline_format: true })
        #elsif @person.additional_contact_single
        else
          signature = pdf.make_table([
                                       [{ content: @person.town + ' den ' \
                                         + Time.zone.today.strftime('%d.%m.%Y'), height: 30 }],
                                       %w(__________________________ __________________________),
                                       [{ content: @person.additional_contact_name_a, height: 30 },\
                                        + @person.full_name]
                                     ],
                                     cell_style: { width: 240, padding: 1, border_width: 0,
                                                   inline_format: true })
        #else
        #  signature = pdf.make_table([
        #                               [{ content: @person.town + ' den ' \
        #                                 + Time.zone.today.strftime('%d.%m.%Y'), height: 30 }],
        #                               %w(__________________________ __________________________),
        #                               [{ content: @person.additional_contact_name_a, height: 30 },\
        #                                + @person.additional_contact_name_b],
        #                               ['______________________________', ''],
        #                               [{ content: @person.full_name, height: 30 }, '']
        #                             ],
        #                             cell_style: { width: 240, padding: 1, border_width: 0,
        #                                           inline_format: true })
        end

        pdf.start_new_page
        text 'Was muss ich mit dem Gesundheitsdatenblatt machen?', size: 12
        text 'Das Gesundheitsdatenblatt muss'
        text '1. vollständig unterschrieben werden'
        text '2. am ersten Treffen der entsprechenden Betreuungsperson im Orginal überreicht werden'


        sr = ''
        if @person.medicine_social_joined_number.present?  
          sr  = 'Mitversichert bei / insured with: ' + @person.medicine_social_joined + ' (SV-Nummer / Social Number: ' + @person.medicine_social_joined_number + ')'
        end

        rs_a  = ''
        if @person.additional_contact_relationship_a.present?   
          rs_a  = '(' + @person.additional_contact_relationship_a + ')'
        end

        rs_b = ''
        if @person.additional_contact_relationship_b.present? 
          rs_b  = '(' + @person.additional_contact_relationship_b + ')'
       end

        pdf.move_down 3.mm
        pdf.stroke_horizontal_rule
        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_header_de'), size: 14
        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_header_en'), size: 14
        pdf.move_down 3.mm

        if @person.years.to_i >= 18
          text 'ERWACHSENE*R TEILNEHMER*IN / ADULT PARTICIPANT', size:12
        else
          text 'JUGENDLICHE*R TEILNEHMER*IN / ADOLESCENT PARTICIPANT', size:12
        end
        pdf.move_down 3.mm

        text 'zu / of ' + @person.full_name, size: 12
        text @person.address + ', ' + @person.zip_code + ', ' + @person.town
        text @person.email + ', ' + @person.phone
        text 'SV-Nummer / Social Number: ' + @person.medicine_social_number
        text sr
        pdf.move_down 3.mm
 
        text 'Ansprechpartner im Notfall / Emergency Contact: ', size:10, color: 'ff0000'
        text @person.additional_contact_name_a + ' ' + rs_a
        text @person.additional_contact_adress_a
        text @person.additional_contact_phone_a
        text @person.additional_contact_email_a 
        if @person.additional_contact_whatsapp_a
          text 'per WhatsApp erreibar: ja / reachable via Whatsapp: yes'
        end
        text '-----'
        text @person.additional_contact_name_b + ' ' + rs_b
        text @person.additional_contact_adress_b
        text @person.additional_contact_phone_b
        text @person.additional_contact_email_b 
        if @person.additional_contact_whatsapp_b
          text 'per WhatsApp erreibar: ja / reachable via Whatsapp: yes'
        end
        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_info')

        pdf.move_down 3.mm
        text 'Grundsätzliches', size: 12
        pdf.move_down 1.mm
        text 'Änderungen müssen bis zum Antritt der Reise unverzüglich dem Kontingentsteam/dem '\
        + 'ärztlichem Team über die Anmeldung (jamda.jamboree.at) mitgeteilt werden.'
        pdf.move_down 1.mm
        text 'e-card und Impfausweis sind mitzuführen. Das Gesundheitsdatenblatt '\
        + 'ist von den Patrullenbetreuer*innen mitzuführen.'
        pdf.move_down 1.mm
        text 'Auf dem Gesundheitsdatenblatt werden sensible Daten erfasst. Wir benötigen diese '\
        + 'zur Durchführung der Reise zum World Scout Jamboree.'\
        + ' Wir verfahren sehr sorgfältig mit den Daten, mehr dazu findet ihr in unseren '\
        + %(<link href="https://ppoe.at/functional-pages/impressum/">Datenschutzhinweisen.</link>), :inline_format => true
        
        pdf.move_down 3.mm
        text "Allgemein / General", size: 12
        if @person.size.present? 
          text "Größe / Height (cm): " + @person.size.to_s + ' cm'
        end
        pdf.move_down 1.mm
        if @person.weight.present? 
          text "Gewicht / Weight: " + @person.weight.to_s + ' kg'
        end       
        pdf.move_down 1.mm
        if @person.medicine_bloodtype.present? 
          text "Blutgruppe / Blood Type: " + @person.medicine_bloodtype
        end    


 
        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_vaccination_header'), size: 12
        text '(' + I18n.t('activerecord.attributes.person.medicine_vaccination_help') + ')', size: 8
        text 'Vaccinations', size: 6
        pdf.move_down 3.mm

        if @person.medicine_vaccination_tetanus
          vac_text = 'Tetanus: ja /yes , am / on '
          if @person.medicine_vaccination_tetanus_date.present?
            vac_text += @person.medicine_vaccination_tetanus_date.to_s
          end
        else
          vac_text = 'Tetanus: nein / no'
        end
        text vac_text
        pdf.move_down 1.mm

        if @person.medicine_vaccination_fsme
          vac_text = 'FSME/TBE: ja /yes , am / on '
          if @person.medicine_vaccination_fsme_date.present?
            vac_text += @person.medicine_vaccination_fsme_date.to_s
          end
        else
          vac_text = 'FSME/TBE: nein / no'
        end
        text vac_text
        pdf.move_down 1.mm

        if @person.medicine_vaccination_masern
          vac_text = 'Masern/measles: ja /yes , am / on '
          if @person.medicine_vaccination_masern_date.present?
            vac_text += @person.medicine_vaccination_masern_date.to_s
          end
        else
          vac_text = 'Masern/measles: nein / no'
        end
        text vac_text
        pdf.move_down 1.mm

        if @person.medicine_vaccination_meningokokken
          vac_text = 'Meningokokken/meningococcal: ja /yes , am / on '
          if @person.medicine_vaccination_meningokokken_date.present?
            vac_text += @person.medicine_vaccination_meningokokken_date.to_s
          end
        else
          vac_text = 'Meningokokken/meningococcal: nein / no'
        end
        text vac_text
        pdf.move_down 1.mm

        if @person.medicine_vaccination_hepatitisa
          vac_text = 'Hepatitis A: ja /yes , am / on '
          if @person.medicine_vaccination_hepatitisa_date.present?
            vac_text += @person.medicine_vaccination_hepatitisa_date.to_s
          end
        else
          vac_text = 'Hepatitis A: nein / no'
        end
        text vac_text
        pdf.move_down 1.mm

        if @person.medicine_vaccination_hepatitisb
          vac_text = 'Hepatitis B: ja /yes , am / on '
          if @person.medicine_vaccination_hepatitisb_date.present?
            vac_text += @person.medicine_vaccination_hepatitisb_date.to_s
          end
        else
          vac_text = 'Hepatitis B: nein / no'
        end
        text vac_text
        pdf.move_down 1.mm

        if @person.medicine_vaccination_covid19
          vac_text = 'SARS-CoV-2: ja /yes , am / on '
          if @person.medicine_vaccination_covid19_date.present?
            vac_text += @person.medicine_vaccination_covid19_date.to_s
          end
        else
          vac_text = 'SARS-CoV-2: nein / no'
        end
        text vac_text
        pdf.move_down 1.mm

        if @person.medicine_vaccination.present?
          text "Sonstiges / Other:" + @person.medicine_vaccination
          pdf.move_down 1.mm
        end

        pdf.move_down 3.mm
        text "Körperliche Krankheiten und Besonderheiten / Physical illnesses and restrictions", size: 12
    
        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_allergies'), size: 10
        text I18n.t('activerecord.attributes.person.medicine_allergies_info')
        text 'The following allergies exist (e.g. to medications, proven food allergies, '\
        + 'hay fever, etc.) with the following symptoms'
        pdf.move_down 1.mm
        text (@person.medicine_allergies.empty? ?
          '--' : @person.medicine_allergies)

        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_other'), size: 10
        text 'drug incompatibility'
        pdf.move_down 1.mm
        text (@person.medicine_other.empty? ? '--' : @person.medicine_other)

        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_abnormalities'), size: 10
        text I18n.t('activerecord.attributes.person.medicine_abnormalities_info')
        text 'Chronic diseases (diabetes, asthma, epilepsy, …):'
        pdf.move_down 1.mm
        text (@person.medicine_abnormalities.empty? ?
          '--' : @person.medicine_abnormalities)
            
        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_continous_medication'), size: 10
        text I18n.t('activerecord.attributes.person.medicine_continous_medication_info')
        text 'regular medication'
        pdf.move_down 1.mm
        text (@person.medicine_continous_medication.empty? ?
          '--' : @person.medicine_continous_medication)

        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_preexisting_conditions'), size: 10
        text 'Major operations, bone fractures'
        pdf.move_down 1.mm
        text (@person.medicine_preexisting_conditions.empty? ?
          '--' : @person.medicine_preexisting_conditions)
                                                           
 
        pdf.move_down 3.mm
        if @person.can_swim
          text "Geübter Schwimmer / Good swimmer: ja / yes ", size: 10
        end
  
        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_mobility_needs'), size: 10
        text 'Sport restrictions '
        pdf.move_down 1.mm
        text (@person.medicine_mobility_needs.empty? ?
          '--' : @person.medicine_mobility_needs)

        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_support'), size: 10
        text 'problems with long-distance flights '
        pdf.move_down 1.mm
        text (@person.medicine_support.empty? ?
          '--' : @person.medicine_support)
 
        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_important'), size: 10
        text 'This is also important '
        pdf.move_down 1.mm
        text (@person.medicine_important.nil? ?
          '--' : @person.medicine_important)
  
        pdf.move_down 3.mm
        text "Mentale Gesundheit / Mental Health", size: 12
      
        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_therapies'), size: 10
        text 'mental health issues or therapies (ADHD, depression, …)'
        pdf.move_down 1.mm
        text (@person.medicine_therapies.nil? ?
          '--' : @person.medicine_therapies)
      
        pdf.move_down 3.mm      
        text "Wichtige medizinische Hinweise", size: 12
        pdf.move_down 3.mm 
        text "Mündige Minderjährige, bei denen Urteils- und Einsichtsfähigkeit gegeben ist – im Allgemeinen also Jugendliche über 14 Jahre – sind gesetzlich berechtigt, in medizinisch notwendige Heilbehandlungen selbst einzuwilligen. Selbstverständlich werden wir zusätzlich die*den Erziehungsberechtige*n bzw. angegebene Kontaktperson bei notwendigen Heilbehandlungen oder anderen Notfällen kontaktieren."
        pdf.move_down 1.mm 
        text "Sollte eine Einwilligung in eine Heilbehandlung ohne Zeitverzögerung erforderlich sein, werden der Care-Verantwortliche im Kontingent, Mag. Ernst M. Felberbauer, und die Kontingentsärztin, Dr. Lisa Prior, diese in Vertretung des*der Teilnehmer*in oder der Erziehungsberechtigten geben."
        pdf.move_down 1.mm 
        text "Nach Rücksprache mit der Botschaft der Republik Korea in Österreich und dem BMeiA gibt es zum Zeitpunkt September 2021 keine Impfvorschriften für die Einreise nach Südkorea."
        pdf.move_down 5.mm 
        text "Notfalltelefonnummer der PPÖ in Österreich während des Lagers: +43 1 523 31 95-22", color: 'ff0000', size:10
        pdf.move_down 5.mm
        text '' + (of_legal_age ? 'Ich habe' : 'Wir haben') + ' den Gesundheitsfragebogen '\
        + 'wahrheitsgemäß ausgefüllt.'
        pdf.move_down 1.mm
        text '' + (of_legal_age ? 'Ich bin' : 'Wir sind') + ' damit einverstanden, dass die '\
        + 'persönlichen Daten sowie Behandlungsdaten zum Zwecke der gesetzlich '\
        + 'vorgeschriebenen Dokumentation gespeichert werden. Nach Ablauf der gesetzlichen '\
        + 'Aufbewahrungsfrist werden die Daten gelöscht.'
        pdf.move_down 3.mm
        signature.draw
        pdf.move_down 3.mm

        text 'Für Rückfragen erreicht ihr uns unter '\
        + %(<link href="mailto:care@jamboree.at">care@jamboree.at.</link>), :inline_format => true
      end
    end
    # rubocop:enable Metrics/AbcSize,Metrics/MethodLength,Style/MultilineTernaryOperator,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
  end
  # rubocop:enable Metrics/ClassLength
end
