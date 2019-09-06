IMPORT $;

EXPORT Build_Base := MODULE
#option('multiplePersistInstances',FALSE);

EXPORT AssignBase	:= FUNCTION
	//Build Assignment file
	AssignPrevBase		:= BKMortgage.Files().fAssign;
	AssignIngestPrep	:= Assign_prep_ingest_file;
	AssignIngest			:= Assign_Ingest(,,AssignPrevBase,AssignIngestPrep);
	AssignNewBase		 	:= AssignIngest.AllRecords_NoTag;
	
RETURN AssignNewBase;
END;

EXPORT ReleaseBase := FUNCTION
	//Build Release file
	PrevReleaseBase		:= BKMortgage.Files().fRelease;
	ReleaseIngestPrep	:= Release_prep_ingest_file;
	ReleaseIngest			:= Release_Ingest(,,PrevReleaseBase,ReleaseIngestPrep);
	ReleaseNewBase		:= ReleaseIngest.AllRecords_NoTag;
	
RETURN ReleaseNewBase;
END;

END;