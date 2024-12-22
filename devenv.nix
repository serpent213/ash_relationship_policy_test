{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  # https://devenv.sh/packages/
  packages = with pkgs;
      [
        git
        # linter and formatter for JavaScript, TypeScript, JSX, CSS and GraphQL
        biome
        # Nix code formatter
        alejandra
        # i18n
        icu
        # PostgreSQL client utilities
        postgresql
      ]
      ++
      # Linux only
      lib.optionals pkgs.stdenv.isLinux [
        # for ExUnit notifier
        libnotify

        # for package - file_system
        inotify-tools
      ]
      ++
      # Darwin only
      lib.optionals pkgs.stdenv.isDarwin [
        # for ExUnit notifier
        terminal-notifier

        # for package - file_system
        darwin.apple_sdk.frameworks.CoreFoundation
        darwin.apple_sdk.frameworks.CoreServices
      ];

  # https://devenv.sh/languages/
  languages.elixir.enable = true;
  languages.javascript.enable = true;
  languages.javascript.npm.enable = true;

  # https://devenv.sh/services/
  services.postgres = {
    enable = true;
    port = 5777;
    initialDatabases = [{name = "ash_dev";} {name = "ash_test";}];
    initialScript = ''
      CREATE ROLE dev WITH LOGIN PASSWORD 'dev' SUPERUSER;
    '';
  };

  # https://devenv.sh/processes/
  # processes.phoenix.exec = "MIX_ENV=prod PORT=4500 mix phx.server";

  # See full reference at https://devenv.sh/reference/options/
}
