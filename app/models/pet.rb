class Pet < ApplicationRecord
    validates :nome, :raca, :porte, presence: true
    enum porte: { pequeno: 0, medio: 1, grande: 3 }
end
