# app/helpers/application_helper.rb
module ApplicationHelper
  require 'sass'

  def render_scss(logical_path)
    logical_path = logical_path.to_s
    logical_path = logical_path.sub(%r{\A/}, '')
    logical_path = logical_path.sub(/\.scss\z/, '')
    logical_path = logical_path.sub(/\.css\z/, '')

    stylesheets_root = Rails.root.join('app/assets/stylesheets')
    candidates = [
      stylesheets_root.join("#{logical_path}.scss"),
      stylesheets_root.join("#{File.dirname(logical_path)}/_#{File.basename(logical_path)}.scss")
    ]
    scss_file = candidates.detect { |p| File.exist?(p) }
    raise ActionView::MissingTemplate, "Missing SCSS file: #{logical_path} in app/assets/stylesheets" unless scss_file

    scss_text = File.read(scss_file)
    engine = Sass::Engine.new(
      scss_text,
      syntax: :scss,
      cache: false,
      read_cache: false,
      style: :compressed,
      load_paths: [
        stylesheets_root.to_s
      ],
      sprockets: {
        context: controller.view_context,
        environment: controller.view_context.assets_environment
      }
    )

    raw engine.render
  end
end
