# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_jamda_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/mwppoe/jamda_2023.


module FinanceHelper
  extend ActiveSupport::Concern

  included do
    # rubocop:disable Metrics/MethodLength
    def payment_array
      [
        [' ', 'Gesamtbeitrag', 'bei Anmeldung', 'bis 31.05.2022', 'bis 30.11.2022', 'bis 31.05.2023'],
        ['Teilnehmer*in', ' 3.520 € ', ' 520 € ', ' 1.000 € ', ' 1.000 € ', ' 1.000 € '],
        ['Patrullenbetreuer*in', ' 3.520 € ', ' 520 € ', ' 1.000 € ', ' 1.000 € ', ' 1.000 € '],
        ['IST', ' 1.265 € ', ' 365 € ', ' 300 € ', ' 300 € ', ' 300 € '],
        ['CMT', ' 3.300 € ', ' 300 € ', ' 1000 € ', ' 1000 € ', ' 1000 € ']
      ]
    end
    # rubocop:enable Metrics/MethodLength

    def payment_array_by(role)
      payment_array.select { |line| (line[0] == role || line[0] == ' ') }
    end

    def payment_value(role)
      payment_array_by(role)[1][1]
    end

    def role_full_name(role)
      #case role
      # when 'Teilnehmer*in'
      #  'Teilnehmer*in einer Unit'
      #when 'Patrullenbetreuer*in'
      #  'Patrullenbetreuer*in einer Unit'
      #else
        role
      #end
    end

    # rubocop:disable Metrics/MethodLength
    def package(role)
      case role
      when 'Teilnehmer*in'
        'die Vor- und Nachbereitung in Österreich,'\
        + ' das Vorprogramm in Südkorea,'\
        + ' die Kontingentsausrüstung'\
        + ' und die Teilnahme am 25. World Scout Jamboree in Südkorea'\
      when 'Patrullenbetreuer*in'
        'die Vor- und Nachbereitung in Österreich,'\
        + ' das Vorprogramm in Südkorea,'\
        + ' die Kontingentsausrüstung '\
        + ' und die Teilnahme am 25. World Scout Jamboree in Südkorea'\
      when 'CMT'
        'die Vor- und Nachbereitung in Österreich,'\
        + ' das Vorprogramm in Südkorea (wenn du nicht daran teilnimmst, wird es natürlich abgezogen),'\
        + ' die Kontingentsausrüstung,'\
        + ' und die Teilnahme am 25. World Scout Jamboree in Südkorea'\
      else
        'die Vor- und Nachbereitung in Österreich'\
        + ' und die Teilnahme am 25. World Scout Jamboree in Südkorea'
      end
    end
    # rubocop:enable Metrics/MethodLength


    def package_time(role)
      case role
      when 'Teilnehmer*in'
        '20 Tage'
      when 'Patrullenbetreuer*in'
        '20 Tage'
      when 'CMT'
        '15 bis 20 Tage'
      else
        '13 bis 15 Tage'
      end
    end

  end
end