class Url < ApplicationRecord
    validates :original, :digest, presence: true
    validates :original, :digest, uniqueness: true
end
