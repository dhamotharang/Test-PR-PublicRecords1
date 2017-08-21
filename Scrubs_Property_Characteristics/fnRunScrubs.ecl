import scrubs,Scrubs_Property_Characteristics,std,ut,tools;
EXPORT fnRunScrubs(string pversion, string emailList) := function
	return scrubs.ScrubsPlus('Property_Characteristics','Scrubs_Property_Characteristics','Scrubs_Property_Characteristics','',pversion,emailList,false);
end;