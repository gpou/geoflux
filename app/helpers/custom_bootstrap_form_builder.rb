class CustomBootstrapFormBuilder < BootstrapForm::FormBuilder
  def submit(name = nil, options = {})
    options.merge! class: 'btn btn-success' unless options.has_key? :class
    super(name, options)
  end

  def static_control(name, options = {}, &block)
    html = if block_given?
      capture(&block)
    else
      object.send(name)
    end
    form_group_builder(name, options) do
      opts = options.extract!(:prepend, :append)
      id = options[:id] || ""
      input = content_tag(:p, html, class: static_class, id: id)
      input = content_tag(:span, opts[:prepend], class: 'input-group-btn') + input if opts[:prepend]
      input << content_tag(:span, opts[:append], class: 'input-group-btn') if opts[:append]
      input = content_tag(:div, input, class: 'input-group') if opts[:prepend] || opts[:append]
      input
    end
  end

  def static_class
    "form-control form-control-static"
  end

  def alert_message(title, options = {})
    css = options[:class] || 'alert alert-danger'

    if object.respond_to?(:errors) && object.errors.full_messages.any?
      content_tag :div, class: css do
        concat content_tag :p, title || I18n.t("errors.template.header", :count => object.errors.count, :model => object.class.model_name.human.upcase)
        concat error_summary unless inline_errors || options[:error_summary] == false
        #concat error_summary unless options[:error_summary] == false
      end
    end
  end

  def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    form_group_builder(method, options, html_options) do
      opts = options.extract!(:prepend, :append)
      input = @template.collection_select(@object_name, method, collection, value_method, text_method, objectify_options(options), @default_options.merge(html_options))
      input = content_tag(:span, opts[:prepend], class: 'input-group-btn') + input if opts[:prepend]
      input << content_tag(:span, opts[:append], class: 'input-group-btn') if opts[:append]
      input = content_tag(:div, input, class: 'input-group') if opts[:prepend] || opts[:append]
      input
    end
  end

  def grouped_collection_select(method, collection, group_method, group_label_method, option_key_method, option_value_method, options = {}, html_options = {})
    form_group_builder(method, options, html_options) do
      opts = options.extract!(:prepend, :append)
      input = @template.grouped_collection_select(@object_name, method, collection, group_method, group_label_method, option_key_method, option_value_method, objectify_options(options), @default_options.merge(html_options))
      input = content_tag(:span, opts[:prepend], class: 'input-group-btn') + input if opts[:prepend]
      input << content_tag(:span, opts[:append], class: 'input-group-btn') if opts[:append]
      input = content_tag(:div, input, class: 'input-group') if opts[:prepend] || opts[:append]
      input
    end
  end

end
