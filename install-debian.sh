
# Update repositories
sudo apt-get update

# Add dotnet core packages repos
sudo apt-get install curl libunwind8 gettext apt-transport-https
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/dotnetdev.list'
sudo apt-get install apt-transport-https
sudo apt-get update

# install dotnet core runtime
sudo apt-get install dotnet-sdk-2.1.300-preview1-008174

# Prepare folders and build app
sudo mkdir -p /var/aspnetcore/dnu-chat
dotnet publish ./web/dnu-chat-demo.csproj -f netcoreapp2.1 -c Release -o /var/aspnetcore/dnu-chat

# Create systemd file
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
User=root

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/dnu-chat.service

# Open firewall ports
sudo ufw allow 5000
sudo ufw allow 5001

# Enable and start 
sudo systemctl enable sk
sudo systemctl start sk
sudo systemctl status sk
