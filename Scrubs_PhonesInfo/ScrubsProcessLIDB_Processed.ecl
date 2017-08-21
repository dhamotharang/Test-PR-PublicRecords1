import scrubs,scrubs_phonesinfo,std,ut,tools;

EXPORT ScrubsProcessLIDB_Processed(string pVersion, string emailList) := function

return scrubs.ScrubsPlus('PhonesInfo','Scrubs_PhonesInfo','Scrubs_PhonesInfo_LIDBProcessed','LIDBProcessed',pVersion,emailList,false);

end;
