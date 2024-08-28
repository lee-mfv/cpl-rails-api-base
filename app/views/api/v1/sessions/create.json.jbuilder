# frozen_string_literal: true

json.user do
  json.partial! 'signin_info', user: @resource
end
