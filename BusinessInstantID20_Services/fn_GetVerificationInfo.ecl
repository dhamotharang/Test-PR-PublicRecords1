IMPORT Address, Business_Risk, Business_Risk_BIP, Census_data, DID_Add, Risk_Indicators, STD, ut;

	// The following function determines whether Business data passed in from the customer were actually found
	// in various sources.
	EXPORT fn_GetVerificationInfo( DATASET(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean) ds_CleanedInput,  
	                               DATASET(BusinessInstantID20_Services.layouts.BusinessHeaderSlim) ds_BusinessHeader,
																 DATASET(Business_Risk_BIP.Layouts.Shell) ds_Shell_Results,
																 BusinessInstantID20_Services.iOptions Options) := 
		FUNCTION
				UCase := STD.Str.ToUpperCase;

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
				
				// Function aliases. Turns out, Risk_Indicators.AddrScore.zip_score just does some generic string-compares.
				fn_StateScore  := Risk_Indicators.AddrScore.zip_score;
				fn_Zip5Score   := Risk_Indicators.AddrScore.zip_score;

				// Slim down the Business Header records to only what's needed for Verify Echo calculations,
				// and then DEDUP for efficiency.
				ds_BusinessHeaderSlim :=
					TABLE( ds_BusinessHeader, {uniqueid, company_name, prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range, p_city_name, v_city_name, st, zip, zip4, fips_county, company_fein, company_phone} );

				ds_BusinessHeaderSlimDeduped := DEDUP( ds_BusinessHeaderSlim, RECORD, ALL, HASH );

				// Okay, let's do some matching. The Company and Address data in the layout below
				// are from the matching key record. Seq is from the input record.				
				layout_temp xfm_ScoreTheData( ds_CleanedInput le, ds_BusinessHeaderSlimDeduped ri ) :=
					TRANSFORM
						// NOTE: except for the company name, we're making no effort at this point to improve
						// efficiency by doing first character comparisons to short-circuit fuzzy matching, as 
						// in Business_Risk_BIP.getBusinessHeader( ).	
            
						inp_city  := UCase(TRIM(le.p_city_name));
						p_city    := UCase(TRIM(ri.p_city_name));
						v_city    := UCase(TRIM(ri.v_city_name));
	
						// Company Name
						NamePopulated      := le.CompanyName <> '' AND ri.Company_Name <> '';
						NameMatchedExactly := NamePopulated AND (TRIM(le.CompanyName) = TRIM(ri.Company_Name));
						NameScore_pre      := Business_Risk.CNameScore(le.CompanyName, ri.Company_Name);
						NameMatched        := NamePopulated AND le.CompanyName[1] = ri.Company_Name[1] AND Risk_Indicators.iid_constants.g(NameScore_pre);
						NameScore          := IF( NameMatchedExactly, 200, NameScore_pre );

						// Company Name
						AltNamePopulated      := le.AltCompanyName <> '' AND ri.Company_Name <> '';
						AltNameMatchedExactly := AltNamePopulated AND (TRIM(le.AltCompanyName) = TRIM(ri.Company_Name));
						AltNameScore_pre      := Business_Risk.CNameScore(le.AltCompanyName, ri.Company_Name);
						AltNameMatched        := AltNamePopulated AND le.AltCompanyName[1] = ri.Company_Name[1] AND Risk_Indicators.iid_constants.g(AltNameScore_pre);
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
								
						StateScore := fn_StateScore( le.St, ri.st );
						StateMatched := StateScore = 100;
						
						CityStateScore := 
								MAP(
									CityScore = Risk_Indicators.iid_constants.default_empty_score OR 
									StateScore = Risk_Indicators.iid_constants.default_empty_score  => Risk_Indicators.iid_constants.default_empty_score,
									CityScore BETWEEN 80 AND 100 AND StateMatched  => 100,    
									0 
								);
						
						Zip5Score := fn_Zip5Score( le.Zip5, ri.Zip );
						Zip5Matched := Zip5Score = 100;
						

            // Calculate Address score; a bit more work.
						AddressPopulated := (le.StreetAddress1 <> '' OR le.StreetAddress2 <> '') AND ri.prim_name <> '';
						AddressScore := 
								IF(
										Zip5Score = Risk_Indicators.iid_constants.default_empty_score AND CityStateScore = Risk_Indicators.iid_constants.default_empty_score, 
										Risk_Indicators.iid_constants.default_empty_score, 
										Risk_Indicators.AddrScore.AddressScore(le.Prim_Range, le.Prim_Name, le.Sec_Range, ri.prim_range, ri.prim_name, ri.sec_range, Zip5Score, CityStateScore)
									);
						AddressMatched := AddressPopulated AND Risk_Indicators.iid_constants.ga( AddressScore );

						// Company TIN (use only the input FEIN).			
						TINPopulated := le.FEIN != '' AND ri.company_fein != '';
						TINScore     := DID_Add.SSN_Match_Score( ri.company_fein, le.FEIN, LENGTH(TRIM(le.FEIN)) = 4 );
						TINMatched   := TINPopulated AND le.FEIN[1] = ri.company_fein[1] AND Risk_Indicators.iid_constants.gn( TINScore );

						// Company Phone (use only the Business Phone).		
						PhonePopulated := le.Phone10 != '' AND ri.Company_Phone != '';
						PhoneScore     := Risk_Indicators.PhoneScore( ri.Company_Phone, le.Phone10 );
						PhoneMatched   := PhonePopulated AND (le.Phone10[1] = ri.Company_Phone[1] OR le.Phone10[4] = ri.Company_Phone[4] OR le.Phone10[4] = ri.Company_Phone[1]) AND Risk_Indicators.iid_constants.gn( PhoneScore );
						
						// Begin transform...:
						SELF.Seq               := le.Seq;
						SELF.origCompanyName   := le.CompanyName;
						SELF.origAltCompanyName:= le.AltCompanyName;
						SELF.origStreetAddress := le.StreetAddress1 + IF( le.StreetAddress2 != '', ' ' + le.StreetAddress2, '' );
						SELF.origCity          := le.City;
						SELF.origState         := le.State;
						SELF.origZip5          := le.zip;
						SELF.origFEIN          := le.FEIN;
						SELF.origPhone10       := le.Phone10;	
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
					END;
					
				ds_Matching :=
					JOIN(
						ds_CleanedInput, ds_BusinessHeaderSlimDeduped,
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
				BusinessInstantID20_Services.Layouts.VerificationTempLayout xfm_AddShellData( layout_temp le, Business_Risk_BIP.Layouts.Shell ri ) := 
					TRANSFORM
						ver_name_src_count   := ri.Verification.NameMatchSourceCount;
						ver_altnm_src_count  := ri.Verification.AltNameMatchSourceCount;
						ver_addr_src_count   := ri.Verification.AddrVerificationSourceCount; 
						ver_phn_src_count    := ri.Verification.PhoneMatchSourceCount;
						ver_phn_src_id_count := ri.Verification.PhoneMatchSourceCountID;
						ver_fein_src_count   := ri.Verification.FEINMatchSourceCount;

						sbfe_name_input_mth_since_ls  := ri.SBFE.SBFENameMatchMonthsLastSeen;
						sbfe_altnm_input_mth_since_ls := ri.SBFE.SBFEAltNameMatchMonthsLastSeen;
						sbfe_addr_input_mth_since_ls  := ri.SBFE.SBFEAddrMatchMonthsLastSeen;
						sbfe_phn_input_mth_since_ls   := ri.SBFE.SBFEPhoneMatchMonthsLastSeen;
						sbfe_fein_input_mth_since_ls  := ri.SBFE.SBFEFEINMatchMonthsLastSeen;

						ver_nam   := (INTEGER)ver_name_src_count  > 0 OR (Options.useSBFE AND (INTEGER)sbfe_name_input_mth_since_ls >= 0);
						ver_altnm := (INTEGER)ver_altnm_src_count > 0 OR (Options.useSBFE AND (INTEGER)sbfe_altnm_input_mth_since_ls >= 0);
						ver_add   := (INTEGER)ver_addr_src_count  > 0 OR (Options.useSBFE AND (INTEGER)sbfe_addr_input_mth_since_ls >= 0);
						ver_phn   := (INTEGER)ver_phn_src_count   > 0 OR (Options.useSBFE AND (INTEGER)sbfe_phn_input_mth_since_ls  >= 0) OR (INTEGER)ver_phn_src_id_count > 0;
						ver_tin   := (INTEGER)ver_fein_src_count  > 0 OR (Options.useSBFE AND (INTEGER)sbfe_fein_input_mth_since_ls >= 0);

						// Since the Business Shell doesn't provide CompanyNames, Addresses, or other data, fill in 
						// these data from the original input if this product coundn't find the Business in the 
						// Business Header, but the Business Shell found it in other sources.
						_CompanyName    := TRIM( IF( ver_nam   AND TRIM(le.CompanyName)    = '', le.origCompanyName   , le.CompanyName ) );
						_AltCompanyName := TRIM( IF( ver_altnm AND TRIM(le.AltCompanyName) = '', le.origAltCompanyName, le.AltCompanyName ) );
						
						SELF.CompanyName   := _CompanyName;
						SELF.AltCompanyName:= _AltCompanyName;
						SELF.StreetAddress := IF( ver_add AND TRIM(le.StreetAddress) = ''   , le.origStreetAddress , le.StreetAddress );
						SELF.City          := IF( ver_add AND TRIM(le.City) = ''            , le.origCity          , le.City );
						SELF.State         := IF( ver_add AND TRIM(le.State) = ''           , le.origState         , le.State );
						SELF.Zip5          := IF( ver_add AND TRIM(le.Zip5) = ''            , le.origZip5          , le.Zip5 );
						SELF.FEIN          := IF( ver_tin AND TRIM(le.FEIN) = ''            , le.origFEIN          , le.FEIN );
						SELF.Phone10       := IF( ver_phn AND TRIM(le.Phone10) = ''         , le.origPhone10       , le.Phone10 );		

						SELF := le;
						SELF := [];
					END;
				
				// Add Verification data from the Business Shell results: ComapanyName, AltComapanyName, Address, FEIN, Phone.
				ds_MatchingWithShellData := 
					JOIN(
						ds_MatchingRolled, ds_Shell_Results,
						LEFT.seq = RIGHT.seq,
						xfm_AddShellData(LEFT,RIGHT),
						LEFT OUTER, KEEP(1), PARALLEL, FEW
					);
				
				// DEBUGs...:
				// OUTPUT( ds_OriginalInput, NAMED('__OriginalInput') );
				// OUTPUT( ds_BusinessHeaderSlimDeduped, NAMED('BusinessHeaderSlimDeduped') );
				// OUTPUT( ds_Matching, NAMED('Matching') );
				// OUTPUT( ds_MatchingRolled, NAMED('MatchingRolled') );
				// OUTPUT( ds_MatchingWithShellData, NAMED('MatchingWithShellData') );
				
				RETURN ds_MatchingWithShellData;
		END;