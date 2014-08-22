class Carrier < ActiveRecord::Base

  has_many :contacts
  belongs_to :invoice_country, :class_name => 'Country'

  validates :acronym, :presence => true
  validates :name, :presence => true
  

  #validate :invoice_complete

  def invoice_complete
    if not invoice_name.present?
      errors.add(:invoice, "#{I18n.t("activerecord.attributes.customer.invoice_name")} #{I18n.t("errors.messages.blank")}")
    end
    if not invoice_nif.present?
      errors.add(:invoice, "#{I18n.t("activerecord.attributes.customer.invoice_nif")} #{I18n.t("errors.messages.blank")}")
    end
    if not invoice_street.present?
      errors.add(:invoice, "#{I18n.t("activerecord.attributes.customer.invoice_street")} #{I18n.t("errors.messages.blank")}")
    end
    if not invoice_zip.present?
      errors.add(:invoice, "#{I18n.t("activerecord.attributes.customer.invoice_zip")} #{I18n.t("errors.messages.blank")}")
    end
    if not invoice_city.present?
      errors.add(:invoice, "#{I18n.t("activerecord.attributes.customer.invoice_city")} #{I18n.t("errors.messages.blank")}")
    end
    if not invoice_country_id.present?
      errors.add(:invoice, "#{I18n.t("activerecord.attributes.customer.invoice_country_id")} #{I18n.t("errors.messages.blank")}")
    end
  end

  def invoice
    "#{invoice_name} - #{invoice_nif} - #{invoice_street} #{invoice_zip} #{invoice_city} #{invoice_country ? "(#{invoice_country.name})" : ""}"
  end

end
