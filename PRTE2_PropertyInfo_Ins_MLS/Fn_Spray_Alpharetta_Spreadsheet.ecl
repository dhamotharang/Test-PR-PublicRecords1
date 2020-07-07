/* ************************************************************************************************************************
**********************************************************************************************
***** MLS CONVERSION NOTES:
**********************************************************************************************
OLDER NOTES:
 PRTE2_PropertyInfo_Ins_MLS.Fn_Spray_Alpharetta_Spreadsheet
TEMP_ADDRESS_WORKAROUND TILL DATA3 IS DONE HERE
************************************************************************************************************************ */

IMPORT PRTE2_PropertyInfo_Ins_MLS, ut;
IMPORT PRTE2_Common;

EXPORT Fn_Spray_Alpharetta_Spreadsheet(STRING CSVName, STRING overridePath='') := FUNCTION

			//------------------------------------------------
			// Everything in the fn_Spray process should happen in the full CSV layout (AlphaPropertyCSVRec_MLS)
			//---------------------------------------------------------------------
			appendIfCSZ := PRTE2_Common.Functions.appendIfCSZ;

			// --------------------------------------------------
			SourcePathForPIICSV := IF(overridePath<>'',overridePath,Constants.SourcePathForPIICSV);
			
			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
															SourcePathForPIICSV+CSVName, 			// path to file on landing zone
															8192,																// maximum record size
															Constants.CSVSprayFieldSeparator,		// field separator(s)
															Constants.CSVSprayLineSeparator,		// line separator(s)
															Constants.CSVSprayQuote,						// text quote character
															ThorLib.GROUP(),									// destination THOR cluster
															Files.Alpha_Spray_Name,
															-1,												  				// -1 means no timeout
																,													  			// use default ESP server IP port
																,														 	 		// use default maximum connections
															TRUE,												 		 		// allow overwrite
															PRTE2_Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
															FALSE												  			// do not compress
															);																					 


			// --------------------------------------------------
			// just to be safe, transform and clean the base file.
			speadsheetIncoming0 	:= Files.Alpha_Spray_DS;
			// OUTPUT(Files.Alpha_Spray_DS);
			// NOTE: 
			// ***************>> Nancy will edit these fields: property_street_address, v_city_name, st, zip
			// so pre-fill property_city_state_zip because spreadsheet_clean requires accurate property_city_state_zip for cleaning
			// NOTE: IF data team can manually alter an address (EG: cloning records to create new) then we must re-calc the APN values
			speadsheetIncoming	:= PROJECT(speadsheetIncoming0, 
													TRANSFORM({Layouts.AlphaPropertyCSVRec_MLS},
															SELF.property_city_state_zip := appendIfCSZ(LEFT.v_city_name,LEFT.st,LEFT.zip);
															// APNs are set in Transforms.spreadsheet_clean
															SELF := LEFT;
															));
			// OUTPUT('NEXT ONE');
			// OUTPUT(speadsheetIncoming);
			speadsheetCleaned := PROJECT(speadsheetIncoming, Transforms.spreadsheet_clean(LEFT));

			buildPIIBase := PRTE2_Common.Promote_Supers.mac_SFBuildProcess(speadsheetCleaned, Files.PII_ALPHA_BASE_SF);
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.Alpha_Spray_Name);

			// --------------------------------------------------
			PII_BaseBuilt := Files.PII_ALPHA_BASE_SF_DS;
			ShowResults := CHOOSEN(PII_BaseBuilt, 200);	
			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (	sprayFile,
															buildPIIBase,
															delSprayedFile,
															OUTPUT(ShowResults),
															);

			RETURN sequentialSteps;

END;