{
  lib,
  config,
  options,
  pkgs,
  ...
}: {
  options.snowflakeos.desktop.plasma = {
    enable = lib.mkEnableOption "Plasma 6";
  };

  config = lib.mkIf config.snowflakeos.desktop.plasma.enable {
    snowflakeos.graphical.enable = true;
  };
}
