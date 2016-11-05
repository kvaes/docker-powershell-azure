FROM ubuntu:xenial

MAINTAINER Karim Vaes <dockerfile@kvaes.be>

# Powershell Source : https://github.com/PowerShell/PowerShell/releases/
ARG POWERSHELL_RELEASE=v6.0.0-alpha.12
ARG POWERSHELL_PACKAGE=powershell_6.0.0-alpha.12-1ubuntu1.16.04.1_amd64.deb
# dotnetcore Source : https://apt-mo.trafficmanager.net/repos/dotnet-release/pool/main/d/
ARG DOTNETCORE_PACKAGE=dotnet-dev-1.0.0-preview2.1-003155

RUN apt-get update \
    && apt-get install apt-transport-https curl -y \
    && sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list' \
    && apt-get update \
    && sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893 \
    && apt-get update \
    && apt-get install $DOTNETCORE_PACKAGE -y \
    && mkdir /powershell \
    && apt-get clean

WORKDIR /powershell
	
# Install PowerShell package and clean up
RUN curl -SLO https://github.com/PowerShell/PowerShell/releases/download/$POWERSHELL_RELEASE/$POWERSHELL_PACKAGE \
    && apt-get install libunwind8 libicu55 \
    && dpkg -i $POWERSHELL_PACKAGE \
    && rm $POWERSHELL_PACKAGE \
	&& apt-get clean

RUN powershell -Command "Install-Package -Name AzureRM.NetCore.Preview -Source https://www.powershellgallery.com/api/v2 -ProviderName NuGet -ExcludeVersion -Destination /usr/local/share/powershell/Modules -Force"

# Use array to avoid Docker prepending /bin/sh -c
ENTRYPOINT [ "powershell" ]