{
  lib,
  pkgs,
  inputs,
  systems,
  config,
  ...
}:
with lib; let
  cfg = config.modules.stylix;
in {
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  options.modules.stylix = with types; {
    enable = mkOption {
      type = bool;
      default = true;
      description = "Enable Stylix";
    };
    theme = mkOption {
      type = bool;
      default = true;
      description = "Enable Prax-OS Dark Pink Theme";
    };
    darkmode = mkOption {
      type = bool;
      default = true;
      description = "Enable Dark Mode";
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      stylix = {
        image = ./wallpaper.jpg;

        opacity.terminal = 0.9;

        fonts = {
          serif = {
            name = "Inter";
            package = pkgs.google-fonts.override {fonts = ["Inter"];};
          };

          sansSerif = {
            name = "Inter";
            package = pkgs.google-fonts.override {fonts = ["Inter"];};
          };

          monospace = {
            name = "JetbrainsMono Nerd Font";
            package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
          };

          sizes = {
            applications = 14;
            desktop = 11;
          };
        };
      };
    })
    (mkIf cfg.theme {
      stylix = {
        base16Scheme = ./pinku.yaml;
        cursor = {
          name = "phinger-cursors-light";
          package = pkgs.phinger-cursors;
          size = 48;
        };
      };
    })
    (mkIf cfg.darkmode {
      stylix = {
        polarity = "dark";
      };
    })
  ];
}
