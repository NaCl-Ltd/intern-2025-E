require "test_helper"

class DailyPromptsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get daily_prompts_show_url
    assert_response :success
  end

  test "should get refresh" do
    get daily_prompts_refresh_url
    assert_response :success
  end

  test "should get update_language" do
    get daily_prompts_update_language_url
    assert_response :success
  end
end
