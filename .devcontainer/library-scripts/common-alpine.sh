INSTALL_ZSH=${1:-"true"}

# Optionally install and configure zsh
if [ "${INSTALL_ZSH}" = "true" ] && [ ! -d "/root/.oh-my-zsh" ] && [ "${ZSH_ALREADY_INSTALLED}" != "true" ]; then
    apk add zsh
    curl -fsSLo- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | ash 2>&1
    echo "export PATH=\$PATH:\$HOME/.local/bin" >> /root/.zshrc
    if [ "${USERNAME}" != "root" ]; then
        cp -fR /root/.oh-my-zsh /home/$USERNAME
        cp -f /root/.zshrc /home/$USERNAME
        sed -i -e "s/\/root\/.oh-my-zsh/\/home\/$USERNAME\/.oh-my-zsh/g" /home/$USERNAME/.zshrc
        chown -R $USER_UID:$USER_GID /home/$USERNAME/.oh-my-zsh /home/$USERNAME/.zshrc
    fi
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    ZSH_ALREADY_INSTALLED="true"
fi