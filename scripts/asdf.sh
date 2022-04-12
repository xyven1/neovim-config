rm -rf ~/.asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0
echo $'\n# asdf config' >> ~/.bashrc
echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
. ~/.bashrc

for value in neovim direnv fzf gitui rust lua lua-language-server golang erland elixir nodejs haskell
do
    asdf plugin-add $value
done
