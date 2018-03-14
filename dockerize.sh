dotnet publish ./web/dnu-chat-demo.csproj -f netcoreapp2.1 -c Release -o ../publish
sudo docker build -t dnu/chatdemo .
sudo docker run -d -p 5000:5000 -p 5001:5001 --name=chatdemo --restart unless-stopped dnu/chatdemo
