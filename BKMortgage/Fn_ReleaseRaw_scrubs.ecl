IMPORT scrubs, Scrubs_BKMortgage_Release, ut, std, tools;

EXPORT Fn_ReleaseRaw_scrubs (DATASET(RECORDOF(BKMortgage.Layouts.Release_Raw_out_ext)) Release_in, string version, string emailList='' ) := FUNCTION

	recordsToScrub := Release_in;

	RETURN Scrubs.ScrubsPlus_PassFile(recordsToScrub,'BKMortgage_Release','Scrubs_BKMortgage_Release','Scrubs_BKMortgage_Release','',version,emailList);
END;