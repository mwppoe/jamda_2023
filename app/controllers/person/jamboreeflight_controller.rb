# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_jamda_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/mwppoe/jamda_2023.

class Person::JamboreeflightController < ApplicationController
  include UnitKeyHelper

  before_action :authorize_action
  decorates :group, :person

  def index
    @group ||= Group.find(params[:group_id])
    @person ||= group.people.find(params[:id])
    jamboreepayment ||= Jamboreepayment.where(people_id: @person.id)
    @manage = manage
    @flighttext = ''

    @jf1 = "23JUL VIENNA VIE 1A- TAIPEI TPE CI 064 11:20 05:30+ G OK
    24JUL TAIPEI T 1 - SEOUL ICN CI 160 07:40 11:10 G OK
    12AUG SEOUL IC 2 - TAIPEI TPE CI 161 12:35 14:10 G OK
    12AUG TAIPEI TPE 1 - VIENNA VIE CI 063 23:20 06:30+ G OK"

    @jf2 = "24JUL VIENNA VIE 1A- TAIPEI TPE CI 064 11:20 05:30+ G OK
    25JUL TAIPEI TPE 1 - SEOUL ICN CI 160 07:40 11:10 G OK
    13AUG SEOUL ICN 2 - TAIPEI TPE CI 161 12:35 14:10 G OK
    13AUG TAIPEI TPE 1 - VIENNA VIE CI 063 23:20 06:30+ G OK"

    @jf3 = "25JUL VIENNA VIE1A - TAIPEI TPE CI 064 11:20 05:30+ G OK
    26JUL TAIPEI TP 1 - SEOUL ICN CI 160 07:40 11:10 G OK
    14AUG SEOUL ICN 2 - TAIPEI TPE CI 161 12:35 14:10 G OK
    14AUG TAIPEI TP 1 - VIENNA VIE CI 063 23:20 06:30+ G OK"

    @jf4 = "25JUL VIENNA VI1A - TAIPEI TPE CI 064 11:20 05:30+ T OK
    26JUL TAIPEI TP 1 - SEOUL ICN CI 160 07:40 11:10 T OK
    24AUG SEOUL ICN 2 - TAIPEI TPE CI 161 12:35 14:10 Q OK
    24AUG TAIPEI TPE 1- VIENNA VIE CI 063 23:20 06:30+ Q OK"

    @jf5 = "14JUL VIENNA VIE1A - TAIPEI TPE CI 064 11:20 05:30+ R OK
    15JUL TAIPEI TPE 1 - SEOUL ICN CI 160 07:40 11:10 R OK
    14AUG SEOUL ICN 2 - TAIPEI TPE CI 161 12:35 14:10 Q OK
    14AUG TAIPEI TPE 1 - VIENNA VIE CI 063 23:20 06:30+ Q OK"

    @jf6 = "25JUL VIENNA VIE1A - TAIPEI TPE CI 064 11:20 05:30+ T OK
    26JUL TAIPEI TPE 1 - SEOUL ICN CI 160 07:40 11:10 T OK
    23AUG SEOUL ICN 2 - TAIPEI TPE CI 161 12:35 14:10 R OK
    27AUG TAIPEI TPE 1 - VIENNA VIE CI 063 23:20 06:30+ R OK"

    @jf7 = "25JUL INNSBRUCK - FRANKFURT FRA EN 8051 10:30 11:35 U OK
    25JUL FRANKFURT - SEOUL ICN LH 712 15:25 09:45+ U OK
    15AUG SEOUL ICN - FRANKFURT FRA LH 713 12:20 18:30 U OK
    15AUG FRANKFURT - INNSBRUCK INN EN 8056 21:15 22:25 U OK"

    @jf8 = "27JUL VIENNA VIE1A - TAIPEI TPE CI 064 11:20 05:30+ G OK
    28JUL TAIPEI TP 1 - SEOUL ICN CI 160 07:40 11:10 G OK
    16AUG SEOUL ICN 2 - TAIPEI TPE CI 161 12:35 14:10 G OK
    16AUG TAIPEI TP 1 - VIENNA VIE CI 063 23:20 06:30+ G OK"

    @jf9 = "27JUL VIENNA VIE1A - TAIPEI TPE CI 064 11:20 05:30+ Q OK
    28JUL TAIPEI TPE 1 - SEOUL ICN CI 160 07:40 11:10 Q OK
    20AUG SEOUL ICN 2 - TAIPEI TPE CI 163 20:45 22:20 R OK
    20AUG TAIPEI TPE1 - VIENNA VIE CI 063 23:20 06:30+ R OK"

    @jf10 = "27JUL VIENNA VIE 1A- TAIPEI TPE CI 064 11:20 05:30+ T OK
    28JUL TAIPEI TPE 1 - SEOUL ICN CI 160 07:40 11:10 T OK
    13AUG SEOUL ICN 2 - TAIPEI TPE CI 161 12:35 14:10 T OK
    13AUG TAIPEI TPE 1 - VIENNA VIE CI 063 23:20 06:30+ T OK"

    @jf11 = "28JUL VIENNA VIE1A - TAIPEI TPE CI 064 11:20 05:30+ R OK
    29JUL TAIPEI TPE 1 - SEOUL ICN CI 160 07:40 11:10 R OK
    16AUG SEOUL ICN 2 - TAIPEI TPE CI 161 12:35 14:10 Q OK
    16AUG TAIPEI TPE 1 - VIENNA VIE CI 063 23:20 06:30+ Q OK"

    @jf12 = "23JUL VIENNA VIE1A - TAIPEI TPE CI 064 11:20 05:30+ R OK
    24JUL TAIPEI TPE 1 - SEOUL ICN CI 160 07:40 11:10 R OK
    13AUG SEOUL ICN 2 - TAIPEI TPE CI 161 12:35 14:10 R OK
    13AUG TAIPEI TPE 1 - VIENNA VIE CI 063 23:20 06:30+ R OK"

    @jf13 = "23JUL VIENNA VIE1A - TAIPEI TPE CI 064 11:20 05:30+ V OK
    24JUL TAIPEI TPE 1 - SEOUL ICN CI 160 07:40 11:10 V OK
    27AUG SEOUL ICN 2 - TAIPEI TPE CI 163 20:45 22:20 R OK
    27AUG TAIPEI TPE 1 - VIENNA VIE CI 063 23:20 06:30+ R OK"

    @jf14 = "27.07.2023  MUCICN   15:55 - 09:55 (+1)   LH0718
    16.08.2023   ICNMUC   11:40 - 17:50   LH0719"

    


    case @person.airport
    when "F01"
      @flighttext = @jf1
    when "F02"
      @flighttext = @jf2      
    when "F03"
      @flighttext = @jf3      
    when "F04"
      @flighttext = @jf4
    when "F05"
      @flighttext = @jf5      
    when "F06"
      @flighttext = @jf6      
    when "F07"
      @flighttext = @jf7      
    when "F08"
      @flighttext = @jf8      
    when "Fß9"
      @flighttext = @jf9      
    when "F10"
      @flighttext = @jf10      
    when "F11"
      @flighttext = @jf11     
    when "F12"
      @flighttext = @jf12     
    when "F13"
      @flighttext = @jf13     
    when "F14"
      @flighttext = @jf14
    end  
    # flash[:alert] = params[:url]

    @paymententries = ''
    count = 1
    sum = 0

    if @person.role_wish == 'Patrullenbetreuer*in'
      fullamount = 3520
    end
    if @person.role_wish == 'Teilnehmer*in'
      fullamount = 3520
    end
    if @person.role_wish == 'IST'
      fullamount = 1265
    end
    if @person.role_wish == 'CMT'
      fullamount = 3300
    end

    zusatz = 0
    temp = (@person.add_good_1).to_i*20
    zusatz +=temp.to_i

    temp = (@person.add_good_2).to_i*20
    zusatz +=temp.to_i

    temp = (@person.add_good_3).to_i*10
    zusatz +=temp.to_i

    temp = (@person.add_good_4).to_i*5
    zusatz +=temp.to_i

    temp = (@person.add_good_5).to_i
    zusatz +=temp.to_i

    fullamount += zusatz

    jamboreepayment.each do |payment|
      @paymententries += count.to_s + '. Zahlung (' + payment.booking_date.to_s + '):' + "\n"
      @paymententries += 'Buchungsnummer ' + payment.booking_number + ': € ' + payment.amount.to_s + "\n\n"
      count +=1
      sum += payment.amount
    end   

    if sum > 0 
     @paymententries += 'Summe: ' + sum.to_s + "\n"
    else
      @paymententries += 'Es wurden noch keine Zahlungen verbucht!' + "\n"
    end  
     @paymententries += 'Es fehlen noch ' + (fullamount-sum).to_s + '€ auf den vollen Betrag. (' + (zusatz).to_s + ' € durch Zusatzbestellungen)'
     @paymententries += "\n" + "\n" + "\n" + 'Überweisungen werden in der Regel am 2. und am 16. des Monats vom Jamboree-Konto in die Jamda übertragen.'
  end

  private

  def entry
    @person ||= Person.find(params[:id])
  end

  def manage
    current_user.role?('Group::Root::Admin') ||
    current_user.role?('Group::Root::Leader') ||
    current_user.role?('Group::UnitSupport::Leader') ||
    current_user.role?('Group::UnitSupport::Member') ||
    current_user.role?('Group::Ist::Leader')
  end

  def authorize_action
    authorize!(:edit, entry)
  end



end
