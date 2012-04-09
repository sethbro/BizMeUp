class ApplicationController < ActionController::Base
  protect_from_forgery

  #before_filter :_reload_libs, :if => :_reload_libs?
  before_filter :get_page_copy
  before_filter :set_page_vars

  helper_method :suppressed?, :add_javascript_var


  protected

  # Sets a variety of page-level variables used by views
  def set_page_vars
    @page ||= {}

    @page[:title] = @copy[:page_title] || ''
    @page[:layout_classes] = [ params[:controller].parameterize.underscore ]
    @page[:suppressed] = []
    @page[:js_vars] = {}
  end

  def add_javascript_var( key, value )
    @page[:js_vars][key] = value
  end

  def suppressed?( el )
    @page[:suppressed].include?( el )
  end

  def suppress_layout_element( el )
    @page[:suppressed].push( el )
  end

  # Retrieves sitewide copy & that for current controller
  def get_page_copy
    @copy = I18n.t 'common'

    begin
      ctrl_copy = I18n.t "actioncontroller.#{params[:controller]}"
      if ctrl_copy && ctrl_copy.respond_to?('[]=')
        @copy = @copy.merge( ctrl_copy )
      end
    rescue
    end
  end

  # Redcarpet Markdown parser
  #def create_markdown_obj
  #  @md ||= markdown_obj
  #end

  #def markdown_obj
  #  prefs_md = { no_intra_emphasis: true, autolink: true, space_after_headers: true }
  #  prefs_rend = { hard_wrap: true, xhtml: true, no_styles: true }
  #  rend = Redcarpet::Render::HTML.new( prefs_rend )

  #  Redcarpet::Markdown.new( rend, prefs_md )
  #end

  def allow_bots( follow=false )
    @robots = follow ? 'index,follow' : true
  end

  def _reload_libs
    RELOAD_LIBS.each do |lib|
      require_dependency lib
    end
  end

  def _reload_libs?
    defined? RELOAD_LIBS
  end

end
