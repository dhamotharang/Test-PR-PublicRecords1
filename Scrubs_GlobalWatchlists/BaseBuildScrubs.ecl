import ut, scrubs, _control,Orbit3SOA, SALT33,std,tools;

EXPORT BaseBuildScrubs(string filedate, string emailList='') := FUNCTION

return scrubs.ScrubsPlus('GlobalWatchlists','Scrubs_GlobalWatchlists','Scrubs_GlobalWatchlists','',filedate,emailList,false);

end;
