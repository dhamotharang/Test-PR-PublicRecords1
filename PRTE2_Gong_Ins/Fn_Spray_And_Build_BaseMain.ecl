/* *****************************************************************************************
PRTE2_Gong_Ins.Fn_Spray_And_Build_BaseMain
1. Spray the file
2. Create SF with Alpha CSV base file
3. Call proc to do any transforms and create final Boca file.
***************************************************************************************** */

IMPORT ut, RoxieKeyBuild, Address, PRTE2, PRTE2_Common,PromoteSupers;

EXPORT Fn_Spray_And_Build_BaseMain(STRING CSVName, STRING fileVersion, STRING overridePath='') := FUNCTION
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
			
			// appendIf5 := PRTE2_Common.Functions.appendIf5;
			// *********************************************************************************************************************
			// transform data of CSV usinf clean address (simulate action of RMPO on request sent).
			// *********************************************************************************************************************
			Layouts.Alpha_CSV_Layout Clean_Address_Transform(new_CSV_Base L) := TRANSFORM
				// UNKNOWN:  ARE THERE ANY FIELDS TO INITIALIZE IN GONG?
				SELF := L;
				SELF := [];
			END;

			newBase := PROJECT(new_CSV_Base, Clean_Address_Transform(LEFT) );

			PromoteSupers.Mac_SF_BuildProcess(newBase, Files.Gong_Base_CSV, buildBase);																					 
			BuildBase2 := PRTE2_Gong_Ins.Proc_Build_Compatible_Base;		// CRITICAL: This reads the base created above.
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.FILE_SPRAY);
			// --------------------------------------------------
			AlphaNewBase := Files.Gong_Base_CSV_DS;
			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildBase, BuildBase2, 
															delSprayedFile, output(AlphaNewBase)
															);

			RETURN sequentialSteps;

END;