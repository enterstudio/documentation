=begin
image tag takes three properties
- src
- position [ nofloat | right | left | center ] (default: nofloat)
- width [ full | 3-quarters | 2-thirds | half | third | quarter | actual ] (default: full)
- alt

{% image src="/img/ingredients/configuring_the_dashboard/web_url.png" half center alt="Web Url" %}
{% image src="http://cdn.branch.io/components/image.png" left quarter alt="Some Image: check it out!" %}
=end

module Jekyll
  class ImageTag < Liquid::Tag
    FILE_REGEX = /({{)(?<name>.*)(}})/i

    def replace(context, asset)
      m = FILE_REGEX.match(asset)
      unless m.nil?
        name = m[:name].split('.')
        page = context.environments.first[name[0]]
        str_replace = page.has_key?(name[1]) ? page[name[1]] : ''
        asset = asset.gsub(FILE_REGEX, str_replace)
      end
      asset
    end

    def initialize(tag_name, text, tokens)
      super
      @position = /nofloat|right|left|center/.match(text).to_s
      @width = /full|3-quarters|2-thirds|half|third|quarter|actual/.match(text).to_s
      @src = /src=['"]\S*['"]/.match(text).to_s
      @alt = /alt=['"].*['"]/.match(text).to_s
    end

    def render(context)
      @WIDTH_MAP = {
        'full' => '100%',
        '3-quarters' => '75%',
        '2-thirds' => '66%',
        'half' => '50%',
        'third' => '33%',
        'quarter' => '25%',
        'actual' => ''
      }

      image_width = @WIDTH_MAP[@width] || '100%'
      '<img '+replace(context, @src)+' '+@alt+' class="plugin '+@position+'" '+'width="'+image_width+'"/>'
    end
  end
end

Liquid::Template.register_tag('image', Jekyll::ImageTag)