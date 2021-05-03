IMPORT scrubs, Scrubs_BKMortgage_Assignments, ut, std, tools;

EXPORT Fn_AssignRaw_scrubs (DATASET(recordof(BKMortgage.Layouts.Assign_Raw_out_ext)) Assign_in, string version, string emailList='' ) := FUNCTION

	recordsToScrub := Assign_in;

	RETURN Scrubs.ScrubsPlus_PassFile(recordsToScrub,'BKMortgage_Assignments','Scrubs_BKMortgage_Assignments','Scrubs_BKMortgage_Assignments','',version,emailList);
END;