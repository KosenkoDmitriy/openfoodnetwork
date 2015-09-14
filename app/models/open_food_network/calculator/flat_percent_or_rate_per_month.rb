require_dependency 'spree/calculator'

module OpenFoodNetwork
  class Calculator::FlatPercentOrRatePerMonth < Spree::Calculator
    preference :flat_percent, :decimal, :default => 2
    preference :amount, :decimal, :default => 500
    preference :currency, :string, :default => Spree::Config[:currency]

    attr_accessible :preferred_flat_percent, :preferred_amount, :preferred_currency

    def self.description
      I18n.t(:flat_percent_or_rate_per_month)
    end

    def compute(object)
      item_total = line_items_for(object).map(&:amount).sum
      value = item_total * BigDecimal(self.preferred_flat_percent.to_s) / 100.0
      current_sum = flat_percent = (value * 100).round.to_f / 100

      dt1 = DateTime.now.at_beginning_of_month
      dt2 = DateTime.now
      turnover_per_m = Spree::Order.where(created_at: (dt1..dt2)).sum("item_total").to_f #TODO: maybe better use Spree::Payments model
      # turnover_per_m = Spree::Order.where(completed_at: (dt1..dt2)).sum("item_total").to_f
      # where(completed_at: (DateTime.now.midnight - 1.day)..DateTime.now.midnight)
      # at_beginning_of_monthat_beginning_of_month

      turnover_per_m_total = turnover_per_m + current_sum

      total_sum = turnover_per_m_total

      turnover_max = (self.preferred_amount * 100)/self.preferred_flat_percent

      if (turnover_per_m_total > turnover_max)
        total_sum = self.preferred_amount
      end

      total_sum
    end
  end
end


