read -p "Name: " name
read -p "Email: " email

touch $HOME/.gitconfig
git config --global user.name "$name"
git config --global user.email "$email"
