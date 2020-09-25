IMPORT scrubs,Scrubs_PhoneFinder;

EXPORT fn_RunScrubs(string pVersion, string emailList = '') := FUNCTION

    return SEQUENTIAL
    (
            scrubs.ScrubsPlus('PhoneFinder','Scrubs_PhoneFinder','Scrubs_PhoneFinder_Identities','Identities',pVersion,emailList,false),
            scrubs.ScrubsPlus('PhoneFinder','Scrubs_PhoneFinder','Scrubs_PhoneFinder_OtherPhones','OtherPhones',pVersion,emailList,false),
            scrubs.ScrubsPlus('PhoneFinder','Scrubs_PhoneFinder','Scrubs_PhoneFinder_RiskIndicators','RiskIndicators',pVersion,emailList,false),
            scrubs.ScrubsPlus('PhoneFinder','Scrubs_PhoneFinder','Scrubs_PhoneFinder_Transactions','Transactions',pVersion,emailList,false),
	    scrubs.ScrubsPlus('PhoneFinder','Scrubs_PhoneFinder','Scrubs_PhoneFinder_Sources','Sources',pVersion,emailList,false)
    );

END;