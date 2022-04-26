rm -rf ~/.asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0
echo $'\n# asdf config' >> ~/.bashrc
echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
. ~/.bashrc

packages=(
"neovim"
"direnv"
"fzf"
"gitui"
"rust"
"rust-analyzer:Xyven1/asdf-rust-analyzer"
"lua"
"lua-language-server:spencergilbert/asdf-lua-language-server"
"golang"
"erlang"
"elixir"
"nodejs"
"haskell"
)

for value in ${packages[@]}; do
    vals=(${value//:/ })
    if((${#vals[@]} == 2)); then
        asdf plugin-add ${vals[0]} "https://github.com/${vals[1]}.git"
    else
        asdf plugin-add ${vals[0]}
    fi
done
