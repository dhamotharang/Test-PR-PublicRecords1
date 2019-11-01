import scrubs,Scrubs_Phonesplus_v2_Base, ut, std, tools;

EXPORT Fn_Invoke_scrubs (dataset(recordof(Phonesplus_v2.Layout_PhonesPlus_Base)) phplus_in, string version, string emailList='' ) := function


recordsToScrub := phplus_in;

return Scrubs.ScrubsPlus_PassFile(recordsToScrub,'Phonesplus_v2_Base','Scrubs_Phonesplus_v2_Base','Scrubs_Phonesplus_base','',version,emailList);
END;


