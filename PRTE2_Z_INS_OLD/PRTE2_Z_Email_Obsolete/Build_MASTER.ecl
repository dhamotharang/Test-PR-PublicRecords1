
//TODO -- Still WIP until I can test this - this and everything below this
// See _BWR_FN_Build_Email_ORIG to see a lot of commented steps that may/may not be needed.

EXPORT Build_MASTER(String fileVersion='', STRING csvFilePathToUse, BOOLEAN bDoingFullRebuild) := FUNCTION
#WORKUNIT('name','Build PRCT Email Data (PRTE2)' + fileVersion);
			import ut;

			SprayModule := Fn_Spray(csvFilePathToUse, fileVersion);
			// ==================================================================================
			// ----- ONLY ONE OF THESE WILL HAPPEN ----------------------------------------------
			// ==================================================================================
			rebuildMain					:= SprayModule.Spray_and_BuildMain();
			appendNewToMain			:= SprayModule.Spray_and_AppendNew();			
			// base files -- full rebuild or add new to existing base
			buildBaseMain 				:= IF(bDoingFullRebuild, rebuildMain, appendNewToMain); 
			// ==================================================================================

			// Build keys from the base file finished above.
			Build_all_keys := Build_keys(fileVersion);

			//FINAL STEPS
			SampleRecs := CHOOSEN(sort(_files.File_Email_Base_DS,record),1000);
			
			// ==================================================================================
			built := SEQUENTIAL(							
						buildBaseMain
						,Build_all_keys
						,output(SampleRecs)
						)
						: SUCCESS (Send_Build_Email_Notice(fileVersion).Build_Success)
						, FAILURE (Send_Build_Email_Notice(fileVersion).Build_Failure)
						;

				RETURN built;
		
END;