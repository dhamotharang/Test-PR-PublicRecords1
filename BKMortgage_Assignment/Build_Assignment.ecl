IMPORT $;

EXPORT Build_Assignment := MODULE
#option('multiplePersistInstances',FALSE);

EXPORT UpdateBase	:= FUNCTION
	//Build Update file
	PrevUpdateBase		:= BKMortgage_Assignment.Files().fAssignUpdate;
	UpdateIngestPrep	:= AssignUpdate_prep_ingest_file;
	IngestUpdate			:= AssignUpdate_Ingest(,,PrevUpdateBase,UpdateIngestPrep);
	NewUpdateBase		 	:= IngestUpdate.AllRecords_NoTag;
	
RETURN NewUpdateBase;
END;

EXPORT RefreshBase := FUNCTION
	//Build Refresh file
	PrevRefreshBase		:= BKMortgage_Assignment.Files().fAssignRefresh;
	RefreshIngestPrep	:= AssignRefresh_prep_ingest_file;
	IngestRefresh			:= AssignRefresh_Ingest(,,PrevRefreshBase,RefreshIngestPrep);
	NewRefreshBase		:= IngestRefresh.AllRecords_NoTag;
	
RETURN NewRefreshBase;
END;

END;
