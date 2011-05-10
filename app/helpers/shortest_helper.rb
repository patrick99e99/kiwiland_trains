module ShortestHelper
  
  def shortest_route_span
    route_text = [@route.last.join("-"), "(#{@route.first})"]
    content_tag :span, route_text.join(" "), :class => "route_text"   
  end

end
