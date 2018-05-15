/* *****************************************************************************************
PRTE2_Gong_Ins.Fn_Spray_And_Add_New
***************************************************************************************** */

IMPORT PRTE2_Gong_Ins, ut, RoxieKeyBuild, Address, PRTE2, PRTE2_Common, PromoteSupers;

EXPORT Fn_Spray_And_Add_New(STRING CSVName, STRING fileVersion, BOOLEAN isProdBase=TRUE, STRING overridePath='') := FUNCTION

			Files := PRTE2_Gong_Ins.Files;
			Constants := PRTE2_Gong_Ins.Constants;
			
			SourcePathForCSV := IF(overridePath<>'',overridePath,Constants.SourcePathForCSV);
			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,						// file LZ
																								SourcePathForCSV+CSVName, 					// path to file on landing zone
																								8192,																// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Group(),									// destination THOR cluster
																								Files.FILE_SPRAY,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								PRTE2_Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								FALSE												  			// do not compress
																								);																					 

			// PRTE2.CleanFields(Files.SPRAYED_DS, new_CSV_Base);
			new_CSV_Base := Files.SPRAYED_DS;
			
			// *********************************************************************************************************************
			// transform data of CSV usinf clean address (simulate action of RMPO on request sent).
			// *********************************************************************************************************************
			Layouts.Alpha_CSV_Layout Clean_Address_Transform(new_CSV_Base L) := TRANSFORM
				appendIf4 := PRTE2_Common.Functions.appendIf4;
			
				// UNKNOWN:  What fields to initialize in GONG???
				SELF := L;
				SELF := [];
			END;

			DS_New_Initialized := PROJECT(new_CSV_Base, Clean_Address_Transform(LEFT) );

			Existing_DS := IF(isProdBase, Files.Gong_Base_SF_DS_Prod, Files.Gong_Base_SF_DS); 

			newBase := Existing_DS + DS_New_Initialized;
			
			//???? WHICH SUPER FILE TO USE?
			PromoteSupers.Mac_SF_BuildProcess(newBase, Files.Gong_Base_SF, buildBase);

			// RoxieKeyBuild.Mac_SF_BuildProcess_V2(newBase,
																					 // Files.BASE_PREFIX_NAME, 
																					 // Files.AllData_Suffix,
																					 // fileVersion, buildBase, 3,
																					 // false,true);
																						 
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.FILE_SPRAY);
			// --------------------------------------------------
			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildBase,
															delSprayedFile,
															);

			RETURN sequentialSteps;

END;