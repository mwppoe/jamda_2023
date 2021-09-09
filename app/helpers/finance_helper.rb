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
        [' ', 'Gesamtbeitrag', 'Dez 21', 'Jan 22', 'Feb 22', 'Mär 22', 'Apr 22', 'Mai 22', 'Jun 22',
         'Jul 22', 'Aug 22', 'Sep 22', 'Okt 22', 'Nov 22', 'Dez 22', 'Jan 23', 'Feb 23', 'Mär 23',
         'Apr 23', 'Mai 23'],
        ['Teilnehmer*in', ' 4.100 € ', ' 150 € ', ' 150 € ', ' 150 € ', ' 150 € ', ' 150 € ',
         ' 150 € ', ' 150 € ', ' 250 € ', ' 250 € ', ' 250 € ', ' 250 € ', ' 250 € ', ' 300 € ',
         ' 300 € ', ' 300 € ', ' 300 € ', ' 300 € ', ' 300 € '],
        ['Patrullenbetreuer*in', ' 3.250 € ', ' 150 € ', ' 150 € ', ' 150 € ', ' 150 € ', ' 150 € ',
         ' 150 € ', ' 150 € ', ' 200 € ', ' 200 € ', ' 200 € ', ' 200 € ', ' 200 € ', ' 200 € ',
         ' 250 € ', ' 250 € ', ' 250 € ', ' 250 € ', ' -   € '],
        ['IST', ' 1.650 € ', ' 100 € ', ' 100 € ', ' 100 € ', ' 100 € ', ' 100 € ', ' 100 € ',
         ' 100 € ', ' 100 € ', ' 100 € ', ' 100 € ', ' 100 € ', ' 100 € ', ' 100 € ', ' 100 € ',
         ' 100 € ', ' 100 € ', ' 50 € ', ' -   € '],
        ['CMT', ' 1.300 € ', ' 100 € ', ' 100 € ', ' 100 € ', ' 100 € ', ' 100 € ',
         ' 100 € ', ' 100 € ', ' 100 € ', ' 100 € ', ' 100 € ', ' 100 € ', ' 100 € ', ' 100 € ',
         ' -   € ', ' -   € ', ' -   € ', ' -   € ', ' -   € ']
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
      case role
      when 'Teilnehmer*in'
        'Teilnehmer*in einer Unit'
      when 'Patrullenbetreuer*in'
        'Patrullenbetreuer*in einer Unit'
      else
        role
      end
    end

    # rubocop:disable Metrics/MethodLength
    def package(role)
      case role
      when 'Teilnehmer*in'
        'die Vor- und Nachbereitung in Deutschland,'\
        + ' die Teilnahme an den Akklimatisierungstagen in Südkorea,'\
        + ' die Teilnahme am 25. World Scout Jamboree in Südkorea,'\
        + ' die Reise nach Südkorea und eine Vor- oder Nachtour'
      when 'Patrullenbetreuer*in'
        'die Vor- und Nachbereitung in Deutschland,'\
        + ' die Teilnahme an den Akklimatisierungstagen in Südkorea,'\
        + ' die Teilnahme am 25. World Scout Jamboree in Südkorea,'\
        + ' die Reise nach Südkorea und eine Vor- oder Nachtour'
      when 'CMT'
        'die Vor- und Nachbereitung in Deutschland,'\
        + ' die Teilnahme an den Akklimatisierungstagen in Südkorea und'\
        + ' die Teilnahme am 25. World Scout Jamboree in Südkorea'
      else
        'die Vor- und Nachbereitung in Deutschland und'\
        + ' die Teilnahme am 25. World Scout Jamboree in Südkorea'
      end
    end
    # rubocop:enable Metrics/MethodLength


    def package_time(role)
      case role
      when 'Teilnehmer*in'
        '20 bis 25 Tage'
      when 'Patrullenbetreuer*in'
        '20 bis 25 Tage'
      when 'CMT'
        '13 bis 25 Tage'
      else
        '13 bis 15 Tage'
      end
    end

  end
end
