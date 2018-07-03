/* ********* NOT ACTIVE YET ************* DO WE NEED THIS AT ALL IN BOCA? ******************
PRTE2_Gong_Ins.Fn_Spray_And_Add_New

********** WARNING ********* WARNING ************* WARNING *********** WARNING *********
I put an add_new in here but we have no idea what field initialization may be needed.
We created this initial data by working with Linda to gather production records and replace PII
SO -- maybe??  in the future we won't do add_new, but instead will do gather prod and replace PII???
Please consider these to be initial but not ready for use until we determine how to proceed:
PRTE2_Gong_Ins.BWR_Spray_Add_New	AND 	PRTE2_Gong_Ins.Fn_Spray_And_Add_New
********** WARNING ********* WARNING ************* WARNING *********** WARNING *********

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
				// UNKNOWN:  Are there any fields to initialize in GONG???
				SELF := L;
				SELF := [];
			END;

			DS_New_Initialized := PROJECT(new_CSV_Base, Clean_Address_Transform(LEFT) );

			Existing_DS := IF(isProdBase, Files.Gong_Base_CSV_DS_Prod, Files.Gong_Base_CSV_DS); 

			newBase := Existing_DS + DS_New_Initialized;
			
			PromoteSupers.Mac_SF_BuildProcess(newBase, Files.Gong_Base_CSV, buildBase);
			BuildBase2 := PRTE2_Gong_Ins.Proc_Build_Compatible_Base;		// This reads the base created above.
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.FILE_SPRAY);
			// --------------------------------------------------
			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildBase,
															BuildBase2, 
															delSprayedFile,
															);

			RETURN sequentialSteps;

END;