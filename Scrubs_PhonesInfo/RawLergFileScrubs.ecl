IMPORT Scrubs, Scrubs_Phonesinfo, Std, Ut, Tools;

EXPORT RawLergFileScrubs(string pVersion, string emailList) := FUNCTION

	RETURN sequential(Scrubs.ScrubsPlus('PhonesInfo', 'Scrubs_PhonesInfo', 'Scrubs_PhonesInfo_Lerg1Raw', 'Lerg1Raw', pVersion, emailList, false),
										Scrubs.ScrubsPlus('PhonesInfo', 'Scrubs_PhonesInfo', 'Scrubs_PhonesInfo_Lerg1ConRaw', 'Lerg1ConRaw', pVersion, emailList, false),
										Scrubs.ScrubsPlus('PhonesInfo', 'Scrubs_PhonesInfo', 'Scrubs_PhonesInfo_Lerg6Raw', 'Lerg6Raw', pVersion, emailList, false)
										);

END;