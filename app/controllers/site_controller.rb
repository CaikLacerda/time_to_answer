class SiteController < ApplicationController
    before_action :check_pagination
    layout 'site'

    protected

    def check_pagination
        unless user_signed_in?
          params.extract!(:page)
        end
    end
end
