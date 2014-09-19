class Customer < ActiveRecord::Base
  has_many :estimates
  belongs_to :invoice_country, :class_name => 'Country'

  validates :email, :format => { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }, :allow_blank => true

  validate :phone_or_email

  def phone_or_email
    if not phone.present? and not email.present?
      errors.add(:email, "#{I18n.t("activerecord.errors.customer.phone_or_email")}")
    end
  end

  validate :name_or_company

  def name_or_company
    if not first_name.present? and not last_name.present? and not company.present?
      errors.add(:company, "#{I18n.t("activerecord.errors.customer.name_or_company")}")
    end
  end

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

  def full_name
    "#{email} #{company} #{last_name} #{first_name}"
  end

  def to_s
    if !company.blank?
      company
    else
      email
    end
  end

end