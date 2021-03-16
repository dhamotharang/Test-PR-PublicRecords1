import scrubs, scrubs_phonesinfo, std, ut, tools;

EXPORT PostBuildScrubs(string pVersion, string emailList) := function
	
	return	scrubs.ScrubsPlus('PhonesInfo', 'Scrubs_PhonesInfo', 'Scrubs_PhonesInfo_PhonesTransactionMain2', 'PhonesTransactionMain2', pVersion, emailList, false);

end;
