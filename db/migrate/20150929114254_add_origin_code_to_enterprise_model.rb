class AddOriginCodeToEnterpriseModel < ActiveRecord::Migration
  def change
    add_column :enterprises, :origin_code, :string
  end
end
