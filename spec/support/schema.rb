ActiveRecord::Schema.define(version: 0) do
  self.verbose = false

  create_table :correct_accounts do |t|
    t.string :email, null: false
    t.timestamps
  end

  create_table :wrong_accounts do |t|
    t.string :email
    t.timestamps
  end

  execute 'CREATE VIEW new_correct_people AS '\
          'SELECT * FROM correct_people '\
          'WHERE created_at = updated_at'
end
