sudo apt-get update
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod xenial main" > /etc/apt/sources.list.d/dotnetdev.list'
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install dotnet-sdk-2.1.4

sudo mkdir -p /var/aspnetcore/dnu-chat
dotnet publish ./web/dnu-chat-demo.csproj -f netcoreapp2.1 -c Release -o /var/aspnetcore/dnu-chat
sudo touch /etc/systemd/system/dnu-chat.service
sudo echo "[Unit]
Description=DNU chat demo
Wants=network-online.target
After=network.target network-online.target

[Service]
WorkingDirectory=/var/aspnetcore/dnu-chat
ExecStart=/usr/bin/dotnet /var/aspnetcore/dnu-chat/dnu-chat-demo.dll
Restart=always
RestartSec=10
SyslogIdentifier=dnu-chat
User=pi

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/dnu-chat.service

sudo ufw allow 5000
sudo ufw allow 5001

sudo systemctl enable sk
sudo systemctl start sk
sudo systemctl status sk
