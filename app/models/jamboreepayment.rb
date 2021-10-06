# encoding: utf-8

# == Schema Information
#
# Table name: Jamboreeayment
#
#  id          :integer          not null, primary key
#  amount      :decimal(15, 2)   not null
#  booking_number   :string(255)
#  booking_date  :date          not null
#
# Indexes
#
#

#  Copyright (c) 2012-2017, Jungwacht Blauring Schweiz. This file is part of
#  hitobito and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/mwppoe/jamda_2023.


class Jamboreepayment < ActiveRecord::Base

  belongs_to :people

  #validates :reference, uniqueness: { scope: :invoice_id, allow_nil: true, case_sensitive: false }

  #before_validation :set_received_at
  #after_create :update_invoice

  #scope :list, -> { order(received_at: :desc) }

  #attr_writer :esr_number

  #validates_by_schema
  
  private

 
end
