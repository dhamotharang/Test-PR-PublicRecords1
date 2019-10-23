import scrubs,Scrubs_DoNotMail,std,ut,tools;

EXPORT fnRunScrubs(string pVersion, string emailList) := function

return scrubs.ScrubsPlus('DoNotMail','Scrubs_DoNotMail','Scrubs_DoNotMail','',pVersion,emailList,false);
				
end;