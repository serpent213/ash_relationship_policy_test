defmodule AshTest.Accounts do
  use Ash.Domain

  resources do
    resource AshTest.Accounts.RoleMapping
    resource AshTest.Accounts.GroupMapping
    resource AshTest.Accounts.User
  end
end
