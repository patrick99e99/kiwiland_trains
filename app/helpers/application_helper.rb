# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def town_options(select)
    options_for_select(Route.towns, params[select])
  end
  
  def footer_data
    [{:display => "Home", :path => 'options'},
     {:display => "Total Distance", :path => 'distances'},
     {:display => "Number of Trips", :path => 'trips'},
     {:display => "Shortest Route", :path => 'routes'}]
  end
  
  def footer_pages
    return if controller_name == 'options'
    
    footer_data.map do |page|
      link_to page[:display], send("#{page[:path]}_path"), :class => ('active' if controller_name == page[:path])
    end.join(footer_break)
  end
  
  def footer_break
    content_tag :span, "|"
  end
  
  def route_span(route = @route)
     content_tag :span, route.join("-"), :class => "route_text"
  end

  def routes_image
    image_tag "kiwi_routes.png", :height => 131, :width => 200, :alt => "routes image", :id => "kiwi_routes"
  end

  def state_params
    reject_list = [:authenticity_token, :commit]
    params.reject {|k,v| reject_list.include?(k.to_sym)}
  end
  
end
