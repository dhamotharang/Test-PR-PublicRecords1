/* ************************************************************************************************************************
**********************************************************************************************
***** MLS CONVERSION NOTES:
TODO - We don't want to fill any SRC fields but might want to empty them if value is blank???
WARNING --- WARNING --- WARNING --- WARNING --- WARNING --- WARNING --- WARNING --- WARNING --- 
WARNING!!  We do not know if this "add" will be needed and IT MUST BE TESTED IF WE DO USE IT THE FIRST TIME WE TRY IT.
**********************************************************************************************
OLDER NOTES:
 PRTE2_PropertyInfo_Ins_MLS.Fn_Spray_Alpharetta_Add_Records
TEMP_ADDRESS_WORKAROUND TILL DATA3 IS DONE HERE
************************************************************************************************************************ */

IMPORT PRTE2_PropertyInfo_Ins_MLS, ut;
IMPORT PRTE2_Common;

//---------------------------------------------------------------------
appendIFDot4 := PRTE2_Common.Functions.appendIFDot4;
appendIfCSZ := PRTE2_Common.Functions.appendIfCSZ;
//---------------------------------------------------------------------

EXPORT Fn_Spray_Alpharetta_Add_Records(STRING CSVName, STRING fileVersion, BOOLEAN isProdBase ) := FUNCTION
			// Everything in the fn_Spray process should happen in the CSV layout (AlphaPropertyCSVRec_MLS)

			// --------------------------------------------------
			SourcePathForPIICSV := Constants.SourcePathForPIICSV;
			
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


			speadsheetIncoming0 := Files.Alpha_Spray_DS;
			// NOTE: 
			// ***************>> Nancy will edit these fields: property_street_address, v_city_name, st, zip
			// so pre-fill property_city_state_zip because spreadsheet_clean requires property_city_state_zip for cleaning		
			speadsheetIncoming	:= PROJECT(speadsheetIncoming0, TRANSFORM({Layouts.AlphaPropertyCSVRec_MLS},
												new_CSZ := appendIfCSZ(LEFT.v_city_name,LEFT.st,LEFT.zip);
												SELF.property_city_state_zip := new_CSZ;
												// APNs are set in Transforms.spreadsheet_clean
												// Address cleaning and filling happens in the Transforms.spreadsheet_clean
												SELF := LEFT;
												));
			speadsheetCleaned := PROJECT(speadsheetIncoming, Transforms.spreadsheet_clean(LEFT));

			buildNewFile := PRTE2_Common.Promote_Supers.mac_SFBuildProcess(speadsheetCleaned, Files.PropInfo_New_fileName);			
			
			dsExisting := IF(isProdBase, Files.PII_ALPHA_BASE_SF_DS_Prod, Files.PII_ALPHA_BASE_SF_DS); 

			/* ***************************************************************************************************	
			 now use existing and processing to ensure that all new records have initialized fields and clean addresses
				***************************************************************************************************	
				The "add" process does extra initializing as follows:
				Property_Rid - next number after MAX()		
				assessment_document_number := if blank, leave blank, else fake from clean_address(cart + lot + fips_county + geo_blk)
				deed_document_number := if blank, leave blank, else fake from clean_address(lot+cart+fips_county+geo_blk)
				IT NO LONGER CHECKS SRC AND DATE FIELDS FOR ATTRIBUTES - THOSE MUST BE EDITED CORRECTLY
			**************************************************************************************************** */
			dsNew				:= Files.PropInfo_New_File_DS;
			
			maxBaseKey := MAX(dsExisting, (INTEGER)Property_Rid);

			Layouts.AlphaPropertyCSVRec_MLS xAddDefaults(dsNew L, INTEGER cnt) := TRANSFORM
				ridToUse	:=  maxBaseKey + cnt;
				SELF.Property_Rid	:= ridToUse;
				// NOTE: Address cleaning and filling happens in the Transforms.spreadsheet_clean, but need to put fake values into some other fields
				clean_address := PRTE2_Common.Clean_Address.cleanAddr1Addr2(L.property_street_address, L.property_city_state_zip);
				docTmp := TRIM(clean_address.cart)+TRIM(clean_address.lot)+TRIM(clean_address.fips_county)+TRIM(clean_address.geo_blk);
				SELF.assessment_document_number := IF(L.assessment_document_number<>'',docTmp,'');	// only replace if there is already a value.
				ddocTmp := TRIM(clean_address.lot)+TRIM(clean_address.cart)+TRIM(clean_address.fips_county)+TRIM(clean_address.geo_blk);
				SELF.deed_document_number := IF(L.deed_document_number<>'',ddocTmp,'');	// only replace if there is already a value.
				//**********************************************************************************
				// Src fields are no longer checked - spreadsheet must have them populated properly							
				//**********************************************************************************
				SELF := L;
			END;

			dsNewPreparedData := PROJECT(dsNew, xAddDefaults(LEFT, COUNTER));
			
			// combine data into a single data set	
			dsAll := dsExisting + dsNewPreparedData;
			//****************************************************************************************************	

			speadsheetCleaned2 := PROJECT(dsAll, Transforms.spreadsheet_clean(LEFT));
			
			buildPIIBase := PRTE2_Common.Promote_Supers.mac_SFBuildProcess(speadsheetCleaned2, Files.PII_ALPHA_BASE_SF);
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.Alpha_Spray_Name);

			// --------------------------------------------------
			PII_Scrambled := Files.PII_ALPHA_BASE_SF_DS;
			ShowResults := CHOOSEN(PII_Scrambled, 200);	
			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (	sprayFile,
															buildNewFile,
															buildPIIBase,
															delSprayedFile,
															OUTPUT(ShowResults)
															);

			RETURN sequentialSteps;

END;