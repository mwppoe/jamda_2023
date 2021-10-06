# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_jamda_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/mwppoe/jamda_2023.
#require 'prawn/qrcode'
require 'digest'

module Jamda2023
  module Export::Pdf::Registration
    class Contract < Section
      include FinanceHelper

      # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Metrics/CyclomaticComplexity
      def render
 #       pdf.bounding_box [pdf.bounds.left, pdf.bounds.top], width: pdf.bounds.width do
 #         qrcode = RQRCode::QRCode.new(qrcode_content, level: :h, size: 10)
 #         pdf.render_qr_code(qrcode, dot: 1.5)
 #       end
        pdf.y = bounds.height - 60
        bounding_box([0, 230.mm], width: bounds.width, height: bounds.height - 200) do
          font_size(8) do
            text list, style: :italic, width: bounds.width
          end
        end
      end

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
        else 
       #elsif @person.additional_contact_single
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

        #if Rails.env.development?
        #  text qrcode_content
        #end

        pdf.move_down 3.mm
        text 'Was muss ich mit der Anmeldung machen?', size: 12
        text 'Die Anmeldung muss'
        text '1. vollständig unterschrieben werden'
        text '2. auf jamda.jamboree.at unter '\
        + '"Upload>Anmeldung hochladen" hochgeladen werden'
        text '3. am ersten Treffen der entsprechenden Betreuungsperson im Original überreicht werden'
        pdf.move_down 3.mm
        pdf.stroke_horizontal_rule

        pdf.move_down 3.mm
        text 'Anmeldung', size: 12

        text 'von ' + @person.full_name + ', geboren am ' + @person.birthday.strftime('%d.%m.%Y') \
        + ', wohnhaft in ' + @person.address + ', ' + @person.zip_code + ', ' + @person.town 
        text ' für das österreichische Kontingent zum 25. World Scout Jamboree 2023 in Südkorea.'

        pdf.move_down 3.mm
        text "Die Teilnahme als '#{role_full_name(@person.role_wish)}' "\
        + "im österreichischen Kontingent kostet #{payment_value(@person.role_wish)} und"\
        " beinhaltet #{package(@person.role_wish)}."
        text 'Die Reise ist für den Zeitraum vom 25.07 bis 13.08.2023'\
        +" geplant. Reisedauer sind #{package_time(@person.role_wish)}."

        pdf.move_down 3.mm
        text 'Hiermit ' + (of_legal_age ? 'melde ich mich, ' : 'melde ich mein Kind, ') \
        + @person.full_name + ', geboren am ' + @person.birthday.strftime('%d.%m.%Y') \
        + ", verbindlich als '#{role_full_name(@person.role_wish)}'" \
        + ' im österreichsichen Kontingent'\
        + ' zum 25. World Scout Jamboree 2023 an. Mit der Anmeldung '\
        + (of_legal_age ? 'akzeptiere ich' : 'akzeptieren wir')\
        + ' die Teilnahmebedingungen, die vom Jamboree-Kontingent vorgegeben werden.'\

        pdf.move_down 3.mm
        text 'Das Jamboree-Kontingent behält sich das Recht vor, angekündigte Programminhalte durch'\
        +' andere zu ersetzen und notwendige Änderungen des Programms, unter Wahrung'\
        +' des Gesamtcharakters der Veranstaltung vorzunehmen.'

        pdf.move_down 3.mm
        unless of_legal_age
          text 'Für die Dauer der Reise übertragen ich die Ausübung der Aufsichtspflicht und das'\
          + ' Aufenthaltsbestimmungsrecht über mein Kind dem Patrullenbetreuungs-Team. Ich bin damit'\
          + ' einverstanden, dass die Ausübung im erforderlichen Ausmaß auf volljährige'\
          + ' Patrullenbetreuer*innen übertragen wird.'
          pdf.move_down 3.mm
        end

        text 'Als Bestandteil dieser Anmeldung' + (of_legal_age ? ' habe ich ' : ' haben wir ') + ' auch '
        pdf.move_down 1.mm
        text '- die Teilnahmebedingungen des österreichischen Kontingents am 25. World Scout Jamboree in Südkorea (v1.0 vom 10.09.2021)'
        text '- zu finden unter '\
        + %(<link href="https://jamboree.at/downloads/">https://jamboree.at/downloads/</link>), :inline_format => true

        pdf.move_down 1.mm
        text 'zur Kenntnis genommen und akzeptiert.'
        pdf.move_down 3.mm
        text 'Das Gesundheitsdatenblatt im Anhang'\
          + (of_legal_age ? ' habe ich ' : ' haben wir ') + 'gesondert unterschrieben.'
        pdf.move_down 3.mm

        pdf.move_down 3.mm
        signature.draw

        pdf.move_down 5.mm

        text ''
      end

      def qrcode_content
        'http://' + ENV['RAILS_HOST_NAME'] + '/groups/' + @person.primary_group_id.to_s +
          '/people/' + @person.id.to_s + '/check/' + document_id
      end
    end
    # rubocop:enable Metrics/AbcSize,Metrics/MethodLength,Metrics/CyclomaticComplexity


  end
end
