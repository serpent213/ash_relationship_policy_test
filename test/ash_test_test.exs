defmodule AshTestTest do
  # use ExUnit.Case
  use AshTest.DataCase, async: true
  doctest AshTest

  test "policy violation (should fail)" do
    abc = Ash.Seed.seed!(%AshTest.Accounts.User{email: "abc"})
    Ash.Seed.seed!(%AshTest.Accounts.RoleMapping{user_id: abc.id, role: "alpha"})
    Ash.Seed.seed!(%AshTest.Accounts.GroupMapping{user_id: abc.id, group: "eins"})
    assert {:ok, user} = Ash.load(abc, [:roles, :groups])
    assert user.roles == []
    assert user.groups == []
  end

  test "without auth (should pass)" do
    abc = Ash.Seed.seed!(%AshTest.Accounts.User{email: "abc"})
    Ash.Seed.seed!(%AshTest.Accounts.RoleMapping{user_id: abc.id, role: "alpha"})
    Ash.Seed.seed!(%AshTest.Accounts.GroupMapping{user_id: abc.id, group: "eins"})
    assert {:ok, user} = Ash.load(abc, [:roles, :groups], authorize?: false)
    assert user.roles == ["alpha"]
    assert user.groups == ["eins"]
  end
end
