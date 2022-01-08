# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_jamda_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/mwppoe/jamda_2023.

class Person::JamboreepaymentController < ApplicationController
  include UnitKeyHelper

  before_action :authorize_action
  decorates :group, :person

  def index
    @group ||= Group.find(params[:group_id])
    @person ||= group.people.find(params[:id])
    jamboreepayment ||= Jamboreepayment.where(people_id: @person.id)
    @manage = manage

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
     @paymententries += 'Es fehlen noch ' + (fullamount-sum).to_s + '€ auf den vollen Betrag.'
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
