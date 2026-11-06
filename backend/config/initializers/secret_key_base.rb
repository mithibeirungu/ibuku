# Ensure Rails.application.secret_key_base is always available for stateless JWT signing
Rails.application.config.secret_key_base ||= ENV["SECRET_KEY_BASE"] || "ibuku_archival_gruvbox_stateless_secret_key_base_2026_94f83b21c0e"

