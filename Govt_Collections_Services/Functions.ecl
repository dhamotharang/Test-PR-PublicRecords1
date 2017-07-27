IMPORT doxie, STD, Address, Govt_Collections_Services, ut;

EXPORT Functions := MODULE

		EXPORT fn_format_AddressLine1(Govt_Collections_Services.Layouts.batch_working rec) := 
			if( TRIM(rec.best_prim_range)  != '',       TRIM(rec.best_prim_range), '' ) + 
			if( TRIM(rec.best_predir)      != '', ' ' + TRIM(rec.best_predir), '' ) + 
			if( TRIM(rec.best_prim_name)   != '', ' ' + TRIM(rec.best_prim_name), '' ) + 
			if( TRIM(rec.best_addr_suffix) != '', ' ' + TRIM(rec.best_addr_suffix), '' ) + 
			if( TRIM(rec.best_postdir)     != '', ' ' + TRIM(rec.best_postdir), '' ); 

		EXPORT fn_format_AddressLine2(Govt_Collections_Services.Layouts.batch_working rec) := 
			if( TRIM(rec.best_unit_desig)  != '', ' ' + TRIM(rec.best_unit_desig), '' ) + 
			if( TRIM(rec.best_sec_range)   != '', ' ' + TRIM(rec.best_sec_range), '' ); 

		// The following function calculates a 	idence Score based on how the input data 
		// match the Best data. Note that, based on my question to the product manager, the
		// Confidence Score does in no way reflect how certain the system is that the entity
		// the system found is the same as the search subject. In this sense then, the Confidence
		// Score is really a match code. And what you see below in terms of Confidence Score
		// definitions is what I was told to write per the requirements. --cda
		// 
		//27 = Deceased
		//1 = All input data match
		//2 = SSN match + FN + LN match + exact city/state match + partial house/street match
		//3 = SSN match + FN + LN match + exact house/street match + different city/state
		//6 = SSN match + street/city/state/zip match + partial name match (FN or LN match)
		//9 = Expanded SSN match + FN + LN match + exact city/state match + partial house/street match
		//10 = Expanded SSN match + FN + LN match + exact house/street match + different city/state
		//11 = Expanded SSN match + FN + LN match + no street/city/state match + zip match
		//14 = Expanded SSN match  + FN + LN match + street/city/state/zip match
		//15 = FN + LN match + street/city/state/zip match + no SSN match
		//16 = FN + LN match + street/city/state match + no zip match + no SSN match
		//17 = FN + LN match + street/city/state/zip match + no input SSN
		//18 = FN + LN match + street/city/state match + no zip match + no input SSN
		//19 = Partial name match (FN or LN match) + street/city/state/zip match + no SSN match
		//20 = Partial name match (FN or LN match) + street/city/state match + no zip match + no SSN match
		//21 = Partial name match (FN or LN match) + street/city/state/zip match + no input SSN
		//22 = Partial name match (FN or LN match) + street/city/state match + no zip match + no input SSN
		//23 = SSN match + street/city/state/zip match + no FN + LN match
		//24 = SSN match + street/city/state match + no zip match + no FN + LN match
		//25 = SSN match + no street/city/state match + zip match + no FN + LN match
		//26 = SSN match + no street/city/state/zip match + no FN + LN match
		//31 = SSN match + *historical address match + full or partial name match
		//4 = SSN match + FN + LN match + no street/city/state match + zip match
		//5 = SSN match + FN + LN match + no street/city/state/zip match
		//7 = SSN match + LN match + no FN match + no street/city/zip match + state match
		//8 = SSN/FN match + no LN match + no street/city/state/zip match
		//33 = Expanded SSN match + street/city/state/zip match + full or partial name match
		//32 = Expanded SSN match + *historical address match + full or partial name match
		//12 = Expanded SSN match + FN + LN match + no street/city/state/zip match
		//13 = Expanded SSN match + LN match + no FN match + no street/city/zip match + state match
		//29 = FN + LN match + no street/city/state/zip match + no SSN match
		//30 = Partial name match (FN or LN match) + no street/city/state/zip match + no SSN match
		//34 = Expanded SSN match + street/city/state/zip match + no FN + LN match 
		//35 = Street/city/state/zip match + no SSN match + no FN + LN match
		//36 = No LexID appended
		//37 = FN variation match + LN match + no street/city/state/zip match + no Best SSN
		//38 = FN variation match  + LN match + no street match + city/state/zip match + no Best SSN
		//39 = LN + FN match + no street/city/state/zip match + invalid Input SSN
		//40 = LN + FN match + no street match + city/state/zip match + invalid Input SSN
		//28 = Unresolved (no input data matched)
		//
		EXPORT fn_get_conf_scores(Govt_Collections_Services.Layouts.batch_in input, 
															Govt_Collections_Services.Layouts.batch_working matching ) :=
			FUNCTION

				// sometimes input address isn't parsed correctly leaving prime range or predir as part of prim name, 
				// so we will build alt street address from parts and compare for matching of house/street as well
				STRING100 alt_best_str_addr   := Address.Addr1FromComponents(matching.best_prim_range,matching.best_predir,matching.best_prim_name,matching.best_addr_suffix,matching.best_postdir,'',matching.best_sec_range);
				STRING100 alt_input_str_addr  := Address.Addr1FromComponents(input.prim_range,input.predir,input.prim_name,input.addr_suffix,input.postdir,'',input.sec_range);
				BOOLEAN is_alt_str_addr_match := STD.Str.CleanSpaces(alt_best_str_addr) = STD.Str.CleanSpaces(alt_input_str_addr);

				STRING100 best_str_addr   := matching.best_prim_range+' '+matching.best_prim_name+' '+matching.best_sec_range;
				STRING100 input_str_addr  := input.prim_range+' '+input.prim_name+' '+input.sec_range;
				BOOLEAN is_str_addr_match := STD.Str.CleanSpaces(best_str_addr) = STD.Str.CleanSpaces(input_str_addr);

				// Basic boolean evaluation.
				BOOLEAN is_last4_ssn_match := LENGTH(TRIM(input.ssn)) = 4 AND input.ssn = matching.best_ssn[6..9];
				BOOLEAN exists_best_ssn		 := matching.best_ssn != '';
				BOOLEAN is_ssn_match       := LENGTH(TRIM(input.ssn)) = 9 AND input.ssn = matching.best_ssn;
				
				BOOLEAN is_expnd_ssn_match := matching.expanded_ssn != '' AND matching.expanded_ssn = matching.best_ssn;
				BOOLEAN exists_input_ssn   := input.ssn != '';
				BOOLEAN no_ssn_match       := exists_input_ssn AND LENGTH(TRIM(input.ssn)) = 9 AND NOT input.ssn = matching.best_ssn;
			
				BOOLEAN is_fname_match     := STD.Str.CleanSpaces(input.name_first) = STD.Str.CleanSpaces(matching.best_fname);
				BOOLEAN is_lname_match     := STD.Str.CleanSpaces(input.name_last) = STD.Str.CleanSpaces(matching.best_lname);
				
				BOOLEAN is_fuzzy_fname_match := matching.is_fuzzy_fname_match;																 
				BOOLEAN is_fuzzy_lname_match := matching.is_fuzzy_lname_match;
				BOOLEAN is_fuzzy_full_name_match := matching.is_fuzzy_full_name_match;
																														 
				INTEGER ssn_length := LENGTH(input.ssn);
				BOOLEAN is_valid_ssn := NOT exists_input_ssn OR ssn_length = 4 OR 
																	(ssn_length = 9 AND 
																	NOT(INTEGER)input.ssn IN doxie.bad_ssn_list AND 
																	ut.GetSSNValidation(input.ssn).is_valid);
																
				BOOLEAN exists_lex_id			 := matching.lex_id <> '';
				BOOLEAN is_hist_addr_match := matching.input_is_hist_addr;
				BOOLEAN is_input_addr_match := matching.input_is_best_addr;
				BOOLEAN is_house_match     := STD.Str.CleanSpaces(input.prim_range) = STD.Str.CleanSpaces(matching.best_prim_range);
				BOOLEAN is_street_match    := STD.Str.CleanSpaces(input.prim_name) = STD.Str.CleanSpaces(matching.best_prim_name);
				BOOLEAN is_city_match      := STD.Str.CleanSpaces(input.p_city_name) = STD.Str.CleanSpaces(matching.best_city) AND matching.best_city != '';
				BOOLEAN is_state_match     := input.st = matching.best_st AND matching.best_st != '';
				BOOLEAN is_zip_match       := input.z5 = matching.best_z5;
				BOOLEAN is_deceased        := matching.deceased_indicator = 'Y';
				
				BOOLEAN is_partial_house_match := LENGTH(TRIM(input.prim_range))=LENGTH(TRIM(matching.best_prim_range)) 
				                                  AND StringLib.EditDistance(input.prim_range,matching.best_prim_range)=1;

				// Compound boolean expressions.
				
				// ...names:
				BOOLEAN is_fname_lname_match := is_fname_match AND is_lname_match;
				BOOLEAN is_partial_name_match := is_fname_match OR is_lname_match;
				BOOLEAN is_partial_fuzzy_name_match := is_fuzzy_fname_match OR is_fuzzy_lname_match;

				// ...street addresses:
				BOOLEAN is_partial_house_street_match := is_partial_house_match AND is_street_match;
				BOOLEAN is_house_street_match := (is_house_match AND is_street_match) OR is_alt_str_addr_match;
				
				// ...city and state; and full address:
				BOOLEAN is_city_state_match := is_city_match AND is_state_match; 
				BOOLEAN is_city_state_zip_match := is_city_state_match AND is_zip_match;
				// confirmed with product manager and market planner that different city/state should be implemented as follows:
				BOOLEAN is_different_city_state := NOT is_city_match AND NOT is_state_match;
				
				BOOLEAN is_street_city_state_match := is_city_state_match AND (is_street_match OR is_alt_str_addr_match);
				BOOLEAN no_street_city_state_match := NOT is_street_match OR NOT is_city_match OR NOT is_state_match;
				BOOLEAN no_street_city_state_zip_match := NOT is_street_match OR NOT is_city_match OR NOT is_state_match OR (input.z5 != '' AND NOT is_zip_match);
				
				BOOLEAN not_street_city_state_zip_match := NOT is_street_match AND NOT is_city_match AND 
																									 NOT is_state_match AND 
																									 (input.z5 != '' AND NOT is_zip_match);
				
				// More lengthy compound expressions:
				BOOLEAN is_expssn_fname_lname_match := 
						is_expnd_ssn_match AND is_fuzzy_full_name_match;
				
				BOOLEAN is_ssn_fname_lname_match := 
						is_ssn_match AND is_fuzzy_full_name_match;
				
				BOOLEAN is_expssn_street_city_state_zip_match := 
						is_expnd_ssn_match AND is_street_city_state_match AND is_zip_match;
				
				BOOLEAN is_ssn_street_city_state_zip_match := 
						is_ssn_match AND is_street_city_state_match AND is_zip_match;
				
				BOOLEAN is_fname_lname_street_city_state_match := 
						is_fuzzy_full_name_match AND is_street_city_state_match;
				
				BOOLEAN is_fname_lname_street_city_state_zip_match := 
						is_fuzzy_full_name_match AND is_street_city_state_match AND is_zip_match;
				
				BOOLEAN is_all_input_data_match := 
						is_ssn_match AND is_fname_lname_match AND is_city_state_match AND is_zip_match 
						AND (is_str_addr_match OR is_alt_str_addr_match); 
				
				// --------------------[ Now determine confidence scores. ]---------------------
				
				BOOLEAN is_conf_score_1 := is_all_input_data_match;
						
				BOOLEAN is_conf_score_2 := 
						is_ssn_fname_lname_match AND is_city_state_match AND is_partial_house_street_match;
						
				BOOLEAN is_conf_score_3 := 
						is_ssn_fname_lname_match AND is_house_street_match AND is_different_city_state;
						
				BOOLEAN is_conf_score_4 := 
						is_ssn_fname_lname_match AND no_street_city_state_match AND is_zip_match;
				
				BOOLEAN is_conf_score_5 := 
						is_ssn_fname_lname_match AND no_street_city_state_zip_match AND NOT is_input_addr_match;
						
				BOOLEAN is_conf_score_6 := 
						is_ssn_street_city_state_zip_match AND is_partial_name_match;
				
				BOOLEAN is_conf_score_7 := 
						is_ssn_match AND is_lname_match AND is_state_match 
						AND (NOT (is_fname_match OR is_street_match OR is_city_match OR is_zip_match));
						
				BOOLEAN is_conf_score_8 := 
						is_ssn_match AND is_fname_match AND NOT is_lname_match AND no_street_city_state_zip_match;
						
				BOOLEAN is_conf_score_9 := 
						is_expssn_fname_lname_match AND is_city_state_match AND is_partial_house_street_match;
				
				BOOLEAN is_conf_score_10 := 
						is_expssn_fname_lname_match AND is_house_match AND is_street_match AND is_different_city_state;
				
				BOOLEAN is_conf_score_11 := 
						is_expssn_fname_lname_match AND is_zip_match AND no_street_city_state_match;
				
				BOOLEAN is_conf_score_12 := 
						is_expssn_fname_lname_match AND no_street_city_state_zip_match AND NOT is_input_addr_match;
				
				BOOLEAN is_conf_score_13 := 
						is_state_match AND is_expnd_ssn_match AND is_fuzzy_lname_match AND NOT is_fuzzy_fname_match AND NOT (is_street_match OR is_city_match OR is_zip_match);
				
				BOOLEAN is_conf_score_14 := 
						is_expssn_street_city_state_zip_match AND is_fuzzy_full_name_match;
				
				BOOLEAN is_conf_score_15 := 
						is_fname_lname_street_city_state_zip_match AND no_ssn_match;
						
				BOOLEAN is_conf_score_16 := 
						is_fname_lname_street_city_state_match AND (NOT is_zip_match) AND no_ssn_match;
						
				BOOLEAN is_conf_score_17 := 
						is_fname_lname_street_city_state_zip_match AND (NOT exists_input_ssn);
						
				BOOLEAN is_conf_score_18 := 
						is_fname_lname_street_city_state_match AND (NOT is_zip_match) AND (NOT exists_input_ssn);
						
				BOOLEAN is_conf_score_19 := 
						is_street_city_state_match AND is_zip_match AND is_partial_name_match AND no_ssn_match;
						
				BOOLEAN is_conf_score_20 := 
						is_street_city_state_match AND NOT is_zip_match AND is_partial_name_match AND no_ssn_match;
						
				BOOLEAN is_conf_score_21 := 
						is_street_city_state_match AND is_zip_match AND is_partial_name_match AND NOT exists_input_ssn;
						
				BOOLEAN is_conf_score_22 := 
						is_street_city_state_match AND NOT is_zip_match AND is_partial_name_match AND NOT exists_input_ssn;
						
				BOOLEAN is_conf_score_23 := 
						is_ssn_street_city_state_zip_match AND NOT is_partial_name_match;
				
				BOOLEAN is_conf_score_24 := 
						is_ssn_match AND is_street_city_state_match AND NOT is_zip_match AND NOT is_partial_name_match;
						
				BOOLEAN is_conf_score_25 := 
						is_ssn_match AND is_zip_match AND no_street_city_state_match AND NOT is_partial_name_match;
						
				BOOLEAN is_conf_score_26 := 
						is_ssn_match AND NOT is_partial_name_match AND no_street_city_state_zip_match AND NOT is_input_addr_match;
						
				BOOLEAN is_conf_score_27 := is_deceased; 
				
				BOOLEAN is_conf_score_28 := 
						NOT( is_ssn_match OR is_last4_ssn_match OR is_fname_lname_match OR is_input_addr_match);
				
				BOOLEAN is_conf_score_29 := 
						is_fuzzy_full_name_match AND no_ssn_match AND no_street_city_state_zip_match AND NOT is_input_addr_match;
						
				BOOLEAN is_conf_score_30 := 
						is_partial_name_match AND no_ssn_match AND no_street_city_state_zip_match;
						
				BOOLEAN is_conf_score_31 := 
						is_partial_name_match AND is_ssn_match AND is_hist_addr_match;
						
				BOOLEAN is_conf_score_32 := 
						is_partial_name_match AND is_expnd_ssn_match AND is_hist_addr_match;
						
				BOOLEAN is_conf_score_33 := 
						is_expssn_street_city_state_zip_match AND is_partial_name_match;
				
				BOOLEAN is_conf_score_34 := 
						is_expssn_street_city_state_zip_match AND NOT is_partial_fuzzy_name_match;
				
				BOOLEAN is_conf_score_35 := 
						is_street_city_state_match AND is_zip_match AND NOT is_partial_name_match AND no_ssn_match;
				
				BOOLEAN is_conf_score_36 := NOT exists_lex_id;
				
				BOOLEAN is_conf_score_37 := 
						is_fuzzy_full_name_match AND not_street_city_state_zip_match AND NOT exists_best_ssn;
						
				BOOLEAN is_conf_score_38 := 
						  is_fuzzy_full_name_match AND NOT is_street_match AND is_city_state_zip_match AND NOT exists_best_ssn;
					
				BOOLEAN is_conf_score_39 := 
						is_fuzzy_full_name_match AND not_street_city_state_zip_match AND NOT is_valid_ssn;
						
				BOOLEAN is_conf_score_40 := 
						NOT is_valid_ssn AND is_fuzzy_full_name_match AND NOT is_street_match AND is_city_state_zip_match;
						
				conf_score :=
					MAP(
						is_conf_score_27 => '27', // Deceased overrides everything else.
						is_conf_score_1  => '1',
						is_conf_score_2  => '2',
						is_conf_score_3  => '3',
						is_conf_score_6  => '6',
						is_conf_score_9  => '9',
						is_conf_score_10 => '10',
						is_conf_score_11 => '11',
						is_conf_score_14 => '14',
						is_conf_score_15 => '15',
						is_conf_score_16 => '16',
						is_conf_score_17 => '17',
						is_conf_score_18 => '18',
						is_conf_score_19 => '19',
						is_conf_score_20 => '20',
						is_conf_score_21 => '21',
						is_conf_score_22 => '22',
						is_conf_score_23 => '23',
						is_conf_score_24 => '24',
						is_conf_score_25 => '25',
						is_conf_score_26 => '26',
						is_conf_score_31 => '31',  // ssn&name + historical address match
						is_conf_score_4  => '4',   // ssn&name&zip + no address match
						is_conf_score_5  => '5',   // ssn&name + no address match
						is_conf_score_7  => '7',
						is_conf_score_8  => '8',
						is_conf_score_33 => '33',  // exp ssn + address match
						is_conf_score_32 => '32',  // exp ssn + historical address match
						is_conf_score_12 => '12',  // exp ssn + no address match
						is_conf_score_13 => '13',  // exp ssn&st + no address match
						is_conf_score_29 => '29', // 30 & 31 should be checked after 33 otherwise 33 will never be assigned
						is_conf_score_30 => '30',  
						is_conf_score_34 => '34',
						is_conf_score_35 => '35',
						is_conf_score_36 => '36',
						is_conf_score_37 => '37',
						is_conf_score_38 => '38',
						is_conf_score_39 => '39',
						is_conf_score_40 => '40',
						is_conf_score_28 => '28',
						/* default.....*/   '' 
					);
							
				RETURN conf_score;
			END;

		///////////////////////////////////////////////////////////////////////////////////////////
		//Return Confidence Score description.
		//
		//Score 1 maps to the â€œAll input data matchâ€ group.
		//Scores 2-5 map to the â€œSSN match + full name match + partial address matchâ€ group.
		//Scores 6-7 map to the â€œSSN match + partial name match + partial address matchâ€ group.
		//Score 8 maps to the â€œSSN/FN match + no LN match + no street/city/state/zip matchâ€ group.
		//Scores 9-14, 33 and 34 map to the â€œExpanded SSN matchâ€ group.
		//Scores 15-18 map to the â€œFull name match + full address match + partial or no SSN matchâ€ group.
		//Scores 19-22 and Score 35 map to the â€œPartial name match + full address match + partial or no SSN matchâ€ group.
		//Scores 23-26 map to the â€œSSN match + partial address match + no full name matchâ€ group.
		//Score 27 maps to the â€œDeceasedâ€ group.
		//Scores 28 and 36 map to the â€œUnresolved (no input data matched)â€ group.
		//Scores 29 and 30 map to the â€œName matchâ€ group.
		//Scores 31 and 32 map to the â€œHistorical address matchâ€ group.
		//Scores 37 and 38 will map to the â€œFN variation match + LN match + partial address match + no Best SSNâ€ group.
		//Scores 39 and 40 will map to the â€œFull name match + partial address match + invalid Input SSNâ€ group.
		//Score 41 will map to the â€œSSN matchâ€ group.
		///////////////////////////////////////////////////////////////////////////////////////////
		EXPORT fn_get_conf_score_desc(STRING2 conf_score) := 
				MAP(conf_score = '1'  => 'All input data match',
						conf_score in ['2','3','4','5'] => 'SSN match + full name match + partial address match',
						conf_score in ['6','7'] => 'SSN match + partial name match + partial address match',
						conf_score = '8' => 'SSN/FN match + no LN match + no street/city/state/zip match.',
						conf_score in ['9','10','11','12','13','14','33','34'] => 'Expanded SSN match.',
						conf_score in ['15','16','17','18'] => 'Full name match + full address match + partial or no SSN match',
						conf_score in ['19','20','21','22','35'] => 'Partial name match + full address match + partial or no SSN match',
						conf_score in ['23','24','25','26'] => 'SSN match + partial address match + no full name match',
						conf_score = '27' => 'Deceased',
						conf_score in ['28', '36'] => 'Unresolved (no input data matched)',
						conf_score in ['29','30'] => 'Name match',
						conf_score in ['31','32'] => 'Historical address match.',
						conf_score in ['37', '38'] => 'FN/Nickname match + LN match + partial address match + no Best SSN',
						conf_score in ['39', '40'] => 'Full Name match + partial address match + invalid Input SSN',
					/* default... => */ ''
				);
END;