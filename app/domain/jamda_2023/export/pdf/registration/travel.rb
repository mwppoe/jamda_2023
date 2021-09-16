# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_jamda_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/mwppoe/jamda_2023.

module Jamda2023
  module Export::Pdf::Registration
    # rubocop:disable Metrics/ClassLength
    class Travel < Section
      include FinanceHelper

      def render
        pdf.y = bounds.height - 60
        bounding_box([0, 230.mm], width: bounds.width, height: bounds.height - 200) do
          font_size(8) do
            text list, style: :italic, width: bounds.width
          end
        end
      end

      # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      def list
        pdf.start_new_page
        text 'Teilnahmebedingungen des österreichischen Kontingents am 25. World Scout Jamboree in Südkorea', size: 14
        pdf.move_down 5.mm
        text 'v1.0 vom 10.09.2021'
        pdf.move_down 5.mm
        text 'Zahlungsplan', size: 12
        pdf.move_down 1.mm
        pdf.make_table(payment_array_by(@person.role_wish), cell_style: { padding: 5, border_width: 0, inline_format: true, size: 8 }).draw
        pdf.move_down 5.mm
        text 'Die Beträge sind bis zu den o.g. Stichtagen auf das Konto der Pfadfinder und Pfadfinderinnen Österreichs (IBAN: AT48 2011 1280 2138 5102) zu überweisen. Als Verwendungszweck bitte den vollständigen Namen sowie die Scout-ID der teilnehmenden Person angeben. Für Rückfragen stehen wir gerne unter '\
        + %(<link href="mailto:cashier@jamboree.at">cashier@jamboree.at</link> zur Verfügung), :inline_format => true
        pdf.move_down 5.mm
        text 'Stornobedingungen', size: 12
        pdf.move_down 1.mm
        text 'Bis 31.12.2021: Zahlungen werden refundiert'
        pdf.move_down 1.mm
        if @person.role_wish == 'Teilnehmer*in'
          text 'Bis 31.07.2022: Abmeldung mit Nennung einer Ersatzperson möglich, Zahlungen werden refundiert. Sollte keine Ersatzperson gemeldet werden, wird die bisherige Anzahlung einbehalten.'
          pdf.move_down 1.mm
          text 'Bis 30.11.2022: Stornokosten 1.520 € (bisherige Anzahlung)'
          pdf.move_down 1.mm
          text 'Bis 31.05.2023: Stornokosten 2.520 € (bisherige Anzahlung)'
        end
        if @person.role_wish == 'Patrullenbetreuer*in'
          text 'Bis 31.07.2022: Abmeldung mit Nennung einer Ersatzperson möglich, Zahlungen werden refundiert. Sollte keine Ersatzperson gemeldet werden, wird die bisherige Anzahlung einbehalten.'
          pdf.move_down 1.mm
          text 'Bis 30.11.2022: Stornokosten 1.520 € (bisherige Anzahlung)'
          pdf.move_down 1.mm
          text 'Bis 31.05.2023: Stornokosten 2.520 € (bisherige Anzahlung);'
        end        
        if @person.role_wish == 'IST'
          text 'Bis 31.07.2022: Abmeldung mit Nennung einer Ersatzperson möglich, Zahlungen werden refundiert. Sollte keine Ersatzperson gemeldet werden, wird die bisherige Anzahlung einbehalten.'
          pdf.move_down 1.mm
          text 'Bis 30.11.2022: Stornokosten 665 € (bisherige Anzahlung)'
          pdf.move_down 1.mm
          text 'Bis 31.05.2023: Stornokosten 965 € (bisherige Anzahlung)'
        end       
        if @person.role_wish == 'CMT'
          text 'Bis 31.07.2022: Abmeldung mit Nennung einer Ersatzperson möglich, Zahlungen werden refundiert. Sollte keine Ersatzperson gemeldet werden, wird die bisherige Anzahlung einbehalten.'
          pdf.move_down 1.mm
          text 'Bis 30.11.2022: Stornokosten 1.300 € (bisherige Anzahlung)'
          pdf.move_down 1.mm
          text 'Bis 31.05.2023: Stornokosten 2.300 € (bisherige Anzahlung)'
        end       
        pdf.move_down 1.mm
        text 'Danach: Verrechnung des Gesamtpreises. Der volle Teilnahmebeitrag ist auch bei unverschuldeter Nichtteilnahme (z.B. Erkrankung) zu leisten. Eine Rückerstattung von Beiträgen ist über die Reiserücktrittsversicherung abzuwickeln.'
        pdf.move_down 5.mm
        text 'Verhalten der Teilnehmer*innen', size:12
        pdf.move_down 1.mm
        text 'Die Kontingentsleitung behält sich vor, Mitreisende aufgrund ihres Verhaltens und auftretenden Verstößen gegen rechtliche, zwischenmenschliche oder pfadfinderische Regeln oder wegen gesundheitlichen Veränderungen nicht mitzunehmen bzw. während der Reise nach Hause zu schicken. Der Jamboree-Beitrag wird in diesem Fall nicht rückerstattet, zusätzlich entstandene Kosten (z.B. Flug, Hotel, Begleitperson …) sind vom Mitreisenden zu tragen.'
        pdf.move_down 5.mm
        text 'Teilnahmepflicht', size:12
        pdf.move_down 1.mm
        text 'Treffen zu der Vor- und Nachbereitung sind grundsätzlich Pflicht für alle Teilnehmer*innen des Jamboree.'
        pdf.move_down 5.mm
        text 'Überschuss / Unterdeckung', size:12
        pdf.move_down 1.mm
        text 'Der Teilnahmebeitrag beinhaltet Sicherheiten für Währungsschwankungen und unvorhergesehene Ereignisse. Sollte das österreichische Kontingent einen Überschuss aus dem Projekt Jamboree 2023 erwirtschaften, so wird dieser an alle Kontingentsmitglieder refundiert.'
        pdf.move_down 5.mm
        text 'Foto- und Filmrechte / Verwendung meiner Daten', size:12
        pdf.move_down 1.mm
        text 'Die Foto- bzw. Filmaufnahmen, die im Rahmen der Veranstaltung von mir/meinem Kind erstellt werden, dürfen zum Zwecke der internen und externen Öffentlichkeitsarbeit der Pfadfinder und Pfadfinderinnen Österreichs (PPÖ) verwendet werden. Dies kann Druck- und Onlinemedien innerhalb der PPÖ und der Weltverbände WAGGGS und WOSM beinhalten bzw. externe Medien, die die Arbeit derselben bewerben bzw. darüber berichten. Es wird keinerlei zeitliche und örtliche Beschränkung vereinbart. Die von mir/von meinem Kind zur Verfügung gestellten Daten dürfen an Dritte weitergegeben werden, sofern dies zur Vorbereitung in Österreich und der Reiseorganisation nötig ist.'
        pdf.move_down 7.mm
        text 'Storno/Reiserücktritt - COVID-19', size:12
        text 'Wir weisen darauf hin, dass der Teilnahmebetrag keine Storno- bzw. Reiserücktrittsversicherung umfasst. Auch ein Projektausfall aufgrund von COVID bzw. anderer nicht vorhersehbarer Ereignisse ist nicht versichert. Aus den Erfahrungen letzter Veranstaltungen empfehlen wird dringend jedem/jeder Mitreisenden, privat eine Storno- und Reiserücktrittsversicherung abzuschließen. In Bezug auf Corona gelten die vom Gastgeberland zum Zeitpunkt der Einreise vorgegebenen Bestimmungen. Wenn aufgrund persönlicher Einstellungen diese nicht akzeptiert werden können, ist auch dahingehend keine Versicherung inkludiert. Genauere Informationen können über care@jamboree.at eingeholt werden.'
   
      end
      # rubocop:enable Metrics/AbcSize,Metrics/MethodLength
    end
    # rubocop:enable Metrics/ClassLength
  end
end
