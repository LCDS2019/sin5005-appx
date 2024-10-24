class Ingredient < ApplicationRecord
  validates :name, presence: true
  validates :unityMeasure, presence: true
  validates :quantityStock, presence: true, numericality: { greater_than: 0 }
  validates :quantityStockMin, presence: true, numericality: { greater_than: 0 }
  validates :quantityStockMax, presence: true, numericality: { greater_than: 0 }
  validate :validate_min_max_stock

  has_and_belongs_to_many :products

  private

  def validate_min_max_stock
    if quantityStockMin && quantityStockMax && quantityStockMin > quantityStockMax
      errors.add(:quantityStockMin, "não pode ser maior que o estoque máximo")
    end
  end
end
