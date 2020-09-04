import scrubs,scrubs_phonesfeedback,std,ut,tools;

EXPORT fn_RunScrubs(string pversion, string emailList):=function

	return Scrubs.ScrubsPlus_PassFile(Scrubs_PhonesFeedback.In_PhonesFeedback(pversion),'PhonesFeedback','Scrubs_PhonesFeedback','Scrubs_PhonesFeedback','',pVersion,emailList,false);

end;