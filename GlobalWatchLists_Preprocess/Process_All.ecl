IMPORT GlobalWatchLists, GlobalWatchLists_Preprocess, ut, std, RoxieKeyBuild;

EXPORT Process_All(string	filedate) := FUNCTION
#workunit('name','GWL Preprocess Build ' + filedate);

FileSpray	:= GlobalWatchLists_Preprocess.SprayAllFiles();
//ut.MAC_SF_BuildProcess(GlobalWatchLists_Preprocess.ProcessGlobalWatchlists,'~thor_data400::base::globalwatchlists',GlobalWatchListsBuild,3)

Results :=  sequential(FileSpray,	GlobalWatchLists_Preprocess.ProcessGlobalWatchlists(filedate));

RETURN Results;

END;
									
	

	