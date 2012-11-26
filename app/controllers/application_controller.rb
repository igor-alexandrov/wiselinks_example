class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_layout

protected

  def current_layout
    layout = self.send(:_layout)
    # if layout.instance_of? String
    #   layout
    # else
      layout.identifier
    # end
  end
end
