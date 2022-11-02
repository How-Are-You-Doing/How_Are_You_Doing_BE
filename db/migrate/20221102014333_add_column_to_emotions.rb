class AddColumnToEmotions < ActiveRecord::Migration[5.2]
  def change
    add_column :emotions, :definition, :string
  end
end
