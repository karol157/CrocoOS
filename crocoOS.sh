set -a
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
SCRIPTS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"/scripts
CONFIGS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"/conf
set +a
echo -ne "
------------------------------------------------------------------------
  ██████╗ ██████╗   ████████   ██████╗  ████████
 ██╔════╝ ██╔══██╗ ██║     ██ ██╔════╝ ██║     ██
 ██║      ██████╔╝ ██║     ██ ██║      ██║     ██
 ██║      ██╔══██╗ ██║     ██ ██║      ██║     ██
 ╚██████╗ ██║  ██║  ████████  ╚██████╗  ████████
  ╚═════╝ ╚═╝  ╚═╝  ╚══════╝   ╚═════╝  ╚══════╝
  ------------------------------------------------------------------------
  "
    ( bash $SCRIPT_DIR/scripts/startup.sh )|& tee startup.log
      source $CONFIGS_DIR/setup.conf
    ( bash $SCRIPT_DIR/scripts/preinstall.sh )|& tee 0-preinstall.log
    ( arch-chroot /mnt $HOME/ArchTitus/scripts/setup.sh )|& tee 1-setup.log
    if [[ ! $DESKTOP_ENV == server ]]; then
      ( arch-chroot /mnt /usr/bin/runuser -u $USERNAME -- /home/$USERNAME/ArchTitus/scripts/user.sh )|& tee 2-user.log
    fi
    ( arch-chroot /mnt $HOME/ArchTitus/scripts/post-setup.sh )|& tee 3-post-setup.log
    cp -v *.log /mnt/home/$USERNAME

echo -ne "
------------------------------------------------------------------------
  ██████╗ ██████╗   ████████   ██████╗  ████████
 ██╔════╝ ██╔══██╗ ██║     ██ ██╔════╝ ██║     ██
 ██║      ██████╔╝ ██║     ██ ██║      ██║     ██
 ██║      ██╔══██╗ ██║     ██ ██║      ██║     ██
 ╚██████╗ ██║  ██║  ████████  ╚██████╗  ████████
  ╚═════╝ ╚═╝  ╚═╝  ╚══════╝   ╚═════╝  ╚══════╝
  ------------------------------------------------------------------------
  "
