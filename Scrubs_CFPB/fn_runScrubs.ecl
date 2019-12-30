import scrubs,Scrubs_CFPB,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion = '', string emailList = '') := function

return scrubs.ScrubsPlus('CFPB','Scrubs_CFPB','Scrubs_CFPB','',pVersion,emailList,false);

end;