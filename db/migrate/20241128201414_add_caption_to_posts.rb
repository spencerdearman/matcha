class AddCaptionToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :caption, :string
  end
end
