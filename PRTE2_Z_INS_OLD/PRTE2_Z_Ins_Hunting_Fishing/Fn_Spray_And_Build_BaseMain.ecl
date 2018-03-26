// PRTE2_Hunting_Fishing.Fn_Spray_And_Build_BaseMain

IMPORT ut, RoxieKeyBuild;
IMPORT PRTE2_Common as Common;

/*
See code in these which we may need to emulate somewhat since we will not do key-by-key builds.
	eMerges.file_hunters_keybuild
	eMerges.file_huntfish_searchautokey
	eMerges.HuntFish_Autokey_Constants
	eMerges.HuntFish_SearchFile
	eMerges.Key_HuntFish_Did
	eMerges.key_huntfish_payload
	eMerges.Key_HuntFish_Rid
	eMerges.layout_hunt_ccw_v2
	eMerges.layout_hunters_out
	eMerges.Proc_Build_HF_Keys

*/

EXPORT Fn_Spray_And_Build_BaseMain(STRING CSVName, STRING fileVersion, STRING overridePath='') := FUNCTION

			// --------------------------------------------------
			SourcePathForCSV := IF(overridePath<>'',overridePath,Constants.SourcePathForCSV);
			
			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																								SourcePathForCSV+CSVName, 			// path to file on landing zone
																								8192,																// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Cluster(),									// destination THOR cluster
																								Files.FILE_SPRAY,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								FALSE												  			// do not compress
																								);																					 


			// --------------------------------------------------
			// If you need to TRANSFORM Spreadsheet ... see how this worked in PRTE2_PropertyInfo.Fn_Spray_Scrambled_Spreadsheet
			// speadsheetIncoming := Files.SPRAYED_DS;
			// newBase := PROJECT( speadsheetIncoming ,Transforms.Spreadsheet_Expand(LEFT));
			
			// otherwise it is simple
			newBase := Files.SPRAYED_DS;

			// This macro is what builds the super files with generations: QA, Father, Grandfater
			RoxieKeyBuild.Mac_SF_BuildProcess_V2(newBase,
																					 Files.BASE_PREFIX_NAME, 
																					 Files.ALPHA_BASE_NAME,
																					 fileVersion, buildBase, 3,
																					 false,true);
																						 
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.FILE_SPRAY);

			// --------------------------------------------------
			finalNewBase := Files.HuntFish_Alpha_SF_DS;
			ShowResults := CHOOSEN(finalNewBase, 200);	
			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildBase,
															delSprayedFile,
															OUTPUT(ShowResults)
															);

			RETURN sequentialSteps;

END;