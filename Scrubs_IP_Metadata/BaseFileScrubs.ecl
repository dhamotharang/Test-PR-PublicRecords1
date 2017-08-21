import scrubs, scrubs_ip_metadata, std, ut, tools;

EXPORT BaseFileScrubs(string pVersion, string emailList) := function
	
	return	scrubs.ScrubsPlus('IP_Metadata', 'Scrubs_IP_Metadata', 'Scrubs_IP_Metadata_BaseFile', 'BaseFile', pVersion, emailList, false);

end;
