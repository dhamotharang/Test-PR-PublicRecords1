import scrubs,scrubs_phonesinfo,std,ut,tools;

EXPORT PostBuildScrubs(string pVersion, string emailList) := function
return	scrubs.ScrubsPlus('PhonesInfo','Scrubs_PhonesInfo','Scrubs_PhonesInfo_BaseFile','BaseFile',pVersion,emailList,false);
end;
