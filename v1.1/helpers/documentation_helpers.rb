# http://haml.info/docs/yardoc/Haml/Helpers.html#capture_haml-instance_method

module DocumentationHelpers
  
  def section(name, &block)
    if block_given?
      inner = capture_haml(&block)
    else
      inner = ""
    end
    """
      <h3>
        <a href='#'>#{h name}</a>
      </h3>
      <p class='section'>
        #{inner}
      </p>
    """
  end



  def bash(&block)  
    if block_given?
      capture_html(&block)
    else
      ""
    end
  end
  
  
  
end

