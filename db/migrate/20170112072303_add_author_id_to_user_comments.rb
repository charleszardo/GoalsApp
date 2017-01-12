class AddAuthorIdToUserComments < ActiveRecord::Migration
  def change
    add_column :user_comments, :author_id, :integer, null: false
    add_index :user_comments, :author_id
  end

end
