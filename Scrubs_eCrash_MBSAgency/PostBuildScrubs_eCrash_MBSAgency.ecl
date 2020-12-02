IMPORT Scrubs;

EXPORT PostBuildScrubs_eCrash_MBSAgency(STRING pVersion, STRING emailList) := FUNCTION

	RETURN Scrubs.ScrubsPlus('ecrash_MBSAgency', 'Scrubs_eCrash_MBSAgency', 'Scrubs_eCrash_MBSAgency', '', pVersion, emailList, FALSE, TRUE);

END;
