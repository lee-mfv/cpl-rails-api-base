# frozen_string_literal: true

json.user do
  json.partial! 'reg_info', user: @resource
end
