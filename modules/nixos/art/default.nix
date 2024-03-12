{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.art;
in {
  options.modules.art = with types; {
    obs.enable =
      mkEnableOption "Enable the OBS Studio video editor.";
  };

  config = {
    environment.systemPackages = mkIf cfg.obs.enable (with pkgs; [
      obs-studio
    ]);
  };
}
