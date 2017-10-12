class HomeController < ApplicationController
  def index
    @jobs = Job.most_recent
  end
end
