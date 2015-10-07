require 'open_food_network/products_and_inventory_report_base'

module OpenFoodNetwork
  class ProductsAndInventoryReport < ProductsAndInventoryReportBase
    def header
      [
        "Supplier",
        "Producer Suburb",
        "Product",
        "SKU",
        "Product Properties",
        "Taxons",
        "Variant Value",
        "Price",
        "Currency",
        "Group Buy Unit Quantity",
        "Amount/Count on Hand",
        "Unit Value"
      ]
    end

    def table
      variants.map do |variant|
        [
          variant.try(:product).try(:supplier).try(:name),
          variant.try(:product).try(:supplier).try(:address).try(:city),
          variant.try(:product).try(:name),
          variant.try(:product).try(:sku),
          variant.try(:product).try(:properties).map(&:name).join(", "),
          variant.try(:product).try(:taxons).map(&:name).join(", "),
          variant.try(:full_name),
          variant.try(:price),
          variant.try(:cost_currency),
          variant.try(:product).try(:group_buy_unit_size),
          variant.try(:count_on_hand),
          variant.try(:unit_value)
        ]
      end
    end

  end
end
