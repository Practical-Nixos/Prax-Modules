{
  pkgs,
  lib,
  ...
}: {
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      plasma5.enable = true;
    };
    displayManager = {
      defaultSession = "plasmawayland";
      sddm.enable = true;
    };
  };

  qt.platformTheme = lib.mkForce "kde";

  environment.plasma6.excludePackages = with pkgs.libsForQt5; [
    kdeconnect-kde
  ];

  systemd = {
    user.services.polkit-kde-authentication-agent-1 = {
      description = "polkit-kde-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
