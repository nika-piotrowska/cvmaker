module ApplicationHelper
  require 'sass'
  def render_scss(file)
    text = render(file.to_s)
    view_context = controller.view_context

    engine = Sass::Engine.new(text, {
      syntax: :scss, cache: false, read_cache: false, style: :compressed,
      sprockets: {
        context: view_context,
        environment: view_context.assets_environment
      }
    })
    raw engine.render
  end
end
