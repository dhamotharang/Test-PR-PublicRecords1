IMPORT scrubs, Scrubs_BKForeclosure_Reo, ut, std, tools;

EXPORT Fn_ReoRaw_scrubs (dataset(recordof(BKForeclosure.layout_BK.reo_in)) Reo_in, string version, string emailList='' ) := function


recordsToScrub := Reo_in;

return Scrubs.ScrubsPlus_PassFile(recordsToScrub,'BKForeclosure_Reo','Scrubs_BKForeclosure_Reo','Scrubs_BKForeclosure_Reo','',version,emailList);
END;