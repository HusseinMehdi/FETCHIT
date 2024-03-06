class RenamePasswordDigetToDigest < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :password_diget, :password_digest
  end
end
