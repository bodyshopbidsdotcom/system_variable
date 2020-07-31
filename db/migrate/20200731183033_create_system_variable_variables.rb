class CreateSystemVariableVariables < ActiveRecord::Migration[5.2]
  def change
    create_table :system_variable_variables do |t|
      t.string :key, null: false
      t.string :value
      t.string :description
      t.timestamps

      t.references :category, foreignkey: true

      t.index [:key], unique: true
    end
  end
end
