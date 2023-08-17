# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  short_url  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedUrl < ApplicationRecord
    validates :short_url, presence: true, uniqueness: true

    after_initialize :generate_short_url

    def self.random_code
        SecureRandom.urlsafe_base64
    end

    belongs_to :submitter,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User

    private

    def generate_short_url(code = nil)
        code ||= ShortenedUrl.random_code
        while ShortenedUrl.exists?(code)
            code = ShortenedUrl.random_code
        end
        code
    end
end
