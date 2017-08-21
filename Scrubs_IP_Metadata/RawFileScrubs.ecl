import scrubs, scrubs_ip_metadata, std, ut, tools;

EXPORT RawFileScrubs(string pVersion, string emailList) := function

	return	scrubs.ScrubsPlus('IP_Metadata', 'Scrubs_IP_Metadata', 'Scrubs_IP_Metadata_RawFile', 'RawFile', pVersion, emailList, false);

end;