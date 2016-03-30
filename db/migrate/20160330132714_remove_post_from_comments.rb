class RemovePostFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :post, :integer
  end
end
