require "roo"

class CardsController < ApplicationController
  @sets = Card.distinct.pluck(:deck)
  def index
    @sets = Card.distinct.pluck(:deck)

    if params[:deck].present?
      @cards = Card.where(deck: params[:deck])
      @num = (@cards.count * rand).round
    end
  end

  def show
    @card = Card.first
    @sets = Card.distinct.pluck(:deck)

    setup_session
    @deck_size = session[:remaining_ids].size
    draw_card
  end

  def edit
    @cards = Card.all
  end

  def update
    @card = Card.find(params[:id]) # find the card by ID from the form
    if @card.update(card_params)
      redirect_to edit_card_path, notice: "Card updated successfully!"
    else
      flash.now[:alert] = "Failed to update card."
      render :edit
    end
  end


  def guess
    @card = Card.first
    @deck_size ||= session[:remaining_ids].size
    setup_session

    current_id = session[:remaining_ids].first
    card = Card.find(current_id)

    if params[:value] == card.answer
      session[:correct] += 1
      session[:remaining_ids].shift
      render :show
    else
      render :show
    end
  end


  def reset
    draw_card
    reset_session
    redirect_to action: :show
  end

  def choose_deck
    session[:remaining_ids] = Card.where(deck: params["value"]).pluck(:id).shuffle
    @deck_size = session[:remaining_ids].size

    draw_card
    redirect_to action: :show
  end

  private

  def card_params
    params.require(:card).permit(:question, :answer)
  end

  def setup_session
    session[:remaining_ids] ||= Card.pluck(:id).shuffle
    session[:correct] ||= 0
    draw_card
  end

  def draw_card
    @sets = Card.distinct.pluck(:deck)

    if session[:remaining_ids].empty?
      reset_session
      flash.now[:notice] = "All done!"
      return
    end

    current_id = session[:remaining_ids].first
    @card = Card.find(current_id)

    incorrect_answers = Card
      .where.not(id: current_id)
      .order(Arel.sql("RANDOM()"))
      .limit(2)
      .pluck(:answer)

    @choices = (incorrect_answers + [@card.answer]).shuffle
  end

  def reset_session
    session[:remaining_ids] = Card.pluck(:id).shuffle
    session[:correct] = 0
  end
end
