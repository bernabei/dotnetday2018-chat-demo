FROM microsoft/aspnetcore:2.1.0-preview1
WORKDIR /chat
COPY /publish .
EXPOSE 5000
ENTRYPOINT ["dotnet", "dnu-chat-demo.dll"]
