import Config

config :ash_test, ecto_repos: [AshTest.Repo], ash_domains: [AshTest.Accounts]

config :ash,
  include_embedded_source_by_default?: false,
  show_keysets_for_all_actions?: false,
  default_page_type: :keyset
  # enable next line for work-around
  # policies: [no_filter_static_forbidden_reads?: false]

config :spark,
  formatter: [
    remove_parens?: true,
    "Ash.Resource": [
      section_order: [
        :postgres,
        :resource,
        :code_interface,
        :actions,
        :policies,
        :pub_sub,
        :preparations,
        :changes,
        :validations,
        :multitenancy,
        :attributes,
        :relationships,
        :calculations,
        :aggregates,
        :identities
      ]
    ],
    "Ash.Domain": [section_order: [:resources, :policies, :authorization, :domain, :execution]]
  ]

import_config "#{config_env()}.exs"