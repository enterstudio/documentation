require 'kramdown'

# Takes one property i.e. {% prerequisite title='Here's how you can use this' %}

module Jekyll
    class PrerequisiteTag < Liquid::Block
    def initialize(tag_name, text, tokens)
      super
      @params = text
    end

    def render(context)
      data = {}

      @params.scan(/(\w+)=["']([^'\\]+(\\.[^'\\]+)*)["']/).each { |m|
        data[m[0]] = Liquid::Template.parse(m[1]).render!(context)
      }

      icon = '<i class="fa fa-check-square-o"></i> '
      title = if data['title'] then '<h4 class="prerequisite__title"> ' + icon + ' Prerequisite: ' + data['title'] + '</h4>' else '<h4 class="prerequisite__title">' + icon + ' Prerequisites</h4>' end
      contents = Kramdown::Document.new(super).to_html
      '<blockquote class="prerequisite">' + title + contents + '</blockquote>'
    end
  end
end

Liquid::Template.register_tag('prerequisite', Jekyll::PrerequisiteTag)
