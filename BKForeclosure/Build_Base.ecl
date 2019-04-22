IMPORT BKForeclosure;//, Scrubs_BKForeclosure_Nod, Scrubs_BKForeclosure_Reo;
#option('multiplePersistInstances',FALSE);

EXPORT Build_Base(STRING filedate) := MODULE
SHARED superfile_Nod  := '~thor_data400::base::BKForeclosure::Nod';
SHARED superfile_Reo  := '~thor_data400::base::BKForeclosure::Reo';
        // Build base file for Nod
				CountNodIn		 := OUTPUT(COUNT(BKForeclosure.File_BK_Foreclosure.Nod_File),NAMED('Total_NOD_in'));
        NODBaseDelFlag := BKForeclosure.fSetDelFlag.NOD(BKForeclosure.File_BK_Foreclosure.fNod);
				NODIngestPrep	 := BKForeclosure.NOD_prep_ingest_file;
				IngestNOD			 := BKForeclosure.NOD_Ingest(,,NodBaseDelFlag,NODIngestPrep);
				NewNodBase		 := IngestNod.AllRecords_NoTag : PERSIST('~thor_data400::in::BKForeclosure::Ingest_Nod');
        Norm_Nod       := Normalize_Nod(NewNodBase(Delete_Flag <> 'DELETE'));
        Clean_Nod 		 := ClnName_address_NOD(Norm_Nod);
        Append_ID_Nod  := Append_IDs.Append_nod(Clean_Nod);
        DeNorm_Nod     := Denorm_NOD(NewNodBase, Append_ID_Nod);
				CountDelNod_out:= OUTPUT(COUNT(DeNorm_Nod(Delete_Flag = 'DELETE')),NAMED('TotalDel_NOD_out')); //True Deletes
				CountNod_out	 := OUTPUT(COUNT(DeNorm_Nod(Delete_Flag <> 'DELETE')),NAMED('Total_NOD_out'));
        PromoteSupers.Mac_SF_BuildProcess(DeNorm_Nod,'~thor_data400::base::bkforeclosure::nod',build_nod_base,3,,true);
 					
EXPORT  BaseNod        := SEQUENTIAL(CountNodIn
                                    ,build_nod_base
																		,CountDelNod_out
																		,CountNod_out
																		// ,BKForeclosure.Strata_Population_Stats_Nod(filedate)
																		//,Scrubs_BKForeclosure_Nod;
																		 );

        //Build base file for Reo
				CountReoIn		 := OUTPUT(COUNT(BKForeclosure.File_BK_Foreclosure.Reo_File),NAMED('Total_REO_in'));
        ReoBaseDelFlag := BKForeclosure.fSetDelFlag.REO(BKForeclosure.File_BK_Foreclosure.fReo);
				REOIngestPrep	 := BKForeclosure.REO_prep_ingest_file;
				IngestREO			 := BKForeclosure.REO_Ingest(,,ReoBaseDelFlag,REOIngestPrep);
				NewReoBase		 := IngestReo.AllRecords_NoTag : PERSIST('~thor_data400::in::BKForeclosure::Ingest_Reo');
        Norm_Reo       := Normalize_Reo(NewReoBase(Delete_Flag <> 'DELETE'));
        Clean_Reo 		 := ClnName_address_REO(Norm_Reo);
        Append_ID_Reo  := Append_IDs.Append_reo(Clean_Reo);
        DeNorm_Reo     := Denorm_REO(NewReoBase, Append_ID_Reo);
				CountDelReo_out:= OUTPUT(COUNT(DeNorm_Reo(Delete_Flag = 'DELETE')),NAMED('TotalDel_REO_out')); //True Deletes
				CountReo_out	 := OUTPUT(COUNT(DeNorm_Reo(Delete_Flag <> 'DELETE')),NAMED('Total_REO_out'));
        PromoteSupers.Mac_SF_BuildProcess(DeNorm_Reo,'~thor_data400::base::bkforeclosure::reo',build_reo_base,3,,true);
				
 EXPORT BaseReo        := SEQUENTIAL(ReoBaseDelFlag
                                    ,CountDel_Reo_in
                                    ,build_reo_base
																		,CountDelReo_out
																		,CountReo_out
																		// ,BKForeclosure.Strata_Population_Stats_Reo(filedate)
																		//,Scrubs_BKForeclosure_Reo;
																		);

END;