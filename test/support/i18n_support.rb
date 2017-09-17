module I18nSupport
  def translate(model, field: nil, plural: false)
    model_constant = model.class == "String" ? model.constantize : model
    count_plural = plural ? 1 : 2
    return model_constant.model_name.human(count: count_plural) unless field.present?
    model.constantize.human_attribute_name(field, count: count_plural)
  end
end
