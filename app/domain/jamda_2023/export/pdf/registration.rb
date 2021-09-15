# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_jamda_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/mwppoe/jamda_2023.

module Jamda2023
  module Export::Pdf
    module Registration
      class Runner
        def render(person, pdf_preview)
          new_pdf(person, pdf_preview).render
        end

        # rubocop:disable Metrics/AbcSize
        # rubocop:disable Metrics/MethodLength
        def new_pdf(person, pdf_preview)
          pdf = Prawn::Document.new(page_size: 'A4',
                                    page_layout: :portrait,
                                    margin: 2.cm,
                                    bottom_margin: 1.cm)

          @person = person

          sections.each { |section| section.new(pdf, person).render }

          # define header & footer variables
          imagePath = '../hitobito_jamda_2023/app/assets/images/'

          pdf.y = 850
          # pdf.page_count = 0
          pdf.repeat :all do
            # define header
 
            #logo = Rails.root.join(imagePath + 'jamb-logo.png')
            #pdf.bounding_box [350, 770], width: pdf.bounds.width, height: 375 do
            #  pdf.image logo, width: 100
            #  # pdf.move_up 15
            #end


            header = Rails.root.join(imagePath + 'header.png')
            pdf.bounding_box [-58, 815], width: pdf.bounds.width, height: 275 do
              pdf.image header, width: 600
            end

            if pdf_preview
              pdf.bounding_box [150, 800], width: pdf.bounds.width, height: 200 do
                pdf.transparent(0.5) do
                  pdf.text 'Vorschau:', size: 24
                  pdf.text 'Nicht zum upload gedacht!', size: 12
                  pdf.text 'Für die Anmeldung nutze bitte das ', size: 12
                  pdf.text 'PDF unter "Verbindlich drucken".', size: 12
                end
              end
            end

            footer = Rails.root.join(imagePath + 'footer.png')
            pdf.bounding_box [-58, 30], width: pdf.bounds.width, height: 275 do
              pdf.image footer, width: 600
            end

            pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 45], width: pdf.bounds.width do
              pdf.text 'Reg-Nr. ' + person.id.to_s + ' - ' + person.full_name + ' '\
               + person.birthday.strftime('%d.%m.%Y'), size: 8
            end
          end

          pdf.number_pages 'Seite <page> von <total>',
                           at: [pdf.bounds.left, pdf.bounds.bottom], size: 8

          pdf
        end
        # rubocop:enable Metrics/AbcSize
        # rubocop:enable Metrics/MethodLength

        def customize(pdf)
          pdf.font_size 9
          pdf
        end

        def sections
          if @person.role_wish == 'Patrullenbetreuer*in'
            return [Contract, Travel, Medicin, DataProcessing]
          end
          if @person.role_wish == 'CMT'
            return [Contract, Travel, Medicin, DataProcessing]
          end

          [Contract, Travel, Medicin]
        end
      end
      mattr_accessor :runner
      self.runner = Runner

      def self.render(person, pdf_preview)
        runner.new.render(person, pdf_preview)
      end

      def self.new_pdf(person, pdf_preview)
        runner.new.new_pdf(person, pdf_preview)
      end


    end
  end
end
