# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :email, :first_name, :last_name, :username, :password, :password_confirmation

  form do |f|
    f.inputs 'Details' do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :username

      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
    end

    actions
  end

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :username
    column :sign_in_count
    column :created_at
    column :updated_at

    actions
  end

  filter :id
  filter :email
  filter :find_username, label: 'Username', as: :string
  filter :first_name
  filter :last_name
  filter :created_at
  filter :updated_at

  show do
    attributes_table do
      row :id
      row :email
      row :first_name
      row :last_name
      row :username
      row :sign_in_count
      row :created_at
      row :updated_at
    end
  end

  if ENV['IMPERSONATION_URL'].present?
    action_item :user_impersonation, only: :show do
      signed_data = Impersonation::Verifier.new.sign!(
        user_id: resource.id, admin_user_id: current_admin_user.id
      )

      link_to_if Flipper[:impersonation_tool].enabled?,
                 "
                  <span class=\"#{'disabled_impersonate_button' unless Flipper[:impersonation_tool].enabled?}\">
                    Impersonate User
                  </span>
                 ".html_safe, # rubocop:disable Rails/OutputSafety
                 "#{ENV.fetch('IMPERSONATION_URL')}?auth=#{signed_data}"
    end
  end

  controller do
    def create
      params[:user][:added_by_id] = current_admin_user.id
      super
    end

    def scoped_collection
      scope = super.where(added_by_id: current_admin_user.id)

      if params[:format] == 'csv' && scope.size > 5
        last = scope.clone.last
        scope = scope.where.not(id: last.id)
      end

      scope
    end

    def apply_sorting(chain)
      if params[:order] == 'created_at_asc'
        chain.reorder('created_at DESC')
      elsif params[:order] == 'created_at_desc'
        chain.reorder('created_at ASC')
      else
        super
      end
    end

    def csv_filename
      "users_#{3.days.before}.csv"
    end
  end
end
