class WelcomeController < ApplicationController
  def home
    @recipes = Recipe.all
  end

  def signup
  end

  def login
    current_user
  end
end
