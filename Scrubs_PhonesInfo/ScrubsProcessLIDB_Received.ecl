import scrubs,scrubs_phonesinfo,std,ut,tools;

EXPORT ScrubsProcessLIDB_Received(string pVersion, string emailList) := function

return scrubs.ScrubsPlus('PhonesInfo','Scrubs_PhonesInfo','Scrubs_PhonesInfo_LIDBReceived','LIDBReceived',pVersion,emailList,false);

end;
