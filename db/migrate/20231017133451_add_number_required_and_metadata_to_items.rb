class AddNumberRequiredAndMetadataToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :number_required, :integer
    add_column :items, :metadata, :json
  end
end
