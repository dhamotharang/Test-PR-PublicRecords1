IMPORT Scrubs, Scrubs_phonesinfo, Std, Ut, Tools;

EXPORT MainCarrierRefScrubs(string pVersion, string emailList) := FUNCTION

	RETURN SEQUENTIAL(Scrubs.ScrubsPlus('PhonesInfo', 'Scrubs_PhonesInfo', 'Scrubs_PhonesInfo_CarrierReferenceMain', 'CarrierReferenceMain', pVersion, emailList, false);
										Scrubs.ScrubsPlus('PhonesInfo', 'Scrubs_PhonesInfo', 'Scrubs_PhonesInfo_Lerg6Main', 'Lerg6Main', pVersion, emailList, false)
										);
END;