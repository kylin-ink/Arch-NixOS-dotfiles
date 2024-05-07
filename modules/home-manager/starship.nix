{
  config,
  pkgs,
  ...
}: {

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      direnv.disabled = false;
      directory = {
        truncation_symbol = "…/";
        truncate_to_repo = false;
      };
      git_metrics.disabled = false;
      localip = {
        ssh_only = false;
        disabled = false;
      };
      memory_usage.disabled = false;
      os.disabled = false;
      shell.disabled = false;
      shlvl.disabled = false;
      status.disabled = false;
      sudo.disabled = false;
      time.disabled = false;
      continuation_prompt = "▶▶ ";
      fill.symbol = " ";
      format = "$os$all";
      right_format = "$shlvl$time$memory_usage$localip";
      env_var.HTTP_PROXY = {
        variable = "HTTP_PROXY";
        default = "";
        format = "[$env_value]($style) ";
        style = "bright-blue bold";
      };
    };
  };

}