import scrubs,scrubs_sanctnkeys,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList) := function

return 
sequential(
scrubs.ScrubsPlus('SANCTNKeys','Scrubs_SANCTNKeys','Scrubs_SANCTNKeys_incident','incident',pVersion,emailList,false),
scrubs.ScrubsPlus('SANCTNKeys','Scrubs_SANCTNKeys','Scrubs_SANCTNKeys_license','license',pVersion,emailList,false),
scrubs.ScrubsPlus('SANCTNKeys','Scrubs_SANCTNKeys','Scrubs_SANCTNKeys_party','party',pVersion,emailList,false),
scrubs.ScrubsPlus('SANCTNKeys','Scrubs_SANCTNKeys','Scrubs_SANCTNKeys_party_aka_dba','party_aka_dba',pVersion,emailList,false),
scrubs.ScrubsPlus('SANCTNKeys','Scrubs_SANCTNKeys','Scrubs_SANCTNKeys_rebuttal','rebuttal',pVersion,emailList,false)
);

end;