import scrubs,scrubs_phonesinfo,std,ut,tools;



EXPORT IndividualBaseFileScrubs(string pVersion, string emailList) := function


return	sequential(
									 scrubs.ScrubsPlus('PhonesInfo','Scrubs_PhonesInfo','Scrubs_PhonesInfo_DeactMain2','DeactMain2',pVersion,emailList,false),
									 scrubs.ScrubsPlus('PhonesInfo','Scrubs_PhonesInfo','Scrubs_PhonesInfo_iConectivMain','iConectivMain',pVersion,emailList,false),
									 );

end;
