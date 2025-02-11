tmux source-file tmux.conf

source ~/.bashrc

---

Enable RPM Fusion
https://rpmfusion.org/Configuration

sudo dnf groupupdate core

Adding Flatpaks
https://flatpak.org/setup/Fedora

Change Hostname
sudo hostnamectl set-hostname "New_Custom_Name"

Install Media Codecs
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin

sudo dnf groupupdate sound-and-video
