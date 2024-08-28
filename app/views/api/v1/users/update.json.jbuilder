# frozen_string_literal: true

json.user do
  json.partial! 'update_info', user: current_user
end
