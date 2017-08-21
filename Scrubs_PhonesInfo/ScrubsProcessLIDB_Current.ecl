import scrubs,scrubs_phonesinfo,std,ut,tools;

EXPORT ScrubsProcessLIDB_Current(string pVersion, string emailList) := function

return scrubs.ScrubsPlus('PhonesInfo','Scrubs_PhonesInfo','Scrubs_PhonesInfo_LIDBCurrent','LIDBCurrent',pVersion,emailList,false);

end;
