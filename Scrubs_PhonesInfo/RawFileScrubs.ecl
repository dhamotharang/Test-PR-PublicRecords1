import scrubs,scrubs_phonesinfo,std,ut,tools;

EXPORT RawFileScrubs(string pVersion, string emailList) := function


return	sequential(
										scrubs.ScrubsPlus('PhonesInfo','Scrubs_PhonesInfo','Scrubs_PhonesInfo_Daily_Raw_Wireless_to_Wireline','Daily_Raw_Wireless_to_Wireline',pVersion,emailList,false),
										scrubs.ScrubsPlus('PhonesInfo','Scrubs_PhonesInfo','Scrubs_PhonesInfo_Daily_Raw_Wireline_to_Wireless','Daily_Raw_Wireline_to_Wireless',pVersion,emailList,false),
										scrubs.ScrubsPlus('PhonesInfo','Scrubs_PhonesInfo','Scrubs_PhonesInfo_In_Port_Daily','In_Port_Daily',pVersion,emailList,false),
										scrubs.ScrubsPlus('PhonesInfo','Scrubs_PhonesInfo','Scrubs_PhonesInfo_DeactRaw2','DeactRaw2',pVersion,emailList,false)
									 );

end;
