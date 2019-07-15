class App < ApplicationRecord
    has_many :clients, dependent: :destroy
    belongs_to :user

    def icon_url
      "default_app_icon"
    end

    def alt_text
      "#{name} App Icon"
    end

    def new_client_with_language_code(language_code)
      clients.create(
        language_code: (language_code ? language_code : "en_US"),
        verification_token: SecureRandom.hex,
        verified: false
      )
    end

    def is_rejected
      false
    end
end
