// This version leaves in a lot of old original production build process steps 
// -- keep long enough to determine if we need any of these in CT or not


EXPORT z__BWR_FN_Build_Email_ORIG_TMP(String fileVersion='', STRING filePathToUse, BOOLEAN bIsFullRebuild) := FUNCTION
#workunit('name','CT Email Data ' + fileVersion);
			import ut;
			// Can do this for the idops or orbit stuff - or else just stick them in the _constants
			// EXPORT BuildParameters := Fn_Spray.Generate_Parameters(fileVersion, filePathToUse);

			rebuildMain					:= Fn_Spray.Spray_and_BuildMain(filePathToUse, fileVersion);
			appendNewToMain			:= Fn_Spray.Spray_and_AppendNew(filePathToUse, fileVersion);
			
			// base files
			buildBaseMain 				:= IF(bIsFullRebuild, rebuildMain, appendNewToMain); // full rebuild or add new to existing base
			
			// TRANSLATE TO NEW APPEND/CREATE approach
				email_base := Build_base(fileVersion).rollup_with_history_misc;	//creates file = phase1SuperFileString			
				ut.MAC_SF_BuildProcess(email_base, _constants.baseSuperFileString ,build_email_base,2,,true);

				// ====== We are leaving out the FCRA sections and the Statistics sections of the CT build.
				// email_fcra_base := Build_base(fileVersion).rollup_email_orig;
				// ut.MAC_SF_BuildProcess(email_fcra_base, _constants.baseFCRASuperFileName ,build_email_base_fcra,2,,true);

				Build_all_keys := Build_keys(fileVersion);
				// zDoPopulationStats:=Strata_Stat_Email(fileVersion,File_Email_Base_DS);
				// zDoPopulationVendorStats:=Strata_Stat_Vendor(fileVersion,File_Email_Base_DS);

			
			
			// ??? ------------------------   Do we have these? -------------------------------------------------------
			// idopsUpdate						:= CustomerTest_Common.idops_Update(BuildParameters.idopsDataName,
																																// BuildParameters.fileDate,
																																// BuildParameters.idopsEmailTo,
																																// BuildParameters.idopsEnvironment);			
			// orbitUpdate						:= CustomerTest_Common.orbit_Update(BuildParameters.orbit_buildname,
																																// BuildParameters.orbit_EmailTo,
																																// BuildParameters.fileDate,
																																// BuildParameters.orbit_platform);																																
			// clear superfiles so that sub files can be attached to another superkey
			// clearSuper_AutoKey_payload		:= CustomerTest_Common.SuperFiles.Clear(Files.FILE_AUTOKEY_PAYLOAD_SF);
			// clearSuperSteps := SEQUENTIAL(clearSuper_AutoKey_payload);
			// ??? ------------------------   Do we have these? -------------------------------------------------------

				//FINAL STEPS
				SampleRecs := choosen(sort(_files.File_Email_Base_DS,record),1000);
				built := sequential(
							build_email_base
							// ,build_email_base_fcra
							,Build_all_keys
							// ,zDoPopulationStats
							// ,zDoPopulationVendorStats
							,output(SampleRecs)
							)
							: SUCCESS (Send_Build_Email_Notice(fileVersion).Build_Success)
							, FAILURE (Send_Build_Email_Notice(fileVersion).Build_Failure)
							;

//WHAT ABOUT THESE????
							// idopsUpdate,
							// orbitUpdate

				RETURN built;
		
END;