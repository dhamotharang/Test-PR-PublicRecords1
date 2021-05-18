IMPORT Std, _Control, Data_Services, FLAccidents_Ecrash;

EXPORT Update_Citation_CitationDetail1() := FUNCTION

Location := IF(_Control.ThisEnvironment.Name = 'Prod_Thor', '~', Data_Services.foreign_prod);

	Layout_CitationDetail1Extract := RECORD
		STRING Citation_ID;
		STRING Incident_ID;
		STRING Citation_Detail1; 
	END;

	//Below is the extract from eCrash team with Citation_Detail1 fixed values(ECH-49095)
	ds_CitationDetail1 := DATASET(Data_Services.foreign_prod + 'thor::spray::ecrash::fix_citation_detail1_data_20210517',
																Layout_CitationDetail1Extract,
															  CSV(HEADING(1), TERMINATOR(['\n','\r\n','\n\r']), SEPARATOR(','), QUOTE('"')));
															
	FLAccidents_Ecrash.mac_CleanFields(ds_CitationDetail1, Clean_ds_CitationDetail1);
	ds_CitationDetail1_Uniq := DEDUP(SORT(DISTRIBUTE(Clean_ds_CitationDetail1, HASH32(Incident_ID, Citation_ID)),
																				Incident_ID, Citation_ID, LOCAL),
																	 Incident_ID, Citation_ID, LOCAL);																		
																		
	//Citation File													
	Layout_Citation := FLAccidents_Ecrash.Layout_Infiles.Citation;
	ds_citation := FLAccidents_Ecrash.Infiles.Citation;                  
	ds_citation_dist := DISTRIBUTE(ds_citation, HASH32(Incident_ID, Citation_ID));

	Layout_Citation tUpdateCitationDetail1(ds_citation_dist L, ds_CitationDetail1_Uniq R) := TRANSFORM
		IsMatching := TRIM(L.Incident_ID, LEFT, RIGHT) = TRIM(R.Incident_ID, LEFT, RIGHT) AND
									TRIM(L.Citation_ID, LEFT, RIGHT) = TRIM(R.Citation_ID, LEFT, RIGHT);
		SELF.Citation_Detail1 := IF(IsMatching, R.Citation_Detail1, L.Citation_Detail1);
		SELF := L;
	END;
	Update_Citation_CitationDetail1 := JOIN(ds_citation_dist, ds_CitationDetail1_Uniq,
																	        TRIM(LEFT.Incident_ID, LEFT, RIGHT) = TRIM(RIGHT.Incident_ID, LEFT, RIGHT) AND
																	        TRIM(LEFT.Citation_ID, LEFT, RIGHT) = TRIM(RIGHT.Citation_ID, LEFT, RIGHT),													 
																	        tUpdateCitationDetail1(LEFT, RIGHT), LEFT OUTER, LOCAL);
						
	ds_Citation_Upd_Out := OUTPUT(Update_Citation_CitationDetail1 ,, Files.Citation_Raw_LF('CitationDetail1Update'), OVERWRITE, __COMPRESSED__,
																CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
	 
	Updated_Citation_Raw := SEQUENTIAL(
																	   ds_Citation_Upd_Out,
																	   STD.File.StartSuperFileTransaction(),
																	   STD.File.ClearSuperFile(Files.Citation_Raw_SF, FALSE),
																	   STD.File.AddSuperFile(Files.Citation_Raw_SF, 
																												   Files.Citation_Raw_LF('CitationDetail1Update')),
																	   STD.File.FinishSuperFileTransaction()
																    );
 RETURN Updated_Citation_Raw;
END;
