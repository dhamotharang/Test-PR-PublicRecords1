IMPORT Address, BIPV2, Business_Risk, Business_Risk_BIP, DID_Add, Risk_Indicators, STD, ut, Doxie;

	// The following function determines whether Business data passed in from the customer were actually found
	// in various sources.
	EXPORT getVerifiedElements(DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet,
											 doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := 
		FUNCTION
				UCase := STD.Str.ToUpperCase;
    ds_BIPIDs := Business_Risk_BIP.Common.GetLinkIDs(Shell);
    
    layout_seq_temp := {UNSIGNED4 seq};

				// Function aliases. Turns out, Risk_Indicators.AddrScore.zip_score just does some generic 
    // string-compares.
				fn_StateScore  := Risk_Indicators.AddrScore.zip_score;
				fn_Zip5Score   := Risk_Indicators.AddrScore.zip_score;

    // 1. Get records from the Business Header.
    // --------------- LexisNexis Business Header ----------------
			
    ds_BusinessHeaderRaw1 :=
        BIPV2.Key_BH_Linking_Ids.kFetch2(inputs := ds_BIPIDs,
                       Level                    := Business_Risk_BIP.Common.SetLinkSearchLevel(Business_Risk_BIP.Constants.LinkSearch.SeleID),
                       ScoreThreshold           := 0, // ScoreThreshold --> 0 = Give me everything
                       in_mod                   := linkingOptions,
                       JoinLimit                := Business_Risk_BIP.Constants.Limit_BusHeader,
                       dnbFullRemove            := FALSE,
                       bypassContactSuppression := TRUE,
                       JoinType                 := Options.KeepLargeBusinesses,
						mod_access := mod_access);
	
		// clean up the business header before doing anything else
		Business_Risk_BIP.Common.mac_slim_header(ds_BusinessHeaderRaw1, ds_BusinessHeaderRaw);	
	
    // Add back our Seq numbers.
    ds_BusinessHeaderSeq := 
      JOIN(
        Shell, ds_BusinessHeaderRaw, 
        LEFT.Seq = RIGHT.UniqueID,
        TRANSFORM( Business_Risk_BIP.Layouts.LayoutBusinessHeaderSlim, 
          SELF.seq := LEFT.seq,
          SELF.uniqueid := RIGHT.uniqueid, 
          SELF.HistoryDate := LEFT.Clean_Input.HistoryDate,
          SELF := RIGHT,
					self := []), 
        FEW);		
					
    // Filter out records after our history date and sources that aren't allowed - pass in AllowedSources to possibly turn on DNB DMI data
    ds_BusinessHeader := GROUP(Business_Risk_BIP.Common.FilterRecords(ds_BusinessHeaderSeq, dt_first_seen, dt_vendor_first_reported, Source, AllowedSourcesSet), Seq);

    // Obtain just the seq number.
    ds_LN_Business_Header_recs_seq_only :=
      PROJECT( DEDUP( SORT( ds_BusinessHeader, seq), seq), layout_seq_temp );

    ds_header_records := SORT( (ds_BusinessHeader ), seq );

				// Slim down the Business Header records to only what's needed for Verify Echo calculations,
				// and then DEDUP for efficiency.
				ds_BusinessHeaderSlim := 
					TABLE( ds_header_records, {uniqueid, company_name, prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range, p_city_name, v_city_name, st, zip, zip4, fips_county, company_fein, company_phone} );

				ds_BusinessHeaderSlimDeduped := DEDUP( ds_BusinessHeaderSlim, RECORD, ALL, HASH );

    // 2. ---------- Verify Business input elements. ----------

				layout_temp := RECORD
					UNSIGNED4 Seq;
					STRING120 origCompanyName;
					STRING120 origAltCompanyName;
					STRING120 origStreetAddress;
					STRING25  origCity;
					STRING2   origState;
					STRING5   origZip5;
					STRING9   origFEIN;
					STRING10  origPhone10;	
					STRING120 CompanyName;
					STRING120 AltCompanyName;
					STRING120 StreetAddress;
					STRING25  City;
					STRING2   State;
					STRING5   Zip5;
					STRING4   Zip4;
					STRING25  County;
					STRING9   FEIN;
					STRING10  Phone10;		
					UNSIGNED3 NameScore;
					UNSIGNED3 AltNameScore;
					UNSIGNED3 AddrScore;
					UNSIGNED3 CityScore;
					UNSIGNED3 StateScore;
					UNSIGNED3 Zip5Score;
					UNSIGNED3 TINScore;
					UNSIGNED3 PhoneScore;
				END;
				
				// Okay, let's do some matching. The Company and Address data in the layout below
				// are from the matching key record. Seq is from the input record.			

				layout_temp xfm_ScoreTheData( Business_Risk_BIP.Layouts.Shell le, ds_BusinessHeaderSlimDeduped ri ) :=
        TRANSFORM
          
          inp_city  := UCase(TRIM(le.Input_Echo.City));
          p_city    := UCase(TRIM(ri.p_city_name));
          v_city    := UCase(TRIM(ri.v_city_name));

          // Company Name
          NamePopulated      := le.Input_Echo.CompanyName <> '' AND ri.Company_Name <> '';
          NameMatchedExactly := NamePopulated AND (TRIM(le.Input_Echo.CompanyName) = TRIM(ri.Company_Name));
          NameScore_pre      := Business_Risk.CNameScore(le.Input_Echo.CompanyName, ri.Company_Name);
          NameMatched        := NamePopulated AND le.Input_Echo.CompanyName[1] = ri.Company_Name[1] AND Risk_Indicators.iid_constants.g(NameScore_pre);
          NameScore          := IF( NameMatchedExactly, 200, NameScore_pre );

          // Alternate Company Name
          AltNamePopulated      := le.Input_Echo.AltCompanyName <> '' AND ri.Company_Name <> '';
          AltNameMatchedExactly := AltNamePopulated AND (TRIM(le.Input_Echo.AltCompanyName) = TRIM(ri.Company_Name));
          AltNameScore_pre      := Business_Risk.CNameScore(le.Input_Echo.AltCompanyName, ri.Company_Name);
          AltNameMatched        := AltNamePopulated AND le.Input_Echo.AltCompanyName[1] = ri.Company_Name[1] AND Risk_Indicators.iid_constants.g(AltNameScore_pre);
          AltNameScore          := IF( AltNameMatchedExactly, 200, AltNameScore_pre );
          
          // Company City, State, Zip5, Zip4, County, and Address.						
          CityPopulated := inp_city != '' AND (p_city != '' OR v_city != '');
          
          // Calculate the City score against both the p_city_name and v_city_name; choose the greater.
          // NOTE: ut.StringSimilar100 --> lower value is a better match
          P_CityScore := 100 - MIN(ut.StringSimilar100(inp_city, p_city), ut.StringSimilar100(p_city, inp_city));
          V_CityScore := 100 - MIN(ut.StringSimilar100(inp_city, v_city), ut.StringSimilar100(v_city, inp_city));
          CityScore   := IF( CityPopulated, MAX(P_CityScore,V_CityScore), Risk_Indicators.iid_constants.default_empty_score );
          CityMatched := Risk_Indicators.iid_constants.ga( CityScore );
          use_V_City  := V_CityScore > P_CityScore;
              
          StateScore := fn_StateScore( le.Input_Echo.State, ri.st );
          StateMatched := StateScore = 100;
          
          CityStateScore := 
              MAP(
                CityScore = Risk_Indicators.iid_constants.default_empty_score OR 
                StateScore = Risk_Indicators.iid_constants.default_empty_score  => Risk_Indicators.iid_constants.default_empty_score,
                CityScore BETWEEN 80 AND 100 AND StateMatched  => 100,    
                0 
              );
          
          Zip5Score := fn_Zip5Score( le.Input_Echo.Zip, ri.Zip );
          Zip5Matched := Zip5Score = 100;
          
          // Calculate Address score; a bit more work.
          CleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(le.Input_Echo.StreetAddress1, inp_city, le.Input_Echo.State, le.Input_Echo.Zip, le.Input_Echo.StreetAddress2);											
          cln := Address.CleanFields(CleanAddr);

          AddressPopulated := (le.Input_Echo.StreetAddress1 <> '' OR le.Input_Echo.StreetAddress2 <> '') AND ri.prim_name <> '';
          AddressScore := 
              IF(
                  Zip5Score = Risk_Indicators.iid_constants.default_empty_score AND CityStateScore = Risk_Indicators.iid_constants.default_empty_score, 
                  Risk_Indicators.iid_constants.default_empty_score, 
                  Risk_Indicators.AddrScore.AddressScore(cln.Prim_Range, cln.Prim_Name, cln.Sec_Range, ri.prim_range, ri.prim_name, ri.sec_range, Zip5Score, CityStateScore)
                );
          AddressMatched := AddressPopulated AND Risk_Indicators.iid_constants.ga( AddressScore );

          // Company TIN (use only the input FEIN).			
          TINPopulated := le.Input_Echo.FEIN != '' AND ri.company_fein != '';
          TINScore     := DID_Add.SSN_Match_Score( ri.company_fein, le.Input_Echo.FEIN, LENGTH(TRIM(le.Input_Echo.FEIN)) = 4 );
          TINMatched   := TINPopulated AND le.Input_Echo.FEIN[1] = ri.company_fein[1] AND Risk_Indicators.iid_constants.gn( TINScore );

          // Company Phone (use only the Business Phone).		
          PhonePopulated := le.Input_Echo.Phone10 != '' AND ri.Company_Phone != '';
          PhoneScore     := Risk_Indicators.PhoneScore( ri.Company_Phone, le.Input_Echo.Phone10 );
          PhoneMatched   := PhonePopulated AND (le.Input_Echo.Phone10[1] = ri.Company_Phone[1] OR le.Input_Echo.Phone10[4] = ri.Company_Phone[4] OR le.Input_Echo.Phone10[4] = ri.Company_Phone[1]) AND Risk_Indicators.iid_constants.gn( PhoneScore );
          
          // Begin transform...:
          SELF.Seq               := le.Input_Echo.Seq;
          SELF.origCompanyName   := le.Input_Echo.CompanyName;
          SELF.origAltCompanyName:= le.Input_Echo.AltCompanyName;
          SELF.origStreetAddress := le.Input_Echo.StreetAddress1 + IF( le.Input_Echo.StreetAddress2 != '', ' ' + le.Input_Echo.StreetAddress2, '' );
          SELF.origCity          := le.Input_Echo.City;
          SELF.origState         := le.Input_Echo.State;
          SELF.origZip5          := le.Input_Echo.zip;
          SELF.origFEIN          := le.Input_Echo.FEIN;
          SELF.origPhone10       := le.Input_Echo.Phone10;	
          SELF.CompanyName       := IF( NameMatched, UCase(ri.Company_Name), '' );
          SELF.AltCompanyName    := IF( AltNameMatched, UCase(ri.Company_Name), '' );
          SELF.StreetAddress     := IF( AddressMatched, UCase(Risk_Indicators.MOD_AddressClean.street_address( '', ri.prim_range, ri.predir, ri.prim_name, ri.addr_suffix, ri.postdir, ri.unit_desig, ri.sec_range)), '' );
          SELF.City              := IF( CityMatched, UCase(IF( use_V_City, v_city, p_city )), '' );
          SELF.State             := IF( StateMatched, UCase(ri.st), '' );
          SELF.Zip5              := IF( Zip5Matched, ri.Zip, '' );
          SELF.FEIN              := IF( TINMatched, ri.company_fein, '' );
          SELF.Phone10           := IF( PhoneMatched, ri.company_phone, '' );		
          SELF.NameScore         := IF( NameScore    != Risk_Indicators.iid_constants.default_empty_score, NameScore   , 0 );
          SELF.AltNameScore      := IF( AltNameScore != Risk_Indicators.iid_constants.default_empty_score, AltNameScore, 0 );
          SELF.AddrScore         := IF( AddressScore != Risk_Indicators.iid_constants.default_empty_score, AddressScore, 0 );
          SELF.CityScore         := IF( CityScore    != Risk_Indicators.iid_constants.default_empty_score, CityScore   , 0 );
          SELF.StateScore        := IF( StateScore   != Risk_Indicators.iid_constants.default_empty_score, StateScore  , 0 );
          SELF.Zip5Score         := IF( Zip5Score    != Risk_Indicators.iid_constants.default_empty_score, Zip5Score   , 0 );
          SELF.TINScore          := IF( TINScore     != Risk_Indicators.iid_constants.default_empty_score, TINScore    , 0 );
          SELF.PhoneScore        := IF( PhoneScore   != Risk_Indicators.iid_constants.default_empty_score, PhoneScore  , 0 );
          SELF := [];
        END; // transform
					
				ds_Matching :=
					JOIN(
						Shell, ds_BusinessHeaderSlimDeduped,
						LEFT.Seq = RIGHT.uniqueid,
						xfm_ScoreTheData(LEFT,RIGHT),
						LEFT OUTER
					);

				layout_temp xfm_RollTheScores( layout_temp le, layout_temp ri ) :=
					TRANSFORM
						SELF.Seq               := le.Seq;
						SELF.origCompanyName   := le.origCompanyName;
						SELF.origAltCompanyName:= le.origAltCompanyName;
						SELF.origStreetAddress := le.origStreetAddress;
						SELF.origCity          := le.origCity;
						SELF.origState         := le.origState;
						SELF.origZip5          := le.origZip5;
						SELF.origFEIN          := le.origFEIN;
						SELF.origPhone10       := le.origPhone10;	
						SELF.CompanyName       := IF( le.NameScore    > ri.NameScore   , le.CompanyName   , ri.CompanyName );
						SELF.AltCompanyName    := IF( le.AltNameScore > ri.AltNameScore, le.AltCompanyName, ri.AltCompanyName );
						SELF.StreetAddress     := IF( le.AddrScore    > ri.AddrScore   , le.StreetAddress , ri.StreetAddress );
						SELF.City              := IF( le.CityScore    > ri.CityScore   , le.City          , ri.City );
						SELF.State             := IF( le.StateScore   > ri.StateScore  , le.State         , ri.State );
						SELF.Zip5              := IF( le.Zip5Score    > ri.Zip5Score   , le.Zip5          , ri.Zip5 );
						SELF.FEIN              := IF( le.TINScore     > ri.TINScore    , le.FEIN          , ri.FEIN );
						SELF.Phone10           := IF( le.PhoneScore   > ri.PhoneScore  , le.Phone10       , ri.Phone10 );	
						SELF.NameScore         := IF( le.NameScore    > ri.NameScore   , le.NameScore     , ri.NameScore );
						SELF.AltNameScore      := IF( le.AltNameScore > ri.AltNameScore, le.AltNameScore  , ri.AltNameScore );
						SELF.AddrScore         := IF( le.AddrScore    > ri.AddrScore   , le.AddrScore     , ri.AddrScore );
						SELF.CityScore         := IF( le.CityScore    > ri.CityScore   , le.CityScore     , ri.CityScore );
						SELF.StateScore        := IF( le.StateScore   > ri.StateScore  , le.StateScore    , ri.StateScore );
						SELF.Zip5Score         := IF( le.Zip5Score    > ri.Zip5Score   , le.Zip5Score     , ri.Zip5Score );
						SELF.TINScore          := IF( le.TINScore     > ri.TINScore    , le.TINScore      , ri.TINScore );
						SELF.PhoneScore        := IF( le.PhoneScore   > ri.PhoneScore  , le.PhoneScore    , ri.PhoneScore );
						SELF := [];
					END;

				ds_MatchingRolled :=
					ROLLUP(
						ds_Matching,
						LEFT.Seq = RIGHT.Seq,
						xfm_RollTheScores(LEFT,RIGHT)
					);

				// Gain some extra lift from Business Shell verification indicators.
				Business_Risk_BIP.Layouts.Shell xfm_AddVerificationElements( Business_Risk_BIP.Layouts.Shell le, layout_temp ri ) := 
					TRANSFORM
						ver_name_src_count   := (INTEGER)le.Verification.NameMatchSourceCount;
						ver_altnm_src_count  := (INTEGER)le.Verification.AltNameMatchSourceCount;
						ver_addr_src_count   := (INTEGER)le.Verification.AddrVerificationSourceCount; 
						ver_phn_src_count    := (INTEGER)le.Verification.PhoneMatchSourceCount;
						ver_phn_src_id_count := (INTEGER)le.Verification.PhoneMatchSourceCountID;
						ver_fein_src_count   := (INTEGER)le.Verification.FEINMatchSourceCount;

						BOOLEAN ver_nam   := ver_name_src_count  > 0;
						BOOLEAN ver_altnm := ver_altnm_src_count > 0;
						BOOLEAN ver_add   := ver_addr_src_count  > 0;
						BOOLEAN ver_phn   := ver_phn_src_count   > 0 OR ver_phn_src_id_count > 0;
						BOOLEAN ver_tin   := ver_fein_src_count  > 0;

						// Since the Business Shell doesn't provide CompanyNames, Addresses, or other data, fill in 
						// these data from the original input if this product couldn't find the Business in the 
						// Business Header, but the Business Shell found it in other sources.
						_CompanyName    := Business_Risk_BIP.Common.fn_CleanString( TRIM( IF( ver_nam   AND TRIM(ri.CompanyName)    = '', ri.origCompanyName   , ri.CompanyName ) ) );
						_AltCompanyName := Business_Risk_BIP.Common.fn_CleanString( TRIM( IF( ver_altnm AND TRIM(ri.AltCompanyName) = '', ri.origAltCompanyName, ri.AltCompanyName ) ) );
						
						SELF.Verification.VerifiedCompanyName       := _CompanyName;
						SELF.Verification.VerifiedAltCompanyName    := _AltCompanyName;
						SELF.Verification.VerifiedCompanyAddress1   := IF( ver_add AND TRIM(ri.StreetAddress) = '', ri.origStreetAddress , ri.StreetAddress );
						SELF.Verification.VerifiedCompanyCity       := IF( ver_add AND TRIM(ri.City) = ''         , ri.origCity          , ri.City );
						SELF.Verification.VerifiedCompanyState      := IF( ver_add AND TRIM(ri.State) = ''        , ri.origState         , ri.State );
						SELF.Verification.VerifiedCompanyZip        := IF( ver_add AND TRIM(ri.Zip5) = ''         , ri.origZip5          , ri.Zip5 );
						SELF.Verification.VerifiedCompanyFEIN       := IF( ver_tin AND TRIM(ri.FEIN) = ''         , ri.origFEIN          , ri.FEIN );
						SELF.Verification.VerifiedCompanyPhone      := IF( ver_phn AND TRIM(ri.Phone10) = ''      , ri.origPhone10       , ri.Phone10 );		
						SELF.Verification.VerifiedCompanyNameInd    := (STRING)((INTEGER)(ver_nam OR ver_altnm));
						SELF.Verification.VerifiedCompanyAddressInd := (STRING)((INTEGER)ver_add);
						SELF.Verification.VerifiedCompanyFEINInd    := (STRING)((INTEGER)ver_tin);
						SELF.Verification.VerifiedCompanyPhoneInd   := (STRING)((INTEGER)ver_phn);
						SELF := le;
						SELF := [];
					END;
				
				// Add Verification data to the Business Shell results: CompanyName, AltComapanyName, Address, FEIN, Phone.
				ds_withVerifiedElements := 
					JOIN(
						Shell, ds_MatchingRolled, 
						LEFT.seq = RIGHT.seq,
						xfm_AddVerificationElements(LEFT,RIGHT),
						LEFT OUTER, KEEP(1), PARALLEL, FEW
					);

				// DEBUGs...:
				// OUTPUT( ds_BIPIDs, NAMED('BIPIDs') );
				// OUTPUT( ds_BusinessHeaderRaw1, NAMED('BusinessHeaderRaw1') );
				// OUTPUT( ds_BusinessHeaderSeq, NAMED('BusinessHeaderSeq') );
				// OUTPUT( ds_BusinessHeaderSlimDeduped, NAMED('BusinessHeaderSlimDeduped') );
				// OUTPUT( ds_Matching, NAMED('Matching') );
				// OUTPUT( ds_MatchingRolled, NAMED('MatchingRolled') );
        
				RETURN ds_withVerifiedElements;
		END;