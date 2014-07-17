require "pathname"

module GuideHelpers
  def page_title
    title = "Zillabyte: "
    if data.page.title
      title << data.page.title
    else
      title << t("index.sub_title")
    end
    title
  end


  def h2_link(name)
    "<h2><a href='##{name.underscore}'>#</a>#{name}</h2>"
  end

  def edit_guide_url
    p = Pathname(current_page.source_file).relative_path_from(Pathname(root))
    "https://github.com/middleman/middleman-guides/blob/master/#{p}"
  end

  def pages_for_group(group_name)
    group = data.nav.find do |g|
      g.name == group_name
    end

    pages = []

    return pages unless group

    if group.directory
      pages << sitemap.resources.select { |r|
        r.path.match(%r{^#{group.directory}}) && !r.data.hidden
      }.map do |r|
        ::Middleman::Util.recursively_enhance({
          :title => r.data.title,
          :path  => r.url
        })
      end.sort_by { |p| p.title }
    end

    pages << group.pages if group.pages

    pages.flatten
  end

  def locale_prefix
    (I18n.locale == :en) ? "" : "/" + I18n.locale.to_s
  end
end
