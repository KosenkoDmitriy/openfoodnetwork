require 'spec_helper'

describe OpenFoodNetwork::Calculator::FlatPercentOrRatePerMonth, :type => :model do
  # describe Spree::Calculator::FlatPercentItemTotal, :type => :model do
    let(:calculator) { OpenFoodNetwork::Calculator::FlatPercentOrRatePerMonth.new }
    let(:line_item) { mock_model Spree::LineItem }
    # let(:text) { I18n.t(:flat_percent_or_rate_per_month)}

    before { allow(calculator).to receive_messages preferred_flat_percent: 10 }

    context "description" do
      # it "should display description correctly" do
      #   expect(calculator.description).to eq "Flat Percent or Rate per Month"
      # end
      # it "should display translated description correctly" do
      #   expect(calculator.description).to eq I18n.t(:flat_percent_or_rate_per_month)
      # end
      #
      # it "should display translated description (let) correctly" do
      #   expect(calculator.description).to eq text
      # end
      # it "should round result correctly" do
      #   allow(line_item).to receive_messages amount: 31.08
      #   expect(calculator.compute(line_item)).to eq 3.11
      #
      #   allow(line_item).to receive_messages amount: 31.00
      #   expect(calculator.compute(line_item)).to eq 3.10
      # end
      #
      # it 'returns object.amount if computed amount is greater' do
      #   allow(calculator).to receive_messages preferred_flat_percent: 110
      #   allow(line_item).to receive_messages amount: 30.00
      #
      #   expect(calculator.compute(line_item)).to eq 30.0
      # end
    end
  # end
end
