/* *****************************************************************************************
 PRTE2_PropertyInfo_Ins.Fn_Spray_Alpharetta_Add_Records
TEMP_ADDRESS_WORKAROUND TILL DATA3 IS DONE HERE
***************************************************************************************** */

IMPORT PRTE2_PropertyInfo_Ins, ut, RoxieKeyBuild;
IMPORT PRTE2_Common;

//---------------------------------------------------------------------
appendIFDot4 := PRTE2_Common.Functions.appendIFDot4;
appendIfCSZ := PRTE2_Common.Functions.appendIfCSZ;
//---------------------------------------------------------------------

EXPORT Fn_Spray_Alpharetta_Add_Records(STRING CSVName, STRING fileVersion, BOOLEAN isProdBase ) := FUNCTION
			// Everything in the fn_Spray process should happen in the CSV layout (AlphaPropertyCSVRec)

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


//****************************************************************************************************	
// Save incoming as a THOR file, perform updates and fill in what is needed, then append to existing
//****************************************************************************************************	
			// associate to superfile (and move older files into older generation superfiles)
			// --------------------------------------------------
			// just to be safe, transform and clean the base file. use Transforms.spreadsheet_clean
			speadsheetIncoming0 := Files.Alpha_Spray_DS;

			// columns will be changing but... it is Easier for Nancy/Anna to use column S,T,U instead of H - 
			// so pre-fill property_city_state_zip because spreadsheet_clean requires property_city_state_zip for cleaning		
			speadsheetIncoming := PROJECT(speadsheetIncoming0, TRANSFORM({speadsheetIncoming0},
																			SELF.property_city_state_zip := appendIfCSZ(LEFT.v_city_name,LEFT.st,LEFT.zip);
																			SELF := LEFT;
																			));
																			
			speadsheetCleaned := PROJECT(speadsheetIncoming, Transforms.spreadsheet_clean(LEFT));
			
			RoxieKeyBuild.Mac_SF_BuildProcess_V2(speadsheetCleaned,
																					 Files.IN_PREFIX_NAME, 
																					 Files.NewData_Suffix, 
																					 fileVersion, buildNewFile, 3);
			
			dsExisting := IF(isProdBase, Files.PII_ALPHA_BASE_SF_DS_Prod, Files.PII_ALPHA_BASE_SF_DS); 

	/* ***************************************************************************************************	
	 now use existing and processing to ensure that all new records have initialized fields and clean addresses
		The "add" process does extra initializing as follows:
		Property_Rid - next number after MAX()
	
		Until we can alter the base file to provide editing fields all clean address fields are being 
				initialized from property_street_address, v_city_name, st, zip, zip4

		latitude 				:=	cleanAddress.geo_lat;
		longitude 				:=	cleanAddress.geo_long;
		fares_unformatted_apn - fake value generated from portions of strings: rid[1..3] + cleanaddress(cart + lot + fips_county + geo_long[3..])
		apn_number := if blank incoming, leave it blank, else replace with same fake value above in fares_unformatted_apn
		assessment_document_number := if blank, leave blank, else fake from cleanaddress(cart + lot + fips_county + geo_blk)
		deed_document_number := if blank, leave blank, else fake from cleanaddress(lot+cart+fips_county+geo_blk)
		for all value fields, if blank, make src blank; if not blank, make src proper value to match. ('0' considered blank)
	**************************************************************************************************** */
			dsNew				:= Files.PropInfo_New_Sub_DS;
			
			maxBaseKey := MAX(dsExisting, (INTEGER)Property_Rid);

			dsExisting xAddDefaults(dsNew L, INTEGER cnt) := TRANSFORM
				ridToUse	:=  maxBaseKey + cnt;
				ridString := (STRING)ridToUse;
				SELF.Property_Rid	:= ridToUse;
				// NOTE: 
				// Nancy will edit these fields: property_street_address, property_city_state_zip
				cleanaddress := PRTE2_Common.Clean_Address.cleanAddr1Addr2(l.property_street_address, l.property_city_state_zip);
				// ORIGINAL CODE HERE --- I altered it to make the add process use the same two fields.
				// 		Above the project to Transforms.spreadsheet_clean(LEFT) - used those to set v_city_name, st, zip, and zip4 so we can use them here.
				//    **** IF we ever stop doing that spreadsheet_clean - we need to alter this next line to use Nancy's fields.
				// cleanAddress	:= PRTE2_Common.Clean_Address.FromLine(L.property_street_address, L.v_city_name, L.st, L.zip, L.zip4);
				SELF.prim_range				:=	cleanAddress.prim_range;
				SELF.predir						:=	cleanAddress.predir;
				SELF.prim_name				:=	cleanAddress.prim_name;
				SELF.addr_suffix			:=	cleanAddress.addr_suffix;
				SELF.postdir					:=	cleanAddress.postdir;
				SELF.unit_desig				:=	cleanAddress.unit_desig;
				SELF.sec_range				:=	cleanAddress.sec_range;
				SELF.p_city_name			:=	cleanAddress.v_city_name;
				SELF.v_city_name			:=	cleanAddress.v_city_name;
				SELF.st								:=	cleanAddress.st;
				SELF.zip							:=	cleanAddress.zip;
				SELF.zip4							:=	cleanAddress.zip4;
				SELF.cart							:=	cleanAddress.cart;
				SELF.cr_sort_sz				:=	cleanAddress.cr_sort_sz;
				SELF.lot							:=	cleanAddress.lot;
				SELF.lot_order				:=	cleanAddress.lot_order;
				SELF.dbpc							:=	cleanAddress.dbpc;
				SELF.chk_digit				:=	cleanAddress.chk_digit;
				SELF.rec_type					:=	cleanAddress.rec_type;
				SELF.geo_lat 					:=	cleanAddress.geo_lat;
				SELF.geo_long 				:=	cleanAddress.geo_long;
				SELF.msa							:=	cleanAddress.msa;
				SELF.geo_blk					:=	cleanAddress.geo_blk;
				SELF.geo_match				:=	cleanAddress.geo_match;
				SELF.err_stat					:=	cleanAddress.err_stat;
				
				// next prepare some of the document type fields so they are more unique to the address given.
				apnTmp := appendIFDot4(ridString[1..3],cleanAddress.cart,cleanAddress.lot,cleanAddress.fips_county)+cleanAddress.geo_long[3..];
				SELF.fares_unformatted_apn := apnTmp;										// not a characteristic with a source
				// The following all have src fields to fill too.
				SELF.apn_number := IF(L.apn_number<>'',apnTmp,'');	// only replace if there is already a value.
				docTmp := TRIM(cleanAddress.cart)+TRIM(cleanAddress.lot)+TRIM(cleanAddress.fips_county)+TRIM(cleanAddress.geo_blk);
				SELF.assessment_document_number := IF(L.assessment_document_number<>'',docTmp,'');	// only replace if there is already a value.
				ddocTmp := TRIM(cleanAddress.lot)+TRIM(cleanAddress.cart)+TRIM(cleanAddress.fips_county)+TRIM(cleanAddress.geo_blk);
				SELF.deed_document_number := IF(L.deed_document_number<>'',ddocTmp,'');	// only replace if there is already a value.
				SELF.latitude 					:=	cleanAddress.geo_lat;
				SELF.longitude 				:=	cleanAddress.geo_long;
				// Src fields were populated back in the clean_spreadsheet transform, don't need to re-do them here.
								
				SELF := L;
			END;
