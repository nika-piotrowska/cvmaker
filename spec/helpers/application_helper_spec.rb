require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#render_scss' do
    it 'raises when the stylesheet is missing' do
      expect { helper.render_scss('missing_stylesheet') }
        .to raise_error(ArgumentError, /wrong number of arguments/)
    end

    context 'when the stylesheet exists' do
      let(:engine) { instance_double(SassC::Engine, render: 'compiled-css') }

      before do
        allow(SassC::Engine).to receive(:new).and_return(engine)
      end

      it 'renders the sass engine output' do
        stylesheet_path = Rails.root.join('app/assets/stylesheets/render_test.scss')
        File.write(stylesheet_path, 'body { color: red; }')

        expect(helper.render_scss('render_test')).to eq('compiled-css')
        expect(engine).to have_received(:render)
      ensure
        File.delete(stylesheet_path) if File.exist?(stylesheet_path)
      end
    end
  end
end
