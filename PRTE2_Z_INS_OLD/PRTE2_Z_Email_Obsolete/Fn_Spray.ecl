
EXPORT Fn_Spray(STRING lzCsvFilePath, String fileVersion) := MODULE

		SHARED CSVSprayFieldSeparator				:= '\\,';
		SHARED CSVSprayLineSeparator				:= '\\n,\\r\\n';
		SHARED CSVSprayQuote								:= '';
		
		SHARED CSVOutFieldSeparator					:= ',';
		SHARED CSVOutQuote									:= '"';

		// ---- spray file from landing zone ----- Distributed ready for Phase1 to populate and clean --------
		// -----------------------------------------------------------------------------
		SHARED Fn_Spray_Action := FileServices.SprayVariable(_constants.EDATA11,					// file landing zone
																					lzCsvFilePath,										// path to file on landing zone
																					8192,															// maximum record size
																					CSVSprayFieldSeparator,						// field separator(s)
																					CSVSprayLineSeparator,						// line separator(s)
																					CSVSprayQuote,		  							// text quote character
																					ThorLib.Cluster(),								// destination THOR cluster
																					_constants.fileSprayedString,			// destination file
																					-1,												  			// -1 means no timeout
																						,													  		// use default ESP server IP port
																						,														 	 	// use default maximum connections
																					TRUE,												 		 	// allow overwrite
																					TRUE,												  		// replicate
																					FALSE												  		// do not compress
																					);
		// -----------------------------------------------------------------------------
		// ---- spray file from landing zone ----- Distributed ready for Phase1 to populate and clean --------
		EXPORT SprayFileStep := Fn_Spray_Action;

		// Performs Phase 1 build step and PERSIST
		EXPORT Phase1PersistFileAction := p1_build_base(fileVersion).p1_final_base_out;
		// when the above 2 lines run, we will have contents in _files.Phase1_Output_File

		// ----- Set up builder to run secondary process to populate and clean phase1 dataset ------------
		EXPORT new_email_base	:= Build_base(fileVersion).BuiltEmailDataSet;
		// after this line runs you will have the SF: _files.File_Email_Base_DS

		// Cleanup - delete sprayed file and the persisted intermediate file.
		EXPORT deleteSpray := FileServices.DeleteLogicalFile(_constants.fileSprayedString);
		EXPORT deletePhase1output := FileServices.DeleteLogicalFile(_constants.phase1PersistFileString);
		// -----------------------------------------------------------------------------
		// ut.MAC_SF_BuildProcess does not create an initial SF so must do it here if it doesn't exist.
		localCreateSuperFile(DATASET(_layouts.base) theDS) := FUNCTION
				STRING basename := _constants.baseSuperFileString;
				RETURN SEQUENTIAL ( 
							FileServices.StartSuperFileTransaction(),
								FileServices.CreateSuperFile(basename),
								FileServices.CreateSuperFile(basename+	'_father'),
							FileServices.FinishSuperFileTransaction());
		END;
		EXPORT firstTimeSF(DATASET(_layouts.base) theDS) := FUNCTION
				RETURN IF (~FileServices.SuperfileExists(_constants.baseSuperFileString), localCreateSuperFile(theDS) );
		END;
	
		// ==================================================================================
		EXPORT Spray_and_BuildMain() := FUNCTION
				import ut;
				// output and associate to superfile (and move older files into older generation superfiles)		
        buildMain_base_FirstTime_step := firstTimeSF(new_email_base);
				ut.MAC_SF_BuildProcess(new_email_base, _constants.baseSuperFileString ,buildMain_base_Mac_step,2,,false);

				sequentialSteps := SEQUENTIAL(SprayFileStep, Phase1PersistFileAction,
																			buildMain_base_FirstTime_step, buildMain_base_Mac_step,
																			deleteSpray, deletePhase1output
																);

				RETURN sequentialSteps;
		END;


		// ==================================================================================
		EXPORT Spray_and_AppendNew() := FUNCTION
				import ut;	

				// ----- Append new data with existing data
				mergedAll		:= _files.File_Email_Base_DS + new_email_base;				

				// output and associate to superfile (and move older files into older generation superfiles)		
        buildAppend_base_FirstTime_step := firstTimeSF(mergedAll);
				ut.MAC_SF_BuildProcess(mergedAll, _constants.baseSuperFileString ,buildAppend_base_Mac_step,2,,false);

				sequentialSteps := SEQUENTIAL(SprayFileStep, Phase1PersistFileAction,
																			buildAppend_base_FirstTime_step, buildAppend_base_Mac_step,
																			deleteSpray, deletePhase1output);
				
				RETURN sequentialSteps;
		END;

END;