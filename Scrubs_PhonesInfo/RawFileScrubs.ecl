import scrubs,scrubs_phonesinfo,std,ut,tools;

EXPORT RawFileScrubs(string pVersion, string emailList) := function

	return	sequential(	scrubs.ScrubsPlus('PhonesInfo', 'Scrubs_PhonesInfo', 'Scrubs_PhonesInfo_PortData_ValidateIn', 'PortData_ValidateIn', pVersion, emailList, false),										
											scrubs.ScrubsPlus('PhonesInfo', 'Scrubs_PhonesInfo', 'Scrubs_PhonesInfo_DeactRaw2', 'DeactRaw2', pVersion, emailList, false)
										);

end;
