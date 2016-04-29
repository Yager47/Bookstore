class CreditCardsController < ApplicationController
  before_action :set_order

  def new
    @credit_card = @order.build_credit_card
  end

  def create
    @credit_card = @order.build_credit_card(credit_card_params)
    @credit_card.save
    redirect_to checkout_confirm_url
  end

  def update
  end

  def destroy
  end

  private
    def set_order
      @order = current_order
    end

    def credit_card_params
      params.require(:credit_card).permit(:number, :expiration_date, :cvv)
    end
end
