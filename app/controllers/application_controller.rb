# encoding: utf-8

class ApplicationController < ActionController::Base
  INPUT_PATH = '/usr/local/apps/movie_seen/data/ranking/'

  protect_from_forgery

  before_filter :redirect_to_login_if_one_do_not, :unless => :no_need_login


  protected

  def page_title(messege)
    @page_title = "#{messege} - 映画の履歴を残す 見たい映画をメモ・記録する"
  end

  def no_need_login
    ['login'].include? controller_name
  end

  def redirect_to_login_if_one_do_not
    unless logged_in?
      redirect_to :controller => 'login'
    end
  end

  def logged_in?
    return false unless session[:uid] && session[:provider]
    @author = Author.find_by_uid_and_provider_and_negative(
      session[:uid], session[:provider], 0
    )
  end

  def fetch_ranking(target)
    rankings = Hash.new
    target.each do |title|
      if contents = catch_data(title)
        rankings[title] = contents
      end
    end
    rankings
  end

  def catch_data(title)
    YAML.load_file "#{INPUT_PATH}#{title}.yml"
  end
end
