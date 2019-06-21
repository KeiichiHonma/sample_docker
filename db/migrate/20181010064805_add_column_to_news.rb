class AddColumnToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :news, :news_created_at, :datetime, after: :description
  end
end
