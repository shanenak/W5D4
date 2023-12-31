# == Schema Information
#
# Table name: shortened_urls
#
#  id           :bigint           not null, primary key
#  short_url    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  submitter_id :bigint           not null
#  long_url     :string           not null
#
class ShortenedUrl < ApplicationRecord
    attr_reader :short_url
    validates :long_url, presence: true, uniqueness: true

    after_initialize :generate_short_url # , if: :new_record?

    def self.random_code
        SecureRandom.urlsafe_base64
    end

    belongs_to :submitter,
        primary_key: :id,
        foreign_key: :submitter_id,
        class_name: :User

    has_many :visited_urls,
        primary_key: :id,
        foreign_key: :shortened_url_id,
        class_name: :Visit

    private

    def generate_short_url
        # debugger
        # p 'test' unless self.new_record?
        self.short_url = ShortenedUrl.random_code

        while ShortenedUrl.exists?(self.short_url)
            self.short_url = ShortenedUrl.random_code
        end
    end
end
