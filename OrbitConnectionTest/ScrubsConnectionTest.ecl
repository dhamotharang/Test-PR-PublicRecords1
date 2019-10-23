import ut, scrubs, _control,Orbit3SOA, SALT311,std,tools,Scrubs_GlobalWatchlists;

EXPORT ScrubsConnectionTest(string filedate, string emailList='') := FUNCTION

return scrubs.ScrubsPlus_PassFile(OrbitConnectionTest.File_GlobalWatchListsScrubs,'GlobalWatchlists','Scrubs_GlobalWatchlists','Scrubs_ConnectionTestScrubs','',filedate,emailList,false);

end;
