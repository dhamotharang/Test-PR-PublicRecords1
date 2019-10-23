IMPORT $;

EXPORT Build_base_reo := MODULE
#option('multiplePersistInstances',FALSE);

	EXPORT	REOBaseDelFlag := fSetDelFlag.REO(BKForeclosure.File_BK_Foreclosure.fReo);
	EXPORT	REOIngestPrep	 := REO_prep_ingest_file;
	EXPORT	IngestREO			 := REO_Ingest(,,ReoBaseDelFlag,REOIngestPrep);
	EXPORT	NewReoBase		 := IngestREO.AllRecords_NoTag : PERSIST('~thor_data400::in::BKForeclosure::Ingest_Reo');
	EXPORT	Norm_Reo       := Normalize_Reo(NewReoBase(Delete_Flag <> 'DELETE'));
	EXPORT	Clean_Reo 		 := ClnName_address_REO(Norm_Reo);
	EXPORT	Append_ID_Reo  := Append_IDs.Append_reo(Clean_Reo);
	EXPORT	DeNorm_Reo     := Denorm_REO(NewReoBase, Append_ID_Reo);

END;