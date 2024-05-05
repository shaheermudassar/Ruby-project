# frozen_string_literal: true

class AddStatusToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :status, :integer
  end
end
