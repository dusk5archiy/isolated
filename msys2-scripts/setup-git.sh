read -p "Name: " name
read -p "Email: " email

touch $HOME/.gitconfig
git config --global user.name "$name"
git config --global user.email "$email"
git config --global safe.directory *
git config --global init.defaultbranch main
git config --global credential.helperselector.selected "<no helper>"
