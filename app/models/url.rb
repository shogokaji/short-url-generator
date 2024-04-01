class Url < ApplicationRecord
    validates :original, :digest, presence: true
    validates :original, :digest, uniqueness: true

    DIGEST_LENGTH = 7
end
