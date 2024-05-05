# frozen_string_literal: true

class AddPendingIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :likes, %i[likeable_id likeable_type user_id], unique: true
    add_index :reports, %i[reportable_id reportable_type user_id], unique: true
  end
end
