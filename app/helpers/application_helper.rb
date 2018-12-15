module ApplicationHelper
  def dropdown_helper(name, collection = [], options = {})
    button_options = {
      "id" => options[:id],
      "type" => "button",
      "class" => "btn btn-secondary dropdown-toggle",
      "data-toggle" => "dropdown",
      "aria-haspopup" => "true",
      "aria-expanded" => "false",
    }
    div_options = {
      "class" => "dropdown-menu",
      "aria-labelledby" => options[:id],
    }
    dropdown_list = content_tag(:div, div_options) do
      collection.collect do |obj|
        link_to(
          obj[:title],
          obj[:link],
          :remote => true,
          :class => "dropdown-item"
        )
      end.
        join.
        html_safe
    end
    content_tag(:button, name, button_options) + dropdown_list
  end
end
