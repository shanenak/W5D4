class AddLongUrlAndUserIdToShortenedUrl < ActiveRecord::Migration[7.0]
  def change
    # add_column :shortened_urls, :user_id, :string, null: false
    # add_reference :shortened_urls, :user, null: false, foreign_key: true
    add_reference :shortened_urls, :submitter, null: false, foreign_key: {to_table: :users}

    add_column :shortened_urls, :long_url, :string, null: false

    add_index :shortened_urls, :long_url, unique: true
  end
end
