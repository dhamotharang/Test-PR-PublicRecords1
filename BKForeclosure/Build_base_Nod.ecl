IMPORT $;

EXPORT Build_base_Nod := MODULE
#option('multiplePersistInstances',FALSE);

	EXPORT	NODBaseDelFlag := fSetDelFlag.NOD(BKForeclosure.File_BK_Foreclosure.fNod);
	EXPORT	NODIngestPrep	 := NOD_prep_ingest_file;
	EXPORT	IngestNOD			 := NOD_Ingest(,,NodBaseDelFlag,NODIngestPrep);
	EXPORT	NewNodBase		 := IngestNod.AllRecords_NoTag : PERSIST('~thor_data400::in::BKForeclosure::Ingest_Nod');
	EXPORT	Norm_Nod       := Normalize_Nod(NewNodBase(Delete_Flag <> 'DELETE'));
	EXPORT	Clean_Nod 		 := ClnName_address_NOD(Norm_Nod);
	EXPORT	Append_ID_Nod  := Append_IDs.Append_nod(Clean_Nod);
	EXPORT	DeNorm_Nod     := Denorm_NOD(NewNodBase, Append_ID_Nod);

END;
