import scrubs,Scrubs_DoNotCall,std,ut,tools;

EXPORT fnRunScrubs(string pVersion, string emailList) := function

return scrubs.ScrubsPlus('DoNotCall','Scrubs_DoNotCall','Scrubs_DoNotCall','',pVersion,emailList,false);
				
end;