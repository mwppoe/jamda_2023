# encoding: utf-8

#  Copyright (c) 2012-2020, CVP Schweiz. This file is part of
#  hitobito_cvp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_cvp.

class AddJamboreepayments < ActiveRecord::Migration[6.0]
  def change
    create_table :jamboreepayments do |t|
      t.belongs_to :people, null: false
      t.decimal :amount, precision: 15, scale: 2, default: 0, null: false
      t.string :booking_number, null: false
      t.date :booking_date, null: false
      t.timestamps
    end
  end
end
