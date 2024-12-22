defmodule AshTest.Accounts.RoleMapping do
  use Ash.Resource,
    otp_app: :ash_test,
    domain: AshTest.Accounts,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer]

  postgres do
    table "role_mappings"
    repo AshTest.Repo
  end

  actions do
    defaults [:read, :destroy, create: :role]
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

    attribute :role, :string do
      allow_nil? false
    end

    timestamps()
  end

  relationships do
    belongs_to :user, AshTest.Accounts.User, allow_nil?: false
  end
end
