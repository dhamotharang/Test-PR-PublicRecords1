IMPORT scrubs, Scrubs_BKForeclosure_Nod, ut, std, tools;

EXPORT Fn_NodRaw_scrubs (dataset(recordof(BKForeclosure.layout_BK.nod_in)) Nod_in, string version, string emailList='' ) := function


recordsToScrub := Nod_in;

return Scrubs.ScrubsPlus_PassFile(recordsToScrub,'BKForeclosure_Nod','Scrubs_BKForeclosure_Nod','Scrubs_BKForeclosure_Nod','',version,emailList);
END;