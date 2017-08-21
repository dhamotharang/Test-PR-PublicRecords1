IMPORT BKForeclosure,Scrubs_BKForeclosure_Nod;
EXPORT Build_Base(STRING filedate) := MODULE
SHARED superfile_Nod  := '~thor_data400::base::BKForeclosure_Nod';
SHARED superfile_Reo  := '~thor_data400::base::BKForeclosure_Reo';
        // Build base file for Nod
        File_Nod       := BKForeclosure.File_Nod_Clean_in(TRIM(delete_flag) <> 'DELETE');
				oinFile_Nod    := OUTPUT(File_Nod,NAMED('inFile_Nod'));
        Norm_Nod       := Normalize_Nod(File_Nod);
				oNorm_Nod      := OUTPUT(Norm_Nod,NAMED('Norm_Nod'));
        Clean_Name_Nod := fClean_Name.nod(Norm_Nod);
				oCln_Name_Nod  := OUTPUT(Clean_Name_Nod,NAMED('Cln_Name_Nod'));
        Clean_Addr_Nod := fClean_Address.cln_nod(Clean_Name_Nod);
				oCln_Addr_Nod  := OUTPUT(Clean_Addr_Nod,NAMED('Cln_Addr_Nod'));
        Append_ID_Nod  := Append_IDs.Append_nod(Clean_Addr_Nod);
				oAppend_Nod    := OUTPUT(Append_ID_Nod,NAMED('Append_Nod'));
        Std_Nod        := fStandardizedCode.StandardizedNod(Append_ID_Nod);
				d_base_nod     := OUTPUT(Std_Nod,,'~thor_data400::base::bkforeclosure::nod::'+filedate,OVERWRITE);		
        AddToSuperfile_Nod(STRING filedate) := FUNCTION
	                     RETURN 	
			                      FileServices.AddSuperFile(superfile_Nod, '~thor_data400::base::bkforeclosure::nod::'+filedate);
                       END;					
EXPORT  BaseNod        := SEQUENTIAL(oinFile_Nod
                                    ,oNorm_Nod
																		,oCln_Name_Nod
																		,oCln_Addr_Nod
																		,oAppend_Nod
                                    ,d_base_nod
																		,AddToSuperfile_Nod(filedate)
																		// ,BKForeclosure.Strata_Population_Stats_Nod(filedate)
                                    ,func_move_file.MoveFile('in::bkforeclosure::nod_infile','using','used')
																		 );

        //Build base file for Reo
        File_Reo       := BKForeclosure.File_Reo_Clean_in(TRIM(delete_flag) <> 'DELETE');
				oinFile_Reo    := OUTPUT(File_Reo,NAMED('inFile_Reo'));
        Norm_Reo       := Normalize_Reo(File_Reo);
				oNorm_Reo      := OUTPUT(Norm_Reo,NAMED('Norm_Reo'));
        Clean_Name_Reo := fClean_Name.reo(Norm_Reo);
				oCln_Name_Reo  := OUTPUT(Clean_Name_Reo,NAMED('Cln_Name_Reo'));
        Clean_Addr_Reo := fClean_Address.cln_reo(Clean_Name_Reo);
				oCln_Addr_Reo  := OUTPUT(Clean_Addr_Reo,NAMED('Cln_Addr_Reo'));
	      Append_ID_Reo  := Append_IDs.Append_reo(Clean_Addr_Reo);
				oAppend_REO    := OUTPUT(Append_ID_Reo,NAMED('Append_Reo'));
        Std_Reo        := fStandardizedCode.StandardizedReo(Append_ID_Reo);
			  d_base_reo     := OUTPUT(Std_Reo,,'~thor_data400::base::BKForeclosure::reo::'+filedate,OVERWRITE);	
        AddToSuperfile_Reo(STRING filedate) := FUNCTION
	                     RETURN 	
			                      FileServices.AddSuperFile(superfile_reo, '~thor_data400::base::bkforeclosure::reo::'+filedate);
                       END;					
 EXPORT BaseReo        := SEQUENTIAL(oinFile_Reo
                                    ,oNorm_Reo
																		,oCln_Name_Reo
																		,oCln_Addr_Reo
																		,oAppend_REO
                                    ,d_base_reo
																		,AddToSuperfile_Reo(filedate)
																		// ,BKForeclosure.Strata_Population_Stats_Reo(filedate)
                                    ,func_move_file.MoveFile('in::bkforeclosure::reo_infile','using','used')
																		);

END;