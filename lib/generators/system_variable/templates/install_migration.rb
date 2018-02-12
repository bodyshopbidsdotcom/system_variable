class <%= migration_class_name %> < <%= migration_parent %>
  def change
    create_table :<%= table_name %> do |t|
      t.string :name, :null => false
      t.text :value
      t.timestamps
      t.index :name, :unique => true
    end
  end
end
