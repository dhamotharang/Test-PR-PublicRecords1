IMPORT AutoStandardI, BIPV2, BIPV2_Best, Business_Risk_BIP, Corp2, Doxie, EBR, EBR_Services, 
       LN_propertyV2, LN_PropertyV2_Services, MDR, Risk_Indicators, SALT28, UT;

EXPORT getAddrAndPropertyData(DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION
	
	// ---------------[ Local attributes ]----------------
	
	// Scalar values:
	FETCH_LEVEL   := Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel);
	SELEID_FILTER := FETCH_LEVEL in [BIPV2.IDconstants.Fetch_Level_UltID, BIPV2.IDconstants.Fetch_Level_OrgID, BIPV2.IDconstants.Fetch_Level_SELEID];
	
	// Layouts:
	layout_AddrAndPropertyData := RECORD
		UNSIGNED4 seq;
		STRING1   AddrIsBest;
		UNSIGNED2 AssetPropertyCount := 0;
		STRING200 PropertyAssessedValueList;
		UNSIGNED8 AssetPropertyAssessedTotal;  
		STRING9		PropertyLotSizeTotal;
		STRING9		BuildingSquareFootageTotal;
		STRING1   BusTypeAddress;
		INTEGER1  Matches_Input_Property;
		STRING		LN_Fares_ID;
	END;

  layout_BestCompanyAddress := RECORD
		UNSIGNED4 seq;
		DATASET(BIPV2_Best.Layouts.company_address_case_layout) company_address;	
	END;
	
	layout_PropertyAssessment := RECORD
		UNSIGNED4 seq;
		STRING unique_prop_id;
		STRING8 sortby_date;
		UNSIGNED8 BuildingSquareFootage;
		RECORDOF(LN_PropertyV2.key_assessor_fid());
	END;

	// Inflate the layout above to hold the fields needed for rolling up.
	layout_PropertyAssessment_inflated := RECORD
		layout_PropertyAssessment;
		UNSIGNED AssetPropertyCount;
		STRING200 PropertyAssessedValueList;
		UNSIGNED8 AssetPropertyAssessedTotal;		
	END;
	
	layout_PropertyDeed := RECORD
		UNSIGNED4 seq;
		STRING unique_prop_id;
		STRING8 sortby_date;
		UNSIGNED8 PropertyLotSize;
		INTEGER1 Matches_Input_Property;
		RECORDOF(LN_PropertyV2.key_deed_fid());
	END;

	// Inflate the layout above to hold the fields needed for rolling up.
	layout_PropertyDeed_inflated := RECORD
		layout_PropertyDeed;
		UNSIGNED AssetPropertyCount;
	END;
	// Functions:
	fn_InputMatchesHeader(Business_Risk_BIP.Layouts.Shell le, layout_BestCompanyAddress ri) := 
		FUNCTION
			addrs_match :=
					le.clean_input.prim_range  = ri.company_address[1].company_prim_range AND 
					le.clean_input.predir      = ri.company_address[1].company_predir AND 
					le.clean_input.prim_name   = ri.company_address[1].company_prim_name AND 
					le.clean_input.addr_suffix = ri.company_address[1].company_addr_suffix AND 
					le.clean_input.postdir     = ri.company_address[1].company_postdir AND 
					le.clean_input.sec_range   = ri.company_address[1].company_sec_range AND 
					le.clean_input.city        = ri.company_address[1].company_p_city_name AND 
					le.clean_input.state       = ri.company_address[1].company_st AND 
					le.clean_input.zip[1..5]   = ri.company_address[1].company_zip5;
			RETURN IF( addrs_match, '1', '0' );
		END;

	// The following function calculates a property identifier that will be unique among
	// a batch of relatively few records, using the prim_range plus prim_name only. We're 
	// truncating the identifier to 8 chars, since on very rare occasions a sec_range will 
	// be mistaken for part of the prim_name, e.g. the address "85 BERKSHIRE D, WEST PALM 
	// BEACH, FL, 33417" points to a condo, and there are at least 4 variants to the prim
	// _name: 85 BERKSHIRE D, 85 BERKSHIRE D 850, 85 BERKSHIRE 850, and 85 BERKSHIRE. Reducing 
	// the length of this property identifier to 8 chars will greatly reduce the chance of one 
	// or more variants of an address being mistaken for different addresses altogether.
	//
	// Why aren't we using the APN? Because not only is it a dirty record identifier (having 
	// dashes, spaces, padding zeroes), it's possible to have more than one APN refer to the
	// same property, e.g. see APNs for 3140 BROOKS ST, DAYTON, OH, 45420; or 3681 ECHO HILL LN, 
	// BEAVERCREEK, OH, 45430. Unacceptable.	
	fn_getAdHocID(STRING Property_City_State_Zip, STRING Mailing_City_State_Zip, STRING Property_Full_Street_Address) :=
		FUNCTION
			// Reference Address.GetCleanAddress...:
			// prim_range  := clean_address[1..10];
			// predir      := clean_address[11..12];
			// prim_name   := clean_address[13..40];
			// addr_suffix := clean_address[41..44];
			// postdir     := clean_address[45..46];
			// unit_desig  := clean_address[47..56];
			// sec_range   := clean_address[57..64];
			// p_city_name := clean_address[90..114];
			// st          := clean_address[115..116];
			// z5          := clean_address[117..121];
			// zip4        := clean_address[122..125];

			// Sometimes the property doesn't have a city-state-zip value. In this case use the 
			// mailing city-state-zip value then. All we want is for the address cleaner to work 
			// so we can obtain the prim_range and prim_name.
			propertycitystatezip := StringLib.StringFindReplace(Property_City_State_Zip, ',',' ');
			mailingcitystatezip  := StringLib.StringFindReplace(Mailing_City_State_Zip, ',',' ');
			citystatezip := IF( propertycitystatezip != '', propertycitystatezip, mailingcitystatezip );

			clean_address  := doxie.cleanaddress182(Property_Full_Street_Address, citystatezip);
			adhoc_id       := ((TRIM(clean_address[1..10]) + TRIM(clean_address[13..40]))[1..8]);
			RETURN adhoc_id;
		END;

	// The following function derives a sortby_date from among the available dates in the 
	// assessment record. Based on LN_PropertyV2_Services.Raw.assess_recency( ).
	fn_getSortbyDate(STRING Assessed_Value_Year, STRING Tax_Year, STRING Market_Value_Year, STRING Certification_Date, STRING Tape_Cut_Date, STRING Recording_Date, STRING Prior_Recording_Date, STRING Sale_Date) := 
		FUNCTION
			sortby_date :=
				MAP( // We want the assessed value, so favor assessed_value_year above all others.
					Assessed_Value_Year != ''  => Assessed_Value_Year+'0000',
					Tax_Year != ''             => Tax_Year+'0000',
					Market_Value_Year != ''    => Market_Value_Year+'0000',
					Certification_Date != ''   => Certification_Date+'00',
					Tape_Cut_Date != ''        => Tape_Cut_Date,
					Recording_Date != ''       => Recording_Date,
					Prior_Recording_Date != '' => Prior_Recording_Date,
					Sale_Date
				);
			RETURN sortby_date;
		END;

	// ---------------[ Best Data ]----------------
	
	// Write to Verification datarow:
	//    o   STRING1 AddrIsBest; 
	//        -  "The full input address matches the header address"; 
	//        -  0 = No; 1 = Yes
	//        -  Brenton: "Should this be the individual location as the best address, or the 
	//           headquarters?"
	
	BestRaw_pre := BIPV2_Best.Key_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
	                                         FETCH_LEVEL,
	                                         0, // ScoreThreshold --> 0 = Give me everything
	                                         linkingOptions, TRUE,
	                                         Business_Risk_BIP.Constants.Limit_Default,
																					 Options.KeepLargeBusinesses);
		
	BestSeq := IF(SELEID_FILTER, BestRaw_pre(proxid = 0), BestRaw_pre);

	// Add back our Seq numbers. NOTE: we'll skip the step of filtering out records after our
	// history date, since the best address records are not characterized by a dt first seen.
	// Business_Risk_BIP.Common.AppendSeq(BestRaw, Shell, BestSeq, Options.LinkSearchLevel);
	
	// Slim to only the seq and the best addresses. This will strongly type the addresses, 
	// which is necessary for passing to a function (see below).
	BestSeq_slim := 
		PROJECT( 
			BestSeq, 
			TRANSFORM( layout_BestCompanyAddress, 
				SELF.company_address := 
					PROJECT( 
						LEFT.company_address, 
						TRANSFORM( BIPV2_Best.Layouts.company_address_case_layout, SELF := LEFT, SELF := [] ) 
					),
				SELF.Seq := LEFT.UniqueID,
				SELF := LEFT
			)
		);
	
	withAddrIsBest :=
		JOIN(
			Shell, BestSeq_slim,
			LEFT.seq = RIGHT.seq, 
			TRANSFORM( layout_AddrAndPropertyData,
				SELF.seq        := LEFT.seq,
				SELF.AddrIsBest := fn_InputMatchesHeader(LEFT,RIGHT),
				SELF := []
			),
			LEFT OUTER, KEEP(1), FEW
		);
		
	// ---------------[ Property Data ]----------------	
	
	// Write to Assets datarow:
	//    o   STRING AssetPropertyCount; 
	//        -  "The count of the number of properties owned by the business"; 
	//        -   -1 = The business is not on file; 0 = The business does not own any property; 
	//            1-9999 = Count of the number of properties owned by this company
	//    o   STRING PropertyAssessedValueList; (Note the spelling error)
	//        -  "The list of assessed property values for each property in the same order as 
	//           'PropertyRecordStateList' in whole dollars";
	//        -  Whole dollar value(s)???
	//    o   STRING AssetPropertyAssessedTotal;
	//        -  "The total assessed value for all property owned by this business in 
	//           whole dollars";
	//        -  -1 = Business is not on file; 0 - 999999999 = Value of property in whole dollars

	Property_raw := LN_propertyv2.key_Linkids.kfetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
	                                         FETCH_LEVEL,
	                                         0, // ScoreThreshold --> 0 = Give me everything
																					 linkingOptions,
																					 Business_Risk_BIP.Constants.Limit_Default,
																					 Options.KeepLargeBusinesses
													);

	// Add back our Seq numbers.
	Business_Risk_BIP.Common.AppendSeq2(Property_raw, Shell, Property_seq);
	
	// Add back our cleaned input
	Business_Risk_BIP.Common.AppendCleanedInput(Property_Seq, Shell, Property_Seq_CleanInput);

	// Filter out records after our history date.
	Property_recs := Business_Risk_BIP.Common.FilterRecords(Property_Seq_CleanInput, dt_first_seen, dt_vendor_first_reported, MDR.SourceTools.src_LnPropV2_Fares_Asrs, AllowedSourcesSet);
		
	// Get Property Assessments
	assessments_raw := 
		JOIN(
			Property_recs, LN_PropertyV2.key_assessor_fid(),																	     
			KEYED(LEFT.ln_fares_id = RIGHT.ln_fares_id), 
			TRANSFORM( layout_PropertyAssessment,
				SELF.seq            := LEFT.seq,
				SELF.ln_fares_id    := LEFT.ln_fares_id,
				SELF.unique_prop_id := fn_getAdHocID(RIGHT.Property_City_State_Zip, RIGHT.Mailing_City_State_Zip, RIGHT.Property_Full_Street_Address),
				SELF.sortby_date    := fn_getSortbyDate(RIGHT.Assessed_Value_Year, RIGHT.Tax_Year, RIGHT.Market_Value_Year, RIGHT.Certification_Date, RIGHT.Tape_Cut_Date, RIGHT.Recording_Date, RIGHT.Prior_Recording_Date, RIGHT.Sale_Date),
				SELF.BuildingSquareFootage	:= (INTEGER)StringLib.StringFilter(RIGHT.Building_Area, '0123456789'); // Filter out the 'SF' at the end of each record, then convert blanks to INTEGER 0's
				SELF                := RIGHT
			), LEFT OUTER, KEEP(1), ATMOST(100)
		);

	assessments_filtered := assessments_raw(unique_prop_id != '' AND sortby_date != '' AND assessed_total_value != '');
	
	assessments_sorted :=	SORT(assessments_filtered,
			seq,
			unique_prop_id,
			-((INTEGER)sortby_date),
			-((INTEGER)(vendor_source_flag IN ['F','S'])) // 'F','S' are FARES records; 'D','O' are FIDELITY records
		);
	
	// The LEFT will be the most recent assessment - keep populated data over blank data
	assessments_most_recent := ROLLUP(assessments_sorted, LEFT.Seq = RIGHT.Seq AND LEFT.Unique_Prop_ID = RIGHT.Unique_Prop_ID,
			TRANSFORM(layout_PropertyAssessment,
				SELF.Seq := LEFT.Seq;
				SELF.BuildingSquareFootage := IF(LEFT.BuildingSquareFootage > 0, LEFT.BuildingSquareFootage, RIGHT.BuildingSquareFootage);
				SELF.assessed_total_value := IF((INTEGER)LEFT.assessed_total_value > 0, LEFT.assessed_total_value, RIGHT.assessed_total_value);
				SELF := LEFT));
	
	assessments_inflated := 
		PROJECT(
			assessments_most_recent,
			TRANSFORM( layout_PropertyAssessment_inflated,
				SELF.AssetPropertyCount            := 1;
				SELF.PropertyAssessedValueList := LEFT.assessed_total_value;
				SELF.AssetPropertyAssessedTotal     := (UNSIGNED8)LEFT.assessed_total_value;
				SELF.BuildingSquareFootage		:= LEFT.BuildingSquareFootage;
				SELF := LEFT; 
				SELF := []
			)
		);
	
	assessments_unique_prop := ROLLUP(SORT(assessments_inflated, Seq, APNA_or_PIN_Number), LEFT.Seq = RIGHT.Seq AND LEFT.APNA_or_PIN_Number = RIGHT.APNA_or_PIN_Number,
			TRANSFORM(layout_PropertyAssessment_inflated,
				SELF.Seq := LEFT.Seq;
				SELF.BuildingSquareFootage := MAX(LEFT.BuildingSquareFootage, RIGHT.BuildingSquareFootage);
				SELF.AssetPropertyCount := LEFT.AssetPropertyCount + RIGHT.AssetPropertyCount;
				SELF.PropertyAssessedValueList := (STRING)MAX((INTEGER)LEFT.PropertyAssessedValueList, (INTEGER)RIGHT.PropertyAssessedValueList);
				SELF.AssetPropertyAssessedTotal := MAX(LEFT.AssetPropertyAssessedTotal, RIGHT.AssetPropertyAssessedTotal);
				SELF := LEFT));
		
	assessments_rolled :=
		ROLLUP(SORT(assessments_unique_prop, Seq), LEFT.seq = RIGHT.seq, 
			TRANSFORM( layout_PropertyAssessment_inflated,
				SELF.seq           := LEFT.seq;
				SELF.AssetPropertyCount := LEFT.AssetPropertyCount + RIGHT.AssetPropertyCount;
				SELF.PropertyAssessedValueList := TRIM(LEFT.PropertyAssessedValueList) + Business_Risk_BIP.Constants.FieldDelimiter + TRIM(RIGHT.PropertyAssessedValueList);
				SELF.AssetPropertyAssessedTotal := LEFT.AssetPropertyAssessedTotal + RIGHT.AssetPropertyAssessedTotal;
				SELF.BuildingSquareFootage := LEFT.BuildingSquareFootage + RIGHT.BuildingSquareFootage;
				SELF := RIGHT));

	withPropertyData := JOIN(withAddrIsBest, assessments_rolled, LEFT.seq = RIGHT.seq, 
			TRANSFORM( layout_AddrAndPropertyData,
				SELF.seq                      	:= LEFT.seq;
				SELF.AddrIsBest               	:= LEFT.AddrIsBest;
				SELF.AssetPropertyCount            	:= 0; // RIGHT.AssetPropertyCount; // For now, don't count assessments in the Property count, as they are being double-counted with the Deed Property Count
				SELF.PropertyAssessedValueList 	:= RIGHT.PropertyAssessedValueList;
				SELF.AssetPropertyAssessedTotal     	:= RIGHT.AssetPropertyAssessedTotal;
				SELF.BuildingSquareFootageTotal	:= (STRING)RIGHT.BuildingSquareFootage;
				SELF := []), LEFT OUTER, KEEP(1), FEW);
		
	// Get Property Deeds
	deeds_raw := JOIN(Property_recs, LN_PropertyV2.key_deed_fid(),																	     
			KEYED(LEFT.ln_fares_id = RIGHT.ln_fares_id) AND
			RIGHT.Buyer_Or_Borrower_Ind = 'O', 
			TRANSFORM({RECORDOF(LEFT), STRING unique_prop_id, STRING sortby_date, STRING land_lot_size, STRING Buyer_Or_Borrower_Ind, INTEGER Matches_Input_Property},
				SELF.unique_prop_id := fn_getAdHocID(RIGHT.Property_Address_CityStateZip, RIGHT.Mailing_CSZ, RIGHT.Property_Full_Street_Address);
				SELF.sortby_date    := fn_getSortbyDate(RIGHT.Contract_Date, RIGHT.Recording_Date, RIGHT.Process_Date, '', '', '', '', '');
				SELF.land_lot_size	:= (STRING)(INTEGER)StringLib.StringFilter(RIGHT.land_lot_size, '0123456789'); // Filter out the 'SF' at the end of each record, then convert blanks to INTEGER so that they become 0's, then back to the STRING layout
				SELF.Buyer_Or_Borrower_Ind := RIGHT.Buyer_Or_Borrower_Ind;
				AddressPopulated		:= TRIM(LEFT.Clean_Input.Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Zip5) <> '' AND TRIM(LEFT.prim_name) <> '' AND TRIM(LEFT.Zip) <> '';
				ZIPScore						:= Risk_Indicators.AddrScore.ZIP_Score(LEFT.Clean_Input.Zip5, LEFT.Zip);
				StateMatched				:= StringLib.StringToUpperCase(LEFT.Clean_Input.State) = StringLib.StringToUpperCase(LEFT.st);
				CityStateScore			:= Risk_Indicators.AddrScore.CityState_Score(LEFT.Clean_Input.City, LEFT.Clean_Input.State, LEFT.p_city_name, LEFT.st, '');
				CityStateZipMatched	:= Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore) AND AddressPopulated;
				AddressMatched			:= Risk_Indicators.iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(LEFT.Clean_Input.Prim_Range, LEFT.Clean_Input.Prim_Name, LEFT.Clean_Input.Sec_Range, 
																						LEFT.prim_range, LEFT.prim_name, LEFT.sec_range,
																						ZIPScore, CityStateScore)) AND AddressPopulated;
				SELF.Matches_Input_Property := (INTEGER)AddressMatched;
				
				SELF                := LEFT;
			), KEEP(1), ATMOST(100));

	deeds_filtered := deeds_raw(unique_prop_id != '' AND sortby_date != '');
	
	uniqueStateCount := TABLE(TABLE(deeds_filtered, {Seq, St}, Seq, St), // Gather all unique States for each Seq
			{UNSIGNED1 UniqueStateCount := COUNT(GROUP, TRIM(St) <> ''), Seq}, Seq); // Count the unique populated States for each Seq
	
	deeds_sorted :=	SORT(deeds_filtered,
			seq,
			unique_prop_id,
			-((INTEGER)sortby_date),
			-((INTEGER)(vendor_source_flag IN ['F','S'])) // 'F','S' are FARES records; 'D','O' are FIDELITY records
		);
	
	// The LEFT will be the most recent deed - keep populated data over blank data
	deeds_most_recent := ROLLUP(deeds_sorted, LEFT.Seq = RIGHT.Seq AND LEFT.Unique_Prop_ID = RIGHT.Unique_Prop_ID,
			TRANSFORM(RECORDOF(LEFT),
				SELF.Land_Lot_Size := IF((INTEGER)LEFT.Land_Lot_Size > 0, LEFT.Land_Lot_Size, RIGHT.Land_Lot_Size);
				SELF.Matches_Input_Property := MAX(LEFT.Matches_Input_Property, RIGHT.Matches_Input_Property);
				SELF := LEFT));
	
	deeds_inflated := PROJECT(deeds_most_recent,
			TRANSFORM(layout_PropertyDeed_inflated,
				SELF.AssetPropertyCount            := 1;
				SELF.PropertyLotSize					:= (INTEGER)LEFT.Land_Lot_Size;
				SELF.Matches_Input_Property   := IF(TRIM(LEFT.LN_Fares_ID) = '', -1, LEFT.Matches_Input_Property);
				SELF := LEFT; 
				SELF := []));
				
	deeds_unique_prop := ROLLUP(SORT(deeds_inflated, Seq, APNT_or_PIN_Number), LEFT.Seq = RIGHT.Seq AND LEFT.APNT_or_PIN_Number = RIGHT.APNT_or_PIN_Number,
			TRANSFORM(layout_PropertyDeed_inflated,
				SELF.Seq := LEFT.Seq;
				SELF.PropertyLotSize := MAX(LEFT.PropertyLotSize, RIGHT.PropertyLotSize);
				SELF.Matches_Input_Property := MAX(LEFT.Matches_Input_Property, RIGHT.Matches_Input_Property);
				SELF.AssetPropertyCount := LEFT.AssetPropertyCount + RIGHT.AssetPropertyCount;
				SELF := LEFT));
		
	deeds_rolled :=	ROLLUP(SORT(deeds_unique_prop, Seq),	LEFT.seq = RIGHT.seq, 
			TRANSFORM(layout_PropertyDeed_inflated,
				SELF.seq           := LEFT.seq;
				SELF.AssetPropertyCount := LEFT.AssetPropertyCount + RIGHT.AssetPropertyCount;
				SELF.PropertyLotSize := LEFT.PropertyLotSize + RIGHT.PropertyLotSize;
				SELF.Matches_Input_Property := MAX(LEFT.Matches_Input_Property, RIGHT.Matches_Input_Property);
				SELF := RIGHT));

	withPropertyDeedData :=	JOIN(withPropertyData, deeds_rolled, LEFT.seq = RIGHT.seq, 
			TRANSFORM(layout_AddrAndPropertyData,
				SELF.seq                      := LEFT.seq;
				SELF.AssetPropertyCount            := LEFT.AssetPropertyCount + RIGHT.AssetPropertyCount;
				SELF.PropertyLotSizeTotal			:= (STRING)RIGHT.PropertyLotSize;
				SELF.Matches_Input_Property   := RIGHT.Matches_Input_Property;
				SELF := LEFT;
				SELF := []), LEFT OUTER, KEEP(1), FEW);

	// ---------------[ Business Type Data ]----------------	
		
	// Write to Firmographic datarow:
	//    o   STRING BusTypeAddress;
	//        -  "The address type as determined in the CORPS data sources";
	//        -  Lexis defined set of Address types:
	//             'B' -> 'BUSINESS'
	//             'F' -> 'FILING'
	//             'G' -> 'REGISTERED OFFICE'
	//             'M' -> 'MAILING'
	//             'N' -> 'FRANCHISOR'
	//             'P' -> 'PROCESS'
	//             'R' -> 'FRANCHISEE'
	//             'T' -> 'CONTACT'
	//        -  NOTE: the list formed in the possible values, is the fields 
	//           corp_address1_type_cd and corp_address1_type_desc from the CORPS source 
	//           joined together. 

	CorpFilings_raw := Corp2.Key_LinkIDs.Corp.kfetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
	                                         FETCH_LEVEL,
	                                         0, // ScoreThreshold --> 0 = Give me everything
																					 Business_Risk_BIP.Constants.Limit_Default,
																					 Options.KeepLargeBusinesses
													);

	// Add back our Seq numbers.
	Business_Risk_BIP.Common.AppendSeq2(CorpFilings_raw, Shell, CorpFilings_seq);

 // Calculate the source code by state to restrict records for Marketing properly. We'll 
 // borrow corp_src_type for the state source code.
 CorpFilings_withSrcCode := 
  PROJECT(
    CorpFilings_seq,
    TRANSFORM( RECORDOF(CorpFilings_seq),
      SELF.corp_src_type := MDR.sourceTools.fCorpV2( LEFT.corp_key, LEFT.corp_state_origin ),
      SELF := LEFT
    ) );
    
	// Filter out records after our history date.
	CorpFilings_recs := Business_Risk_BIP.Common.FilterRecords(CorpFilings_withSrcCode, dt_first_seen, dt_vendor_first_reported, corp_src_type, AllowedSourcesSet);
	
	CorpFilings_sorted :=
		SORT(
			CorpFilings_recs,
			seq, corp_key, -corp_process_date
		);

	CorpFilings_having_BusTypeAddr_most_recent :=
		DEDUP(
			// CorpFilings_sorted((corp_address1_type_cd + corp_address1_type_desc) != ''),
			CorpFilings_sorted(corp_address1_type_cd != '' OR corp_address1_type_desc != ''),
			seq, corp_key
		);

	withBusTypeAddress :=
		JOIN(
			withPropertyDeedData, CorpFilings_having_BusTypeAddr_most_recent,
			LEFT.seq = RIGHT.seq, 
			TRANSFORM( layout_AddrAndPropertyData,			
				SELF.BusTypeAddress := Business_Risk_BIP.Common.GetBusinessType(RIGHT.corp_address1_type_cd, RIGHT.corp_address1_type_desc),
				SELF := LEFT
			),
			LEFT OUTER, KEEP(1), FEW
		);

	// Add to the Shell.
	withAddrAndPropertyData := 
		JOIN(
			Shell, withBusTypeAddress, 
			LEFT.Seq = RIGHT.Seq,
			TRANSFORM( Business_Risk_BIP.Layouts.Shell,
				SELF.Verification.AddrIsBest         := RIGHT.AddrIsBest,
				SELF.Asset_Information.AssetPropertyCount            := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.AssetPropertyCount, -1, 9999),
				SELF.Asset_Information.PropertyAssessedValueList := RIGHT.PropertyAssessedValueList,
				SELF.Asset_Information.AssetPropertyAssessedTotal     := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.AssetPropertyAssessedTotal, -1, 999999999),
				SELF.Firmographic.BusTypeAddress     := RIGHT.BusTypeAddress,
				SELF.Asset_Information.AssetPropertyLotSizeTotal:= (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.PropertyLotSizeTotal, -1, 999999999),
				SELF.Asset_Information.AssetPropertySqFootageTotal	 := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.BuildingSquareFootageTotal, -1, 999999999),
				SELF.Verification.InputAddrOwnership := (STRING)RIGHT.Matches_Input_Property;
				SELF.Input_Characteristics.InputAddrBusinessOwned			 := MAP(RIGHT.Matches_Input_Property >= 1 => '1', 
																										RIGHT.Matches_Input_Property = 0	=> '0',
																																												 '-1');
				SELF := LEFT
			),
			LEFT OUTER, KEEP(1), ATMOST(100), FEW
		);
	
	withStateCount := JOIN(withAddrAndPropertyData, uniqueStateCount, LEFT.Seq = RIGHT.Seq,
			TRANSFORM(Business_Risk_BIP.Layouts.Shell,
				SELF.Asset_Information.AssetPropertyStateCount := (STRING)Business_Risk_BIP.Common.capNum(MIN(RIGHT.UniqueStateCount, (INTEGER)LEFT.Asset_Information.AssetPropertyCount), -1, 9999);
				SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
	PropertyStats := TABLE(Property_recs,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 SourceField := MDR.SourceTools.src_LnPropV2_Fares_Asrs,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_vendor_first_reported, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_vendor_last_reported, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP)
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );
	// Rollup the dates first/last seen into child datasets by Seq
	tempLayout := RECORD
		UNSIGNED4 Seq;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) Sources;
	END;
	PropertyStatsTemp := PROJECT(PropertyStats, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.Sources := DATASET([{LEFT.SourceField, 
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF := []));
	PropertyStatsRolled := ROLLUP(PropertyStatsTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.Sources := LEFT.Sources + RIGHT.Sources; SELF := LEFT));
	
	withPropertyStats := JOIN(withStateCount, PropertyStatsRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							// Make sure if we have a current property that it gets recorded to the sources list.
																							SELF.Sources := LEFT.Sources + IF((INTEGER)LEFT.Asset_Information.AssetPropertyCount > 0, RIGHT.Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
			
	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT( Shell, NAMED('Shell') );
	// OUTPUT( Business_Risk_BIP.Common.GetLinkIDs(Shell), NAMED('linkids') );
	// OUTPUT( BestSeq, NAMED('BestSeq') );
	// OUTPUT( BestSeq_slim, NAMED('BestSeq_slim') );
	// OUTPUT( withAddrIsBest, NAMED('withAddrIsBest') );
	// OUTPUT( Property_raw, NAMED('Property_raw') );
	// OUTPUT( Property_seq, NAMED('Property_seq') );
	// OUTPUT( Property_recs, NAMED('Property_recs') );
	// OUTPUT( assessments_raw, NAMED('assessments_raw') );
	// OUTPUT( assessments_filtered, NAMED('assessments_filtered') );
	// OUTPUT( assessments_sorted, NAMED('assessments_sorted') );
	// OUTPUT( assessments_most_recent, NAMED('assessments_most_recent') );
	// OUTPUT( assessments_inflated, NAMED('assessments_inflated') );
	// OUTPUT( assessments_rolled, NAMED('assessments_rolled') );
	// OUTPUT( withPropertyData, NAMED('withPropertyData') );
	// OUTPUT( CorpFilings_sorted, NAMED('CorpFilings_sorted') );
	// OUTPUT( CorpFilings_having_BusTypeAddr_most_recent, NAMED('CorpFilings_most_recent') );
	// OUTPUT( withBusTypeAddress, NAMED('withBusTypeAddress') );
	// OUTPUT( withAddrAndPropertyData, NAMED('withAddrAndPropertyData') );
	
	RETURN withPropertyStats;

END;
