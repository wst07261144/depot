class AddSortToProduct < ActiveRecord::Migration
  def change
    def self.up
      add_column :products, :sort, :string
    end

    def self.down
      remove_column :products,:sort
    end
  end
end
