// PRTE2_PropertyInfo.Fn_Spray_Alpharetta_Add_Records

IMPORT PRTE2_PropertyInfo, ut, RoxieKeyBuild;
IMPORT PRTE2_Common as Common;

EXPORT Fn_Spray_Alpharetta_Add_Records(STRING CSVName, STRING fileVersion, BOOLEAN isProdBase ) := FUNCTION
			// Everything in the fn_Spray process should happen in the CSV layout
			AlphaPropertyCSVRec := Layouts.AlphaPropertyCSVRec;

			Pick1(STRING s1,STRING s2) := IF(s1='',s2,s1);
			appendIFDot2(STRING s1,STRING s2) := IF(s1 <> '', s1+'.'+s2,Pick1(s1,s2));
			appendIFDot4(STRING s1,STRING s2,STRING s3,STRING s4) := appendIFDot2(appendIFDot2(s1,s2),appendIFDot2(s3,s4));

			// --------------------------------------------------
			SourcePathForPIICSV := IF(overridePath<>'',overridePath,Constants.SourcePathForPIICSV);
			
			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																								SourcePathForPIICSV+CSVName, 			// path to file on landing zone
																								8192,																// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Cluster(),									// destination THOR cluster
																								Files.SCRAMBLE_SPRAY,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								FALSE												  			// do not compress
																								);																					 


//****************************************************************************************************	
// Save incoming as a THOR file, perform updates and fill in what is needed, then append to existing
//****************************************************************************************************	
			// associate to superfile (and move older files into older generation superfiles)
			// --------------------------------------------------
			// just to be safe, transform and clean the base file.
			speadsheetIncoming := Files.SCRAMBLE_SPRAY_DS;
			speadsheetCleaned := PROJECT(speadsheetIncoming, Transforms.spreadsheet_clean(LEFT));
			
			RoxieKeyBuild.Mac_SF_BuildProcess_V2(speadsheetCleaned,
																					 Files.IN_PREFIX_NAME, 
																					 Files.NewData_Suffix, 
																					 fileVersion, buildNewFile, 3);
			
			dsExisting := IF(isProdBase, Files.PII_ALPHA_BASE_SF_DS_Prod, Files.PII_ALPHA_BASE_SF_DS); 

	//****************************************************************************************************	
	// now use existing and processing to ensure that all new records have initialized fields and clean addresses
	//****************************************************************************************************	
			dsNew				:= Files.PropInfo_New_Sub_DS;
			
			maxBaseKey := MAX(dsExisting, (INTEGER)Property_Rid);
			dsExisting xAddDefaults(dsNew L, INTEGER cnt) := TRANSFORM
				ridToUse	:=  maxBaseKey + cnt;
				ridString := (STRING)ridToUse;
				SELF.Property_Rid	:= ridToUse;
				cleanAddress	:= Common.Clean_Address.FromLine(L.property_street_address, L.p_city_name, L.st, L.zip, L.zip4);
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
				apnTmp := appendIFDot4(ridString[1..3],cleanAddress.cart,cleanAddress.lot,cleanAddress.fips_county)+cleanAddress.geo_long[3..];
				SELF.fares_unformatted_apn := apnTmp;										// not a characteristic with a source
				SELF.apn_number := IF(L.src_apn_number<>'',apnTmp,'');	// only replace if there is already a value.
				docTmp := cleanAddress.cart+cleanAddress.lot+cleanAddress.fips_county+cleanAddress.geo_blk;
				SELF.assessment_document_number := IF(L.assessment_document_number<>'',docTmp,'');	// only replace if there is already a value.
				ddocTmp := cleanAddress.lot+cleanAddress.cart+cleanAddress.fips_county+cleanAddress.geo_blk;
				SELF.deed_document_number := IF(L.deed_document_number<>'',ddocTmp,'');	// only replace if there is already a value.
				SELF := L;
			END;
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
																					 Files.SCRAMBLE_NAME,
																					 fileVersion, buildPIIBase, 3,
																					 false,true);
																						 
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.SCRAMBLE_SPRAY);

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