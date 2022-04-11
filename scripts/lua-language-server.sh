mkdir -p ~/.local/bin
mkdir -p ~/.local/lua-lsp
curl -L https://github.com/sumneko/lua-language-server/releases/download/3.0.1/lua-language-server-3.0.1-linux-x64.tar.gz | tar -zxf - --directory ~/.local/lua-lsp
rm ~/.local/bin/lua-language-server
ln -s ~/.local/lua-lsp/bin/lua-language-server ~/.local/bin/lua-language-server
chmod +x ~/.local/bin/lua-language-server

