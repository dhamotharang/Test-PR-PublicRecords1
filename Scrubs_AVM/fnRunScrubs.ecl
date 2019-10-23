import scrubs,Scrubs_AVM,std,ut,tools;

EXPORT fnRunScrubs(string pVersion, string emailList) := function

return ordered(
				scrubs.ScrubsPlus('AVM','Scrubs_AVM','Scrubs_AVM_Base','Base',pVersion,emailList,false),
				scrubs.ScrubsPlus('AVM','Scrubs_AVM','Scrubs_AVM_Comps','Comps',pVersion,emailList,false),
				scrubs.ScrubsPlus('AVM','Scrubs_AVM','Scrubs_AVM_Medians','Medians',pVersion,emailList,false)
				);

end;