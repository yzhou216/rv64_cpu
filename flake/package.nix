# SPDX-FileCopyrightText: 2026 Yiyu Zhou <yiyu@yiyuzhou.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  perSystem =
    { config, pkgs, ... }:
    {
      packages = {
        default = config.packages.rv64_cpu;
        rv64_cpu = pkgs.callPackage ./rv64_cpu.nix { };
      };

      apps.pipeline = {
        type = "app";
        program = "${config.packages.rv64_cpu}/bin/rv64_cpu-pipeline";
        meta.description = "Open the pipelined processor in Digital";
      };
    };
}
