# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_jamda_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/mwppoe/jamda_2023.

module Jamda2023
  module Export::Pdf::Registration
    class DataProcessing < Section
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
        pdf.move_down 3.mm
        text 'Was muss ich mit dieser Verpflichtungserklärung machen?', size: 12
        text 'Die Verpflichtungserklärung muss'
        text '1. vollständig unterschrieben werden'
        text '2. auf jamda.jamboree.at unter'\
        + ' "Upload>Verpflichtungserklärung hochladen" hochgeladen werden'
        pdf.move_down 3.mm
        pdf.stroke_horizontal_rule

        pdf.move_down 3.mm
        text 'Verpflichtungserklärung zum Datengeheimnis', size: 14
        pdf.move_down 3.mm
        text 'Ich verpflichte mich, das Datengeheimnis gemäß § 15 Datenschutzgesetz in der geltenden Fassung zu wahren und den Datenschutz und die Datensicherheit unabhängig davon, ob sich um gesetzliche Verpflichtungen oder um interne Anordnungen handelt, einzuhalten.'
        pdf.move_down 3.mm
        text 'Mir ist bekannt, '
        pdf.move_down 1.mm
        text '- dass es untersagt ist, unbefugten Personen oder unzuständigen Stellen personenbezogene Daten (Name, Geburtsdatum, Adresse, Telefonnummer) mitzuteilen oder ihnen die Kenntnisnahme zu ermöglichen, sowie Daten zu einem anderen als dem zum jeweiligen Aufgabenvollzug gehörenden Zweck zu verwenden,'
        pdf.move_down 1.mm
        text '- dass automationsunterstützt verarbeitete Daten, die mir auf Grund meiner Funktion anvertraut wurden oder zugänglich geworden sind, unbeschadet sonstiger Verschwiegenheitspflichten, nur auf Grund einer ausdrücklichen mündlichen oder schriftlichen Anordnung durch das Präsidium weitergegeben werden dürfen.'
        pdf.move_down 1.mm
        text '- dass diese Verpflichtung auch nach Beendigung meiner Tätigkeit und / oder nach dem Ausscheiden aus dem Bundesverband fortbesteht,'
        pdf.move_down 1.mm
        text '- dass weiterreichende andere Bestimmungen über die Geheimhaltungspflichten von der oben angeführten Verpflichtung unberührt bleiben, sofern sie mit dem Datenschutzgesetz nicht im Widerspruch stehen,'
        pdf.move_down 1.mm
        text '- dass Verstöße gegen die oben angeführte Verpflichtung mit Freiheits- oder Geldstrafen geahndet werden können und schadenersatzpflichtig machen können.'
        pdf.move_down 3.mm
        text 'Zusätzliche Erklärung:'
        pdf.move_down 3.mm
        text 'Im Besonderen verpflichte ich mich zur sorgfältigen Verwahrung mir anvertrauter Benutzerkennwörter, Passwörter und sonstiger Zugangsberechtigungen.'

 

        pdf.move_down 3.mm
        pdf.make_table([
                         [{ content: @person.town + ' den ' \
                          + Time.zone.today.strftime('%d.%m.%Y'), height: 30 }],
                         ['______________________________', ''],
                         [{ content: @person.full_name + ', ' + @person.address + ', ' + @person.zip_code + ' ' + @person.town, height: 30 }, '']
                       ],
                       cell_style: { width: 240, padding: 1, border_width: 0,
                                     inline_format: true }).draw
        text ''
      end
      # rubocop:enable Metrics/AbcSize,Metrics/MethodLength
    end
  end
end
