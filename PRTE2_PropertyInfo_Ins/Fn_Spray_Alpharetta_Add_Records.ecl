// PRTE2_PropertyInfo_Ins.Fn_Spray_Alpharetta_Add_Records

IMPORT PRTE2_PropertyInfo_Ins, ut, RoxieKeyBuild;
IMPORT PRTE2_Common as Common;

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
																								ThorLib.Cluster(),									// destination THOR cluster
																								Files.Alpha_Spray_Name,
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
			speadsheetIncoming := Files.Alpha_Spray_DS;
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
		all clean address fields initialized from property_street_address, p_city_name, st, zip, zip4
		latitude 					:=	cleanAddress.geo_lat;
		longitude 				:=	cleanAddress.geo_long;
		fares_unformatted_apn - fake value generated from portions of strings: rid[1..3] + cleanaddress(cart + lot + fips_county + geo_long[3..])
		apn_number := if blank incoming, leave it blank, else replace with same fake value above in fares_unformatted_apn
		assessment_document_number := if blank, leave blank, else fake from cleanaddress(cart + lot + fips_county + geo_blk)
		deed_document_number := if blank, leave blank, else fake from cleanaddress(lot+cart+fips_county+geo_blk)
		for all value fields, if blank, make src blank; if not blank, make src proper value to match. ('0' considered blank)
	**************************************************************************************************** */
			dsNew				:= Files.PropInfo_New_Sub_DS;
			
			maxBaseKey := MAX(dsExisting, (INTEGER)Property_Rid);
			//---------------------------------------------------------------------
			Pick1(STRING s1,STRING s2) := IF(s1='',s2,s1);
			appendIFDot2(STRING s1,STRING s2) := IF(TRIM(s1)<>'' AND TRIM(S2)<>'', TRIM(s1)+'.'+TRIM(s2),Pick1(s1,s2));
			appendIFDot4(STRING s1,STRING s2,STRING s3,STRING s4) := appendIFDot2(appendIFDot2(s1,s2),appendIFDot2(s3,s4));

			GETSRC(STRING S1) := IF(S1='D', 'FARES', 'OKCTY');
			isBlank(STRING Val) := TRIM(Val)='' OR TRIM(Val)='0';
			checkFixSrc(STRING Value, STRING VSrc) := IF(isBlank(Value), '', GETSRC(VSrc));
			checkFixSrcPct(udecimal5_2 Value, STRING VSrc) := IF(Value=0, '', GETSRC(VSrc));
			//---------------------------------------------------------------------
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
				// The following all have src fields to fill too.
				SELF.apn_number := IF(L.apn_number<>'',apnTmp,'');	// only replace if there is already a value.
				docTmp := TRIM(cleanAddress.cart)+TRIM(cleanAddress.lot)+TRIM(cleanAddress.fips_county)+TRIM(cleanAddress.geo_blk);
				SELF.assessment_document_number := IF(L.assessment_document_number<>'',docTmp,'');	// only replace if there is already a value.
				ddocTmp := TRIM(cleanAddress.lot)+TRIM(cleanAddress.cart)+TRIM(cleanAddress.fips_county)+TRIM(cleanAddress.geo_blk);
				SELF.deed_document_number := IF(L.deed_document_number<>'',ddocTmp,'');	// only replace if there is already a value.
				SELF.latitude 					:=	cleanAddress.geo_lat;
				SELF.longitude 				:=	cleanAddress.geo_long;
				// For the following if the add file has a value in the field, then populate the src related to it, else blank
				
				SELF.src_percent_improved := checkFixSrcPct(L.percent_improved,L.vendor_source);
				SELF.src_building_square_footage := checkFixSrc(L.building_square_footage,L.vendor_source);
				SELF.src_air_conditioning_type := checkFixSrc(L.air_conditioning_type,L.vendor_source);
				SELF.src_basement_finish := checkFixSrc(L.basement_finish,L.vendor_source);
				SELF.src_construction_type := checkFixSrc(L.construction_type,L.vendor_source);
				SELF.src_exterior_wall := checkFixSrc(L.exterior_wall,L.vendor_source);
				SELF.src_fireplace_ind := checkFixSrc(L.fireplace_ind,L.vendor_source);
				SELF.src_fireplace_type := checkFixSrc(L.fireplace_type,L.vendor_source);
				SELF.src_flood_zone_panel := checkFixSrc(L.flood_zone_panel,L.vendor_source);
				SELF.src_garage := checkFixSrc(L.garage,L.vendor_source);
				SELF.src_first_floor_square_footage := checkFixSrc(L.first_floor_square_footage,L.vendor_source);
				SELF.src_heating := checkFixSrc(L.heating,L.vendor_source);
				SELF.src_living_area_square_footage := checkFixSrc(L.living_area_square_footage,L.vendor_source);
				SELF.src_no_of_baths := checkFixSrc(L.no_of_baths,L.vendor_source);
				SELF.src_no_of_bedrooms := checkFixSrc(L.no_of_bedrooms,L.vendor_source);
				SELF.src_no_of_fireplaces := checkFixSrc(L.no_of_fireplaces,L.vendor_source);
				SELF.src_no_of_full_baths := checkFixSrc(L.no_of_full_baths,L.vendor_source);
				SELF.src_no_of_half_baths := checkFixSrc(L.no_of_half_baths,L.vendor_source);
				SELF.src_no_of_stories := checkFixSrc(L.no_of_stories,L.vendor_source);
				SELF.src_parking_type := checkFixSrc(L.parking_type,L.vendor_source);
				SELF.src_pool_indicator := checkFixSrc(L.pool_indicator,L.vendor_source);
				SELF.src_pool_type := checkFixSrc(L.pool_type,L.vendor_source);
				SELF.src_roof_cover := checkFixSrc(L.roof_cover,L.vendor_source);
				SELF.src_roof_type := checkFixSrc(L.roof_type,L.vendor_source);
				SELF.src_year_built := checkFixSrc(L.year_built,L.vendor_source);
				SELF.src_foundation := checkFixSrc(L.foundation,L.vendor_source);
				SELF.src_basement_square_footage := checkFixSrc(L.basement_square_footage,L.vendor_source);
				SELF.src_effective_year_built := checkFixSrc(L.effective_year_built,L.vendor_source);
				SELF.src_garage_square_footage := checkFixSrc(L.garage_square_footage,L.vendor_source);
				SELF.src_stories_type := checkFixSrc(L.stories_type,L.vendor_source);
				SELF.src_apn_number := checkFixSrc(L.apn_number,L.vendor_source);
				SELF.src_census_tract := checkFixSrc(L.census_tract,L.vendor_source);
				SELF.src_range := checkFixSrc(L.range,L.vendor_source);
				SELF.src_zoning := checkFixSrc(L.zoning,L.vendor_source);
				SELF.src_block_number := checkFixSrc(L.block_number,L.vendor_source);
				SELF.src_county_name := checkFixSrc(L.county_name,L.vendor_source);
				SELF.src_fips_code := checkFixSrc(L.fips_code,L.vendor_source);
				SELF.src_subdivision := checkFixSrc(L.subdivision,L.vendor_source);
				SELF.src_municipality := checkFixSrc(L.municipality,L.vendor_source);
				SELF.src_township := checkFixSrc(L.township,L.vendor_source);
				SELF.src_homestead_exemption_ind := checkFixSrc(L.homestead_exemption_ind,L.vendor_source);
				SELF.src_land_use_code := checkFixSrc(L.land_use_code,L.vendor_source);
				SELF.src_latitude := checkFixSrc(L.latitude,L.vendor_source);
				SELF.src_longitude := checkFixSrc(L.longitude,L.vendor_source);
				SELF.src_location_influence_code := checkFixSrc(L.location_influence_code,L.vendor_source);
				SELF.src_acres := checkFixSrc(L.acres,L.vendor_source);
				SELF.src_lot_depth_footage := checkFixSrc(L.lot_depth_footage,L.vendor_source);
				SELF.src_lot_front_footage := checkFixSrc(L.lot_front_footage,L.vendor_source);
				SELF.src_lot_number := checkFixSrc(L.lot_number,L.vendor_source);
				SELF.src_lot_size := checkFixSrc(L.lot_size,L.vendor_source);
				SELF.src_property_type_code := checkFixSrc(L.property_type_code,L.vendor_source);
				SELF.src_structure_quality := checkFixSrc(L.structure_quality,L.vendor_source);
				SELF.src_water := checkFixSrc(L.water,L.vendor_source);
				SELF.src_sewer := checkFixSrc(L.sewer,L.vendor_source);
				SELF.src_assessed_land_value := checkFixSrc(L.assessed_land_value,L.vendor_source);
				SELF.src_assessed_year := checkFixSrc(L.assessed_year,L.vendor_source);
				SELF.src_tax_amount := checkFixSrc(L.tax_amount,L.vendor_source);
				SELF.src_tax_year := checkFixSrc(L.tax_year,L.vendor_source);
				SELF.src_market_land_value := checkFixSrc(L.market_land_value,L.vendor_source);
				SELF.src_improvement_value := checkFixSrc(L.improvement_value,L.vendor_source);
				SELF.src_total_assessed_value := checkFixSrc(L.total_assessed_value,L.vendor_source);
				SELF.src_total_calculated_value := checkFixSrc(L.total_calculated_value,L.vendor_source);
				SELF.src_total_land_value := checkFixSrc(L.total_land_value,L.vendor_source);
				SELF.src_total_market_value := checkFixSrc(L.total_market_value,L.vendor_source);
				SELF.src_floor_type := checkFixSrc(L.floor_type,L.vendor_source);
				SELF.src_frame_type := checkFixSrc(L.frame_type,L.vendor_source);
				SELF.src_fuel_type := checkFixSrc(L.fuel_type,L.vendor_source);
				SELF.src_no_of_bath_fixtures := checkFixSrc(L.no_of_bath_fixtures,L.vendor_source);
				SELF.src_no_of_rooms := checkFixSrc(L.no_of_rooms,L.vendor_source);
				SELF.src_no_of_units := checkFixSrc(L.no_of_units,L.vendor_source);
				SELF.src_style_type := checkFixSrc(L.style_type,L.vendor_source);
				SELF.src_assessment_document_number := checkFixSrc(L.assessment_document_number,L.vendor_source);
				SELF.src_assessment_recording_date := checkFixSrc(L.assessment_recording_date,L.vendor_source);
				SELF.src_deed_document_number := checkFixSrc(L.deed_document_number,L.vendor_source);
				SELF.src_deed_recording_date := checkFixSrc(L.deed_recording_date,L.vendor_source);
				SELF.src_full_part_sale := checkFixSrc(L.full_part_sale,L.vendor_source);
				SELF.src_sale_amount := checkFixSrc(L.sale_amount,L.vendor_source);
				SELF.src_sale_date := checkFixSrc(L.sale_date,L.vendor_source);
				SELF.src_sale_type_code := checkFixSrc(L.sale_type_code,L.vendor_source);
				SELF.src_mortgage_company_name := checkFixSrc(L.mortgage_company_name,L.vendor_source);
				SELF.src_loan_amount := checkFixSrc(L.loan_amount,L.vendor_source);
				SELF.src_second_loan_amount := checkFixSrc(L.second_loan_amount,L.vendor_source);
				SELF.src_loan_type_code := checkFixSrc(L.loan_type_code,L.vendor_source);
				SELF.src_interest_rate_type_code := checkFixSrc(L.interest_rate_type_code,L.vendor_source);
				
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