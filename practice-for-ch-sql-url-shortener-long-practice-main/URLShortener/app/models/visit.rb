# == Schema Information
#
# Table name: visits
#
#  id               :bigint           not null, primary key
#  user_id          :bigint           not null
#  shortened_url_id :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Visit < ApplicationRecord
    belongs_to :visited_users,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User

    belongs_to :visited_urls,
        primary_key: :id,
        foreign_key: :shortened_url_id,
        class_name: :ShortenedUrl
end
