IMPORT $;

EXPORT Build_Release := MODULE
#option('multiplePersistInstances',FALSE);

EXPORT UpdateBase	:= FUNCTION
	//Build Update file
	PrevUpdateBase		:= BKMortgage_Release.Files().fReleaseUpdate;
	UpdateIngestPrep	:= ReleaseUpdate_prep_ingest_file;
	IngestUpdate			:= ReleaseUpdate_Ingest(,,PrevUpdateBase,UpdateIngestPrep);
	NewUpdateBase		 	:= IngestUpdate.AllRecords_NoTag;
	
RETURN NewUpdateBase;
END;

EXPORT RefreshBase := FUNCTION
	//Build Refresh file
	PrevRefreshBase		:= BKMortgage_Release.Files().fReleaseRefresh;
	RefreshIngestPrep	:= ReleaseRefresh_prep_ingest_file;
	IngestRefresh			:= ReleaseRefresh_Ingest(,,PrevRefreshBase,RefreshIngestPrep);
	NewRefreshBase		:= IngestRefresh.AllRecords_NoTag;
	
RETURN NewRefreshBase;
END;

END;
