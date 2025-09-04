class DailyPromptsController < ApplicationController
  before_action :logged_in_user
  # to handle CSRF token issues
  skip_before_action :verify_authenticity_token, only: [:refresh, :update_language]
  
  def show
    @prompt = Prompt.daily_prompt
    @current_language = current_user.preferred_language
    
    # Track that user viewed today's prompt
    current_user.mark_daily_prompt_as_seen(@prompt) if @prompt
  end

  def refresh
    # For daily prompts, "refresh" should give a different individual prompt
    @prompt = current_user.next_random_prompt # Individual progression
    @current_language = current_user.preferred_language
    
    if @prompt
      current_user.mark_prompt_as_seen(@prompt)
      render json: {
        success: true,
        prompt_text: @prompt.text_for_locale(@current_language),
        prompt_id: @prompt.id
      }
    else
      render json: { success: false, error: 'No more prompts available' }
    end
  end

  def update_language
    language = params[:language]
    Rails.logger.debug "DEBUG: Received language parameter: #{language}"

    if %w[en ja].include?(language)
      result = current_user.update(language_preference: language)  # ← Add missing assignment
      Rails.logger.debug "DEBUG: Update result: #{result}"
      Rails.logger.debug "DEBUG: User language after update: #{current_user.reload.language_preference}"
      
      # Get current prompt and return updated text
      current_prompt = Prompt.daily_prompt # or however you're getting the current prompt
      
      render json: { 
        success: true,
        prompt_text: current_prompt&.text_for_locale(language),  # ← Add updated text
        language: language
      }
    else
      Rails.logger.debug "DEBUG: Invalid language: #{language}"
      render json: { success: false, error: 'Invalid language' }
    end 
  end
end
