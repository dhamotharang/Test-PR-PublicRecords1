import scrubs,Scrubs_FAA,std,ut,tools;

EXPORT fnRunScrubs(string pVersion, string emailList) := function

return ordered(
				scrubs.ScrubsPlus('FAA','Scrubs_FAA','Scrubs_FAA_Airmen','Airmen',pVersion,emailList,false),
				scrubs.ScrubsPlus('FAA','Scrubs_FAA','Scrubs_FAA_Airmen_Cert','Airmen_Cert',pVersion,emailList,false),
				scrubs.ScrubsPlus('FAA','Scrubs_FAA','Scrubs_FAA_Aircraft','Aircraft',pVersion,emailList,false)
				);

end;