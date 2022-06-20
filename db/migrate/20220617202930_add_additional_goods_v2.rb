# frozen_text_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_jamda_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/mwppoe/jamda_2023.

class AddAdditionalGoodsV2 < ActiveRecord::Migration[4.2]
    def change
      add_column :people, :add_good_4, :smallint
      add_column :people, :add_good_5, :smallint
      add_column :people, :add_good_6, :smallint
    end
end
