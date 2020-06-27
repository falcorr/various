function FindProxyForURL(url, host) 
{
	// Geo-blocking
	if (shExpMatch(url, "*tvnz.co.nz*") || shExpMatch(url, "*freeviewnz.tv*") || shExpMatch(url, "*threenow.co.nz*") || shExpMatch(url, "*maoritelevision.com*"))
	{
		return "SOCKS user@party.net:pass@newzealand.vpn.com"
	}
		
	// Region
	if (shExpMatch(url, "*.cn*"))
	{
		return "SOCKS user@party.net:pass@choice.vpn.com";
	}
	
	// Protocol
	if (url.substring(0, 4)=="hkp:" || url.substring(0, 5)=="hkps:")
	{
		return "SOCKS localhost:8080"; 
	}
	
	// Proxy
	if (shExpMatch(url, "*seedbox.com*") || url.substring(0, 4)=="ftp:")
	{
		return "SOCKS localhost:8080"; 
	}
	
	// Ah, whatever
	if (url.substring(0, 6)=="https:" || url.substring(0, 5)=="sftp:" || url.substring(0, 6)=="ftpes:")
	{
		return "DIRECT";
	}
	
	// Else
	return "DIRECT";
 
}