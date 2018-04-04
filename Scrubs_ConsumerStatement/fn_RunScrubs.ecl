import scrubs,Scrubs_ConsumerStatement,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList) := function

return sequential(
scrubs.ScrubsPlus('ConsumerStatement','Scrubs_ConsumerStatement','Scrubs_ConsumerStatement_DataFileNonFCRA','DataFileNonFCRA',pVersion,emailList,false),
scrubs.ScrubsPlus('ConsumerStatement','Scrubs_ConsumerStatement','Scrubs_ConsumerStatement_RawFileNonFCRA','RawFileNonFCRA',pVersion,emailList,false)
);

end;