// if we can get at any of these from address cleaning we can begin to populate them...
// census_tract   src_census_tract
// zoning	src_zoning
// block_number   src_block_number
// county_name   src_county_name
// fips_code   src_fips_code
// subdivision   src_subdivision
// municipality   src_municipality
// township   src_township
// homestead_exemption_ind   src_homestead_exemption_ind
// land_use_code   src_land_use_code

			
			dsNewPreparedData := PROJECT(dsNew, xAddDefaults(LEFT, COUNTER));
			
			// combine data into a single data set	
			dsAll 			:= dsExisting + dsNewPreparedData;
//****************************************************************************************************	
// END OF APPEND LOGIC
//****************************************************************************************************	
			// ACTIVATE WHEN WE MOVE Layouts to the new version
			// speadsheetCleaned := PROJECT(speadsheetIncoming, Transforms.spreadsheet_clean(LEFT));
			// RoxieKeyBuild.Mac_SF_BuildProcess_V2(speadsheetCleaned,
			RoxieKeyBuild.Mac_SF_BuildProcess_V2(dsAll,
																					 Files.BASE_PREFIX_NAME, 
																					 Files.ALPHA_Base_Name,
																					 fileVersion, buildPIIBase, 3,
																					 false,true);
																						 
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.Alpha_Spray_Name);

			// --------------------------------------------------
			PII_Scrambled := Files.PII_ALPHA_BASE_SF_DS;
			ShowResults := CHOOSEN(PII_Scrambled, 200);	
			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildNewFile,
															buildPIIBase,
															delSprayedFile,
															OUTPUT(ShowResults)
															);

			RETURN sequentialSteps;

END;