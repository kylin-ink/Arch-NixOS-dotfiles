{
  pkgs,
  username,
  ...
}: {
  services = {
    offlineimap = {
      enable = true;
      install = true;
      path = with pkgs; [
        bash
        notmuch
        gnupg
        sops
      ];
    };
    # setup lmtp and rss2email for read local rss source
    dovecot2 = {
      enable = true;
      enableLmtp = true;
      mailLocation = "maildir:~/Maildir/%u/Inbox";
    };
    rss2email = {
      enable = true;
      to = "${username}";
      config = {
        sendmail = "/run/wrappers/bin/sendmail";
        email-protocol = "lmtp";
        lmtp-server = "/var/run/dovecot2/lmtp";
        lmtp-auth = "False";
        # post-process = ''${pkgs.libnotify}/bin/notify-send "New Mail in:" "${username}"'';
      };
      feeds = {
        hacknews.url = "https://rsshub.app/hackernews";
      };
    };
  };
}
