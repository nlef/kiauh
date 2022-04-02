install_MoonrakerTelegramBot(){
    ### check for existing moonraker telegram bot service installations
    SERVICE_FILES=$(find "$SYSTEMDDIR" -regextype posix-extended -regex "$SYSTEMDDIR/moonraker-telegram-bot(-[^0])?[0-9]*.service")
    if [ -n "$SERVICE_FILES" ]; then
      ERROR_MSG="At least one moonraker telegram bot service is already installed:"
      for service in $SERVICE_FILES; do
        ERROR_MSG="${ERROR_MSG}\n ➔ $service"
      done && return
    fi
    
    source_kiauh_ini
    #MoonrakerTelegramBot main installation
    MoonrakerTelegramBot_setup
    #after install actions
    restart_MoonrakerTelegramBot
}

MoonrakerTelegramBot_setup(){
  source_kiauh_ini
  export klipper_cfg_loc
  dep=(virtualenv)
  dependency_check
  status_msg "Downloading MoonrakerTelegramBot ..."
  #force remove existing MoonrakerTelegramBot dir 
  [ -d $MOONRAKER_TELEGRAM_BOT_DIR ] && rm -rf $MOONRAKER_TELEGRAM_BOT_DIR
  #clone into fresh MoonrakerTelegramBot dir
  cd ${HOME} && git clone $NLEF_REPO
  ok_msg "Download complete!"
  status_msg "Installing MoonrakerTelegramBot ..."
  $MOONRAKER_TELEGRAM_BOT_DIR/scripts/install.sh 
  echo; ok_msg "MoonrakerTelegramBot successfully installed!"
}
