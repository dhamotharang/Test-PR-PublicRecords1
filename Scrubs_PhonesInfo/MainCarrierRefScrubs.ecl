IMPORT Scrubs, Scrubs_phonesinfo, Std, Ut, Tools;

EXPORT MainCarrierRefScrubs(string pVersion, string emailList) := FUNCTION

	RETURN scrubs.ScrubsPlus('PhonesInfo', 'Scrubs_PhonesInfo', 'Scrubs_PhonesInfo_CarrierReferenceMain', 'CarrierReferenceMain', pVersion, emailList, false);

END;