defmodule AshTest.Accounts.User do
  use Ash.Resource,
    otp_app: :ash_test,
    domain: AshTest.Accounts,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer]

  postgres do
    table "users"
    repo AshTest.Repo
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  policies do
    bypass expr(:admin in ^actor(:roles)) do
      authorize_if always()
    end

    policy action_type(:read) do
      # Member can access her own record
      authorize_if expr(member.id == ^actor(:id))
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :email, :string do
      allow_nil? false
      public? true
    end

    timestamps()
  end

  relationships do
    has_many :role_mappings, AshTest.Accounts.RoleMapping
    has_many :group_mappings, AshTest.Accounts.GroupMapping
  end

  aggregates do
    list :roles, :role_mappings, :role
    list :groups, :group_mappings, :group
  end
end
