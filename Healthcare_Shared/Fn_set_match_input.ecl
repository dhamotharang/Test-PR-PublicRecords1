IMPORT healthcare_shared, Healthcare_Cleaners, Address, STD;
EXPORT Fn_set_match_input := MODULE


//Set Address
	shared layout_std_address := Healthcare_Shared.layouts_commonized.layout_std_address;
	shared layout_all_address := Healthcare_Shared.layouts_commonized.layout_all_address;
	
	// Address Extended Match info constants
	EXPORT XMI_PRIMARY_NAME_MATCH :=      		1 << 0;
	EXPORT XMI_PRIMARY_RANGE_MATCH :=     		1 << 1;
	EXPORT XMI_SECONDARY_RANGE_MATCH :=   		1 << 2;
	EXPORT XMI_SECONDARY_RANGE_CONFLICT :=   1 << 3;
	EXPORT XMI_STATE_MATCH :=         				1 << 4;
	EXPORT XMI_FIPS_MATCH :=         				1 << 5;
	EXPORT XMI_CITY_MATCH :=          				1 << 6;
	EXPORT XMI_ZIP_MATCH :=           				1 << 7;
	EXPORT XMI_ZIP4_MATCH :=          				1 << 8;
	EXPORT XMI_PRIMARY_NAME_FUZZY :=      		1 << 9;
	EXPORT XMI_PRIMARY_RANGE_FUZZY :=     		1 << 10;
	EXPORT XMI_SECONDARY_ADDR_MATCH :=    		1 << 11;
	EXPORT XMI_SECONDARY_ADDR_XMATCH :=   		1 << 12;
	EXPORT XMI_PRE_DIRECTIONAL_MATCH :=  		1 << 13;
	EXPORT XMI_POST_DIRECTIONAL_MATCH :=   	1 << 14;
	EXPORT XMI_UNIT_DESIGNATOR_MATCH  :=  		1 << 15;
	EXPORT XMI_USED_NON_DELIVERABLE_MATCH_ALG  :=  1 << 16;
	EXPORT XMI_PRIMARY_ADDR_MATCH :=  XMI_STATE_MATCH | XMI_FIPS_MATCH | XMI_CITY_MATCH | XMI_PRIMARY_NAME_MATCH | XMI_PRIMARY_RANGE_MATCH | XMI_PRE_DIRECTIONAL_MATCH | XMI_POST_DIRECTIONAL_MATCH;

	
	shared boolean isMatchAndNotEmpty(string s1, string s2) := function
		return (s1 != '' AND STD.Str.ToUpperCase(s1) = STD.Str.ToUpperCase(s2));
	end;
	shared boolean isMatchOrBothEmpty(string s1, string s2) := function
		return (STD.Str.ToUpperCase(s1) = STD.Str.ToUpperCase(s2));
	end;
	
	
	// aliases, for sanity
	shared MatchStat := Healthcare_Shared.Layouts.MatchStat;
	shared MT_FUZZY := Healthcare_Shared.Constants.MatchType.MT_FUZZY;
	
	export layout_address_match_result := record
		integer score;											// overall match score of the addresses
		integer extended_match_info;				// set of bits comprised of most the following (see Address Extended Match info constants, above)
		boolean primary_address_missing;		// one or both addresses are missing primary_address information
		boolean bad_primary_range;					// standardization reports one or both addresses have a bad primary_range for the primary_name
		boolean bad_primary_name;						// standardization reports one or both addresses have a bad primary_name
		boolean one_missing_primary_range;	// one or both missing primary_range
		boolean both_missing_primary_range;	// both missing primary range
		boolean addrkey_match;							// addrkeys matched and were non-blank
		boolean state_match;								// valid states matched
		boolean fips_match;									// valid fipscode matched
		boolean city_match;									// valid city or valid zip matched
		boolean zip_match;									// valid zip matched
		boolean zip4_match;									// valid zip4 matched 
		boolean primary_name_match;					// valid primary_name matched
		boolean pre_directional_match;			// pre_directional matched (could be blank to blank)
		boolean post_directional_match;			// post_directional matched (could be blank to blank)
		boolean unit_designator_match;			// valid unit_designator matched 
		boolean primary_range_match;				// valid primary_range matched
		MatchStat ms_primary_name;					// describes match between primary names
		integer primary_name_fuzzy_score;		// score between primary names
		boolean primary_name_fuzzy;					// primary name match considered "fuzzy"
		MatchStat ms_primary_range;					// describes match between primary ranges
		integer primary_range_fuzzy_score;	// score between primary ranges
		boolean secondary_address_match;		// valid secondary_address matched
		boolean secondary_address_xmatch;		// secondary_address matched primary_address
		boolean secondary_range_match;			// valid secondary range match (not blank)
		boolean secondary_range_conflict;		// valid secondary range conflict (both populated and not equal)
		boolean primary_range_fuzzy;				// primary range match considered "fuzzy"
		MatchStat ms;												// describes overall match between addresses
	end;
	
	//
	// MatchAddress : returns a layout_address_match_result record that contains the match results of 2 standardized addresses.
	//
	export layout_address_match_result MatchAddress(Healthcare_Shared.layouts_commonized.layout_std_address addr1, Healthcare_Shared.layouts_commonized.layout_std_address addr2) := function
		layout_address_match_result create_row := transform
				self.primary_address_missing		:= addr1.primary_address = '' OR addr2.primary_address = '';
				self.bad_primary_name 					:= addr1.error_code = 'E412' OR addr2.error_code = 'E412';
				self.bad_primary_range 					:= addr1.error_code = 'E421' OR addr2.error_code = 'E421';
				self.addrkey_match							:= isMatchAndNotEmpty(addr1.addr_key, addr2.addr_key);
				self.state_match 								:= isMatchAndNotEmpty(addr1.state, addr2.state);
				self.fips_match 								:= isMatchAndNotEmpty(addr1.fipscode, addr2.fipscode);

				// Evaluate Zip and Zip4
        // If zip matches, give credit as a city match. This helps compensate for differences in standardization of city names,
        //  like "St." vs "Saint" and "St. Louis Park" vanity vs "Minneapolis"
				self.zip_match									:= isMatchAndNotEmpty(addr1.zip, addr2.zip);
				self.city_match									:= isMatchAndNotEmpty(addr1.city, addr2.city) OR self.zip_match;
				self.zip4_match									:= self.zip_match AND IsMatchOrBothEmpty(addr1.zip4, addr2.zip4);
				
				// Don't evaluate primary address elements such as pre and post directionals if no primary address was given because otherwise
        //  we'll cause a city/state match to score differently based on whether pre/post are on the other record.
				self.primary_name_match 				:= self.primary_address_missing = false AND isMatchAndNotEmpty(addr1.primary_name, addr2.primary_name);
				self.pre_directional_match 			:= self.primary_address_missing = false AND isMatchOrBothEmpty(addr1.pre_directional, addr2.pre_directional);
				self.post_directional_match 		:= self.primary_address_missing = false AND isMatchOrBothEmpty(addr1.post_directional, addr2.post_directional);
				self.unit_designator_match 			:= self.primary_address_missing = false AND isMatchOrBothEmpty(addr1.unit_designator, addr2.unit_designator);
				self.primary_range_match 				:= self.primary_address_missing = false AND isMatchAndNotEmpty(addr1.primary_range, addr2.primary_range);
				
				// If is there something wrong with primary_name (or primary_range), we should give some credit for partial matches on primary_name.
				self.ms_primary_name 						:= Healthcare_Shared.Functions.getMatchStat(addr1.primary_name, addr2.primary_name);
				self.primary_name_fuzzy_score		:= self.ms_primary_name.score;
				self.primary_name_fuzzy					:= ((self.bad_primary_name OR self.bad_primary_range) AND self.ms_primary_name.matchtype = MT_FUZZY);
				
				// if is there something wrong with primary_range, we should give some credit for partial matches
				self.ms_primary_range 					:= Healthcare_Shared.Functions.getMatchStat(addr1.primary_range, addr2.primary_range);
				self.primary_range_fuzzy_score	:= Healthcare_Shared.Functions.getNumberScore(addr1.primary_range, addr2.primary_range);
				//primary_range_fuzzy					:= (self.ms_primary_range.matchtype = MT_FUZZY);
				
				self.secondary_address_match		:= isMatchAndNotEmpty(addr1.secondary_address, addr2.secondary_address);
				self.secondary_address_xmatch		:= isMatchAndNotEmpty(addr1.secondary_address, addr2.primary_address) OR isMatchAndNotEmpty(addr1.primary_address, addr2.secondary_address);
				
				self.secondary_range_match			:= isMatchAndNotEmpty(addr1.secondary_range, addr2.secondary_range);
				self.secondary_range_conflict		:= not self.secondary_range_match AND (addr1.secondary_range != '' AND addr2.secondary_range != '');
				
				// Some addresses can be equal even without a primary range. This can happen when there is only 1 building on primary name.
				// Example: 03666540400000028558|Dan Fox Dr Rte 7||Pittsfield|MA|01201 (also may be equivalent to "1 Dan Fox Dr Rte 7")
				self.both_missing_primary_range	:= (addr1.error_code = 'E420' AND addr2.error_code = 'E420');
				self.one_missing_primary_range	:= (addr1.error_code = 'E420' OR  addr2.error_code = 'E420');
				
				// If there is no primary range on either record and everything else matches, 
				// or there is no primary range on one record and everything else matches,
				// give credit as if match occurred.
				self.primary_range_fuzzy				:= (self.both_missing_primary_range AND self.primary_name_match AND self.city_match AND self.fips_match AND self.zip_match)
																				OR 
																			 (self.one_missing_primary_range AND self.primary_name_match AND self.city_match AND self.fips_match AND self.zip_match)
																				OR
																			 (self.primary_name_fuzzy_score>50);
				
				STATE_BONUS 												:= 30;
				FIPS_BONUS 													:= 10;
				CITY_BONUS 													:= 10;
				PRIMARY_RANGE_BONUS 								:= 25;
				BAD_PRIMARY_RANGE_BONUS 						:= 30;
				PRIMARY_NAME_BONUS 									:= 25;
				BAD_PRIMARY_NAME_BONUS 							:= 30;
				SECONDARY_TO_SECONDARY_MATCH_BONUS 	:= (PRIMARY_RANGE_BONUS + PRIMARY_NAME_BONUS);
				SECONDARY_TO_PRIMARY_MATCH_BONUS  	:= (PRIMARY_RANGE_BONUS + PRIMARY_NAME_BONUS);
				PRE_POST_DIR_MISMATCH_PENALTY  			:= 2;

				addr_score_step1 := 	if (self.state_match, 	STATE_BONUS, 0)
														+	if (self.fips_match, 	FIPS_BONUS, 0)
														+	if (self.city_match, 	CITY_BONUS, 0)
														+ if (self.primary_name_match, PRIMARY_NAME_BONUS, 0)
														+ if (self.primary_name_fuzzy, min((PRIMARY_NAME_BONUS - 4), (BAD_PRIMARY_NAME_BONUS * (self.primary_name_fuzzy_score / 100))), 0) 
														+ if (self.primary_range_match, PRIMARY_RANGE_BONUS, 0)
														+ if (self.primary_range_fuzzy, min((PRIMARY_RANGE_BONUS - 4), (BAD_PRIMARY_RANGE_BONUS * (self.primary_range_fuzzy_score / 100))), 0)
														// Reduce the score if the pre/post directional info doesn't match.
														- if (not self.post_directional_match, PRE_POST_DIR_MISMATCH_PENALTY, 0)
														- if (not self.pre_directional_match, PRE_POST_DIR_MISMATCH_PENALTY, 0);
														
				// using temp attributes for score and extended_match_info to use in create_match_stat (below)
				// keep scores in range...
				score := map (			addr_score_step1 < 0 		=> 0,
														addr_score_step1 > 100 	=> 99,
														self.addrkey_match      => 100,
														addr_score_step1); // default
				self.score := score;
				
				// set the extended match info bits by bitwise or'ing the values from the booleans.
				extended_match_info := 
															 if (self.primary_name_match, XMI_PRIMARY_NAME_MATCH, 0) |
															 if (self.primary_range_match, XMI_PRIMARY_RANGE_MATCH, 0) |
															 if (self.secondary_range_match, XMI_SECONDARY_RANGE_MATCH, 0) |
															 if (self.secondary_range_conflict, XMI_SECONDARY_RANGE_CONFLICT, 0) |
															 if (self.state_match, XMI_STATE_MATCH, 0) |
															 if (self.fips_match, XMI_FIPS_MATCH, 0) |
															 if (self.city_match, XMI_CITY_MATCH, 0) |
															 if (self.zip_match, XMI_ZIP_MATCH, 0) |
															 if (self.zip4_match, XMI_ZIP4_MATCH, 0) |
															 if (self.primary_name_fuzzy, XMI_PRIMARY_NAME_FUZZY, 0) |
															 if (self.primary_range_fuzzy, XMI_PRIMARY_RANGE_FUZZY, 0) |
															 if (self.secondary_address_match, XMI_SECONDARY_ADDR_MATCH, 0) |
															 if (self.secondary_address_xmatch, XMI_SECONDARY_ADDR_XMATCH, 0) |
															 if (self.pre_directional_match, XMI_PRE_DIRECTIONAL_MATCH, 0) |
															 if (self.post_directional_match, XMI_POST_DIRECTIONAL_MATCH, 0) |
															 if (self.unit_designator_match, XMI_UNIT_DESIGNATOR_MATCH, 0) |
															 if (self.addrkey_match, XMI_PRIMARY_ADDR_MATCH, 0); 
															 //if (used_non_deliverable_match_alg, XMI_USED_NON_DELIVERABLE_MATCH_ALG, 0);  // deprecated
															 
				self.extended_match_info := extended_match_info;
															 
				MatchStat create_match_stat := TRANSFORM
					SELF.score									:= score;
					SELF.matchType							:= map(	score = 100 	=> Healthcare_Shared.Constants.MatchType.MT_EXACT,
																							score > 0 		=> Healthcare_Shared.Constants.MatchType.MT_FUZZY,
																							Healthcare_Shared.Constants.MatchType.MT_NO_MATCH); // default
					SELF.fuzzyInfo							:= 0;
					SELF.numPossibleFatFingers	:= 0;
					SELF.extendedInfo 					:= extended_match_info; 
				end; 
				self.ms := row(create_match_stat);
		end; // end create_match_stat

		return row(create_row);
	end;
	
	export layout_address_match_result MatchCleanAddress(Healthcare_Cleaners.Layouts.cleanAddressOutput addr1, Healthcare_Shared.layouts_commonized.layout_std_address addr2) := function
		cat_clean(string s) := if (s != '', (trim(s, left, right) + ' '), '');
		Healthcare_Shared.layouts_commonized.layout_std_address createrow := transform
			self.primary_address   := cat_clean(addr1.prim_range) + cat_clean(addr1.predir) + cat_clean(addr1.prim_name) + cat_clean(addr1.addr_suffix) + cat_clean(addr1.postdir);
			self.secondary_address := addr1.sec_addr;
			self.pre_directional   := addr1.predir;
			self.primary_range     := addr1.prim_range;
			self.primary_name      := addr1.prim_name;
			self.suffix            := addr1.addr_suffix;
			self.post_directional  := addr1.postdir;			
			self.city              := addr1.p_city_name;
			self.state             := addr1.st;
			self.zip               := addr1.zip;
			self.zip4              := addr1.zip4;
			self.fipscode          := addr1.fips_state + addr1.fips_county;
			self.error_code        := addr1.err_stat;
			self.secondary_range   := addr1.sec_range;
			self.addr_key          := Healthcare_Shared.Fn_StandardizeInput.fn_make_address_key(addr1);
			self:=[];
		end;
		inputPracAddress := row(createrow);
		return MatchAddress(inputPracAddress, addr2);
	end;

	// The match function provided as a transform
	export layout_address_match_result tr_MatchAddress(layout_std_address addr1, layout_std_address addr2) := transform
		self := MatchAddress(addr1, addr2);
	end;

	
	// returns an Enclarity-type address key created from an Address.Layout_Clean_Addr_Enclarity record.
	shared STRING fn_make_address_key(Address.Layout_Clean_Addr_Enclarity stdAddr) := FUNCTION

		// If the rec_type is 'R' (rural route), isolate the RR number, then the box
		rr_num := 		if (stdAddr.rec_type = 'R',
									stringlib.StringFilter(stdAddr.prim_name, '0123456789'),	// isolate the digits
									'');
		rr_box_num := if (stdAddr.rec_type = 'R',
									stringlib.StringFilter(stdAddr.sec_range, '0123456789'),	// isolate the digits
									'');
									
		// If the rec_type is 'P' (PO BOX), isolate the box #
		pob_num := 		if (stdAddr.rec_type = 'P' and STD.Str.ToUpperCase(stdAddr.prim_name)[1..6] = 'PO BOX',
									stringlib.StringFilter(stdAddr.prim_name, '0123456789'),	// isolate the digits
									'');

		Street_address_string := TRIM( stdAddr.zip +'_'
												+ 'S' +'_'
												+ stdAddr.prim_name + '_'
												+ stdAddr.prim_range + '_'
												+ stdAddr.predir + '_'
												+ stdAddr.postdir + '_'
												+ '_'+ '_'	// used in tight addr key construction only (not used by LN).
												+ stdAddr.addr_suffix + '_'
												,ALL);
										
		RR_address_string := TRIM( stdAddr.zip + '_'
												+ 'R' + '_'
												+ rr_num + '_'
												+ rr_box_num + '_'
												,ALL);

		PO_address_string := TRIM( stdAddr.zip +'_'
												+ 'P' + '_'
												+ pob_num + '_'
												,ALL);

		isGoodPO := stdAddr.rec_type = 'P' and pob_num != '';
		isGoodRR := stdAddr.rec_type = 'R' and (rr_num != '' or rr_box_num != '');
		isGoodStreet := stdAddr.prim_name != '';

		string_to_use := if(isGoodPO, PO_address_string, if(isGoodRR, RR_address_string, if(isGoodStreet, Street_address_string, '')));

		addrstring := STD.Str.ToUpperCase(string_to_use);

		// If we have a good string to build the hash from, use it. Otherwise return blank.
		addr_key := if(addrstring != '', INTFORMAT(Healthcare_Shared.Fn_CheckSum.create_crc32_key(addrstring,LENGTH(addrstring)),10,1)+INTFORMAT(Healthcare_Shared.Fn_CheckSum.mod11(addrstring,LENGTH(addrstring)),10,1), '');

		return (STRING)addr_key;

	END;
	
	
	shared string make_primary_address_string(Address.Layout_Clean_Addr_Enclarity stdAddr) := function
			cat_clean(string s) := if (s != '', (trim(s, left, right) + ' '), '');
			return 			cat_clean(stdAddr.predir) + 
									cat_clean(stdAddr.prim_range) + 
									cat_clean(stdAddr.prim_name) + 
									cat_clean(stdAddr.addr_suffix) + 
									cat_clean(stdAddr.postdir) +
									cat_clean(stdAddr.unit_desig) + 
									cat_clean(stdAddr.sec_range) +
									//cat_clean(stdAddr.po_box_nbr) +
									cat_clean(stdAddr.rural_box_nbr) + 
									cat_clean(stdAddr.non_postal_unit_nbr);
									
	end;
	
	shared string err_stat_to_ace_stat_code(string err_stat) := function
		return if (err_stat[1] != 'E', err_stat, '');
	end;
	
	shared string err_stat_to_error_code(string err_stat) := function
		return if (err_stat[1] = 'E', err_stat, '');
	end;
	
	// to transform the layout returned by the cleaner into the provider point standardized address layout.
	EXPORT layout_std_address make_address_rec(Address.Layout_Clean_Addr_Enclarity rec, boolean missing) := transform
		self.addr_key 					:= fn_make_address_key(rec);
		self.primary_address 		:= make_primary_address_string(rec);
		self.secondary_address 	:= rec.sec_addr;
		self.city 							:= rec.p_city_name;
		self.state 							:= rec.st;
		self.zip 								:= rec.zip;
		self.zip4								:= rec.zip4;
		self.rectype						:= rec.rec_type;
		self.primary_range			:= rec.prim_range;
		self.pre_directional		:= rec.predir;
		self.primary_name				:= rec.prim_name;
		self.suffix							:= rec.addr_suffix;
		self.post_directional		:= rec.postdir;
		self.unit_designator		:= rec.unit_desig;
		self.secondary_range		:= rec.sec_range;
		self.pobox							:= rec.po_box_nbr;
		self.rrnumber						:= rec.rural_box_nbr;
		self.npsr								:= rec.non_postal_unit_nbr;
		self.ace_stat_code			:= err_stat_to_ace_stat_code(rec.err_stat); 
		self.error_code					:= err_stat_to_error_code(rec.err_stat); 
		self.fipscode						:= rec.fips_state + rec.fips_county;
		self.rdi								:= rec.rdi;
		missing_st 							:= if(missing or self.error_code = 'E502',Healthcare_Shared.Constants.stat_Missing, 0);
		notDeliverable_st       := if(not missing and self.error_code[1] = 'E' AND self.error_code <> 'E600',Healthcare_Shared.Constants.addressUndeliverable, 0);
		badFormat_st            := if(not missing and self.error_code[1] = 'E' AND self.error_code NOT IN ['E600','E605','E601'],Healthcare_Shared.Constants.stat_BadFormat, 0);
		pobox_st                := if(self.rectype[1] = 'P',Healthcare_Shared.Constants.pobox, 0);
		npsr_st                 := if(self.npsr <> '',Healthcare_Shared.Constants.npsr, 0);
		sigstd_st               := if(missing_st = 0 AND self.ace_stat_code NOT IN ['S80000','S80100','S00100','S00000','S800','S801','S001','S000'],Healthcare_Shared.Constants.significantStandardizationOccurred, 0);
//		sigstd_st               := if(missing_st = 0 AND self.ace_stat_code NOT IN ['S800','S801','S001','S000'],Healthcare_Shared.Constants.significantStandardizationOccurred, 0);
		residential_st          := if(self.rdi = 'Y',Healthcare_Shared.Constants.isResidential, 0);
		self.addr_st						:= missing_st+notDeliverable_st+badFormat_st+pobox_st+npsr_st+sigstd_st+residential_st;	
	end;
	
	export layout_all_address create_address_rec(string primary_address_in, string secondary_address_in, string city_in, string state_in, string zip_in, string zip4_in) := function
		layout_all_address create_row := transform
			address_line_1 := primary_address_in + ' ' + secondary_address_in;
			address_last_line := city_in + ' ' + state_in + ' ' + zip_in + ' ' + zip4_in;
			stdParsedAddr := Address.CleanAddressEnclarityParsed(address_line_1,address_last_line).CleanAddressRecord;
			missing := primary_address_in='' and secondary_address_in='' and city_in='' and state_in='' and zip_in='' and zip4_in='';
			self := project(stdParsedAddr, make_address_rec(left,missing));
		end;
		return row(create_row);
	end;
//Set UPIN
		export Healthcare_Shared.layouts_commonized.layout_all_upin set_UPIN(string upin_in) := function
				Healthcare_Shared.layouts_commonized.layout_all_upin create_row := transform
					self.upin 	 := Healthcare_Shared.Functions.cleanAlphaNumeric(upin_in);
					isCorrectLength := length(self.upin) = 6;
					firstChar := Healthcare_Shared.Functions.cleanAlpha(self.upin);
					isFirstAlpha := length(firstChar) = 1;
					isNumeric := length(Healthcare_Shared.Functions.cleanOnlyNumbers(self.upin[2..])) = 5;
					UpinType := Healthcare_Shared.Functions.upinPractitionerType(firstChar);
					Missing_st := IF(upin_in <>'',0,Healthcare_Shared.Constants.stat_Missing);
					badFormat_st := if(upin_in = '' OR (isCorrectLength and isFirstAlpha and isNumeric),0,Healthcare_Shared.Constants.stat_BadFormat); 
					self.upin_st := Missing_st+badFormat_st;
				end;
			return row(create_row);
		end;
//Set DEA  
		// export Healthcare_Shared.layouts_commonized.layout_all_dea set_Dea(string dea_in, string dea_num_exp_in, string dea_num_sch_in, string dea_num_bus_act_ind_in, string dea_num_deact_date_in ) := function
		export Healthcare_Shared.layouts_commonized.layout_all_dea set_Dea(string dea_in) := function
				Healthcare_Shared.layouts_commonized.layout_all_dea create_row := transform
					//DEA Validation first two positions must be chars , 1st position must be A-U, 2nd =  First Letter of last name or a 9 for buss
					//length of DEA must be 9 and the Last digit must match the checkDigit formula.
					//CheckDigit (9th position) must match the second digit in result from  (sum of digits(1,3,5) + (2*(sum of digits(2,4,6)))
					isMissing := dea_in = '';
					cln_dea := STD.Str.ToUpperCase(Healthcare_Shared.Functions.cleanAlphaNumeric(dea_in));
          dea_135_sum := (INTEGER) cln_dea[3] + (INTEGER) cln_dea[5] + (INTEGER) cln_dea[7];
          dea_246_sum := (INTEGER) cln_dea[4] + (INTEGER) cln_dea[6] + (INTEGER) cln_dea[8];
          double_246 := 2 * dea_246_sum;
          checkDigit0 := dea_135_sum + double_246;
          checkDigit := if (checkDigit0 > 9, (INTEGER) checkDigit0[2],(INTEGER) checkDigit0[1]);
          alphaPrefix1 := IF(REGEXFIND('[^A,B,C,D,E,F,G,H,J,K,L,M,N,P,R,S,T,U,W,X,Y,Z]',cln_dea[1]),FALSE,TRUE);
					alphaPrefix2 := IF(REGEXFIND('[^A-Z,9]',cln_dea[2]),FALSE,TRUE);
					alphaPrefix := IF( alphaPrefix1 and alphaPrefix2, TRUE, FALSE);
          numericSuffix := IF(REGEXFIND('[^0-9]',cln_dea[3..9]),FALSE,TRUE);
          checkDigitPass := IF((INTEGER) cln_dea[9] = checkDigit, TRUE, FALSE);
          isValidDEA := IF(LENGTH(cln_dea) = 9 AND alphaPrefix AND numericSuffix AND checkDigitPass, TRUE, FALSE);
					self.dea_num := trim(Healthcare_Shared.Functions.cleanAlphaNumeric(dea_in),left,right);
					// self.dea_num_exp := dea_num_exp_in;
					// self.dea_num_sch := dea_num_sch_in;
					// self.dea_num_bus_act_ind := dea_num_bus_act_ind_in;
					// self.dea_num_deact_date := dea_num_deact_date_in;
					self.dea_num_st := map(isMissing => Healthcare_Shared.Constants.stat_Missing,
																 NOT isValidDEA => Healthcare_Shared.Constants.stat_BadFormat,0);
				end;
				output(row(create_row),Named('set_Dea_create_row'),overwrite);
			return row(create_row);
		end;
		//Set NCPDP
		export Healthcare_Shared.layouts_commonized.layout_all_ncpdp set_NCPDP(string ncpdp_id_in) := function
				Healthcare_Shared.layouts_commonized.layout_all_ncpdp create_row := transform
					clnncpdp := trim(Healthcare_Shared.Functions.cleanAlphaNumeric(ncpdp_id_in),all);
					isCorrectLength := IF(length(clnncpdp) = 7, true, false);
					isMissing := ncpdp_id_in = '';
					isGoodFormat := isCorrectLength;
					isBadFormat  := NOT isMissing and NOT isGoodFormat;
					self.ncpdp_id := clnncpdp;
					self.ncpdp_id_st := map(isMissing => Healthcare_Shared.Constants.stat_Missing,
																	 isBadFormat => Healthcare_Shared.Constants.stat_BadFormat,0);
				end;
				// output(row(create_row),Named('set_Ncpdp_create_row'),overwrite);
			return row(create_row);
		end;
//Set Phone		
		export Healthcare_Shared.layouts_commonized.layout_all_phone set_phone(string phone_in) := function
				Healthcare_Shared.layouts_commonized.layout_all_phone create_row := transform
					self.phone 				:= Healthcare_Shared.functions.cleanAlphaNumeric(phone_in);
					self.phone_st			:= IF(phone_in = '', Healthcare_Shared.Constants.stat_Missing,0);
				end;
			return row(create_row);
		end;
//Set Fax		
		export Healthcare_Shared.layouts_commonized.layout_all_fax set_fax(string fax_in) := function
				Healthcare_Shared.layouts_commonized.layout_all_fax create_row := transform
					self.fax 				:= Healthcare_Shared.functions.cleanAlphaNumeric(fax_in);
					self.fax_st			:= IF(fax_in = '', Healthcare_Shared.Constants.stat_Missing,0);
				end;
			return row(create_row);
		end;
//Set Email		
		export Healthcare_Shared.layouts_commonized.layout_all_email set_email(string email_in) := function
				Healthcare_Shared.layouts_commonized.layout_all_email create_row := transform
					self.email_addr := email_in;
					self.email_addr_st := IF(email_in = '', Healthcare_Shared.Constants.stat_Missing,0);
				end;
			return row(create_row);
		end;
//Set web_site		
		export Healthcare_Shared.layouts_commonized.layout_all_website set_website(string web_site_in) := function
				Healthcare_Shared.layouts_commonized.layout_all_website create_row := transform
					self.web_site := web_site_in;
					self.web_site_st := IF(web_site_in = '', Healthcare_Shared.Constants.stat_Missing,0);
				end;
			return row(create_row);
		end;		
//Set TIN		
		export Healthcare_Shared.layouts_commonized.layout_all_tin set_tin(string tin_in) := function
				Missing := if(tin_in = '',Healthcare_Shared.Constants.stat_Missing,0);
				WrongLength := length(trim(tin_in,right)) != 9;
				ValidPrefix := Healthcare_Shared.Functions.isValidTINPrefix(tin_in);
				BadFormat := if(WrongLength or not ValidPrefix,Healthcare_Shared.Constants.stat_BadFormat,0);
				Healthcare_Shared.layouts_commonized.layout_all_tin create_row := transform
					self.tin := Healthcare_Shared.Functions.cleanOnlyNumbers(tin_in);
					self.tin_st := Missing+BadFormat;
				end;
			return row(create_row);
		end;		
//Set NPI		
		export Healthcare_Shared.layouts_commonized.layout_all_npi set_npi(string npi_in,string taxonomy) := function
				Healthcare_Shared.layouts_commonized.layout_all_npi create_row := transform
					isMissing := if(trim(npi_in,left,right) = '',true,false);
					clnNpi := trim(Healthcare_Shared.Functions.cleanAlphaNumeric(npi_in),left,right);
					NPILength := length(clnNPI);
					isNumeric := NOT isMissing and length(Healthcare_Shared.Functions.cleanOnlyNumbers(clnNpi)) in [10,15];
					isCorrectLength := NPILength in [0,10,15];
					isValidFirstDigit := ((NPILength = 15 and (integer)clnNPI[6] in [1,2]) or (NPILength = 10 and (integer)clnNPI[1] in [1,2]));
					isGoodPrefix:= ((NPILength = 15 and clnNPI[1..5] = '80840') or NPILength = 10);
					isGoodFormat:= isCorrectLength and isNumeric and isGoodPrefix and isValidFirstDigit;
					isBadFormat:= (NOT isMissing) and (NOT isGoodFormat);
					isValidNPI := HealthCare_Shared.Functions.fn_NPICheckSum(clnNPI); // Separate Invalid ustat based on CheckSum or CheckDigit
					self.npi_num := clnNpi;
					self.npi_drc := '';				
					self.taxonomy_mprd := taxonomy;
					self.last_update_date := '';
					self.npi_deact_date := '';
					self.npi_st := map(isMissing => Healthcare_Shared.Constants.stat_Missing,
																	 isBadFormat => Healthcare_Shared.Constants.stat_BadFormat,
																	 NOT isValidNPI => Healthcare_Shared.Constants.stat_Invalid,0);
			end;
			// output(row(create_row),Named('set_Npi_create_row'),overwrite);
			return row(create_row);
		end;	
//set Taxonomy
		export Healthcare_Shared.layouts_commonized.layout_all_taxonomy set_taxonomy(string taxonomy_in) := function
				Healthcare_Shared.layouts_commonized.layout_all_taxonomy create_row() := transform
					cln_taxonomy_in:=trim(taxonomy_in,left,right);
					self.taxonomy := Healthcare_Shared.Functions.cleanAlphaNumeric(trim(taxonomy_in,left,right));
					ui_isCorrectLength := length(cln_taxonomy_in) in[10,0];
					ui_islastAlpha := cln_taxonomy_in[10] in['X','x',''];
					ui_isInvalid := if(NOT ui_islastAlpha or NOT ui_isCorrectLength ,1,0);
					ui_taxMissing := IF(taxonomy_in <>'',0,Healthcare_Shared.Constants.stat_Missing);
					ui_taxbadFormat := if(taxonomy_in='' or(ui_isCorrectLength and ui_islastAlpha) ,0,Healthcare_Shared.Constants.stat_BadFormat); 
					self.taxonomy_primary_ind := '';
					self.taxonomyinvalid:=ui_isInvalid;
					self.taxonomy_st := ui_taxMissing+ui_taxbadFormat+ui_isInvalid;
				end;
			return row(create_row());
		end;	
//Set Name
		export Healthcare_Shared.layouts_commonized.layout_all_name set_name(string name_in) := function
				Healthcare_Shared.layouts_commonized.layout_all_name create_row := transform
					stdParsedName := Address.CleanPersonFMLEnclarityParse(name_in).CleanNameRecord;
					BOOLEAN bhasPreferredName := stdParsedName.name_prefered <> '';
					nameKeyPrefix := IF(bhasPreferredName,stdParsedName.name_prefered[1],stdParsedName.fname[1]);
					self.name_key:= nameKeyPrefix + '_' + STD.Metaphone.Primary(name_in);		
					self.full_name := TRIM(stdParsedName.name_prefix) + ' ' +
													  TRIM(stdParsedName.fname)			 + ' ' +
													  TRIM(stdParsedName.mname)			 + ' ' +
													  TRIM(stdParsedName.lname)			 + ' ' +
													  TRIM(stdParsedName.name_suffix);
					self.pre_name:= TRIM(stdParsedName.name_prefix);
					self.first_name:= TRIM(stdParsedName.fname);
					self.middle_name:= TRIM(stdParsedName.mname);
					self.last_name:= TRIM(stdParsedName.lname);
					self.maturity_suffix:= TRIM(stdParsedName.name_suffix);
					self.other_suffix:= TRIM(stdParsedName.name_prof);
					self.gender:= TRIM(stdParsedName.name_gender);
					self.preferred_name:= TRIM(stdParsedName.name_prefered);
					self.name_confidence:= (INTEGER)TRIM(stdParsedName.name_score);
					self.name_st:= if(name_in = '',Healthcare_Shared.Constants.stat_Missing, 0);
				end;
			return row(create_row);
		end;				
//Set License		
		export Healthcare_Shared.layouts_commonized.layout_all_license set_license(string lic_num_in, string lic_state_in, string lic_type_in, string prac_state) := function
				Healthcare_Shared.layouts_commonized.layout_all_license create_row := transform
					license_parsed := healthcare_shared.Functions_License.fn_parseLicense(lic_num_in, lic_state_in, lic_type_in, prac_state, true);
					self.lic_num := license_parsed[1].parsed_input_license_num;
					self.lic_state := license_parsed[1].parsed_input_license_state;
					self.lic_type := license_parsed[1].parsed_input_license_type;
					self.lic_st := if(lic_num_in = '',Healthcare_Shared.Constants.stat_Missing, 0);
				end;
			return row(create_row);
		end;
//Set CLIA		
		export Healthcare_Shared.layouts_commonized.layout_all_clia set_clia(string clia_num_in) := function
				Healthcare_Shared.layouts_commonized.layout_all_clia create_row := transform
					isMissing := clia_num_in = '';
					isCorrectLength := length(trim(clia_num_in,all)) = 10; //Length of Code is always 10 characters. Can be numbers or letters 
					hasChar := clia_num_in[3] in ['C','D','X']; //Third letter of CLIA code is always a C, D or X. 
					isGoodFormat := isCorrectLength and hasChar;
					isBadFormat := not isMissing and not isGoodFormat;
					self.clia_num := STD.Str.toUpperCase(clia_num_in);
					self.clia_status_code := '';
					self.clia_cert_type_code := '';
					self.clia_cert_eff_date := '';
					self.clia_end_date := '';
					self.clia_data_st := map(isMissing => Healthcare_Shared.Constants.stat_Missing,
																	 isBadFormat => Healthcare_Shared.Constants.stat_BadFormat,0);
				end;
			return row(create_row);
		end;
//Set Medicare		
		export Healthcare_Shared.layouts_commonized.layout_all_medicare set_medicare(string medicare_in) := function
				Healthcare_Shared.layouts_commonized.layout_all_medicare create_row := transform
					isMissing := medicare_in = '';
					isCorrectLength := length(trim(medicare_in,all)) = 6 or length(trim(medicare_in,all)) = 10;
					isBadFormat := not isCorrectLength;
					self.medicare_fac_num := Healthcare_Shared.Functions.cleanAlphaNumeric(medicare_in);
					self.medicare_fac_num_st := map(isMissing => Healthcare_Shared.Constants.stat_Missing,
																					isBadFormat => Healthcare_Shared.Constants.stat_BadFormat,0);
				end;
			return row(create_row);
		end;		
//Set Medicaid		
		export Healthcare_Shared.layouts_commonized.layout_all_medicaid set_medicaid(string medicaid_in) := function
				Healthcare_Shared.layouts_commonized.layout_all_medicaid create_row := transform
					isMissing := medicaid_in = '';
					isCorrectLength := length(medicaid_in) = 6 or length(medicaid_in) = 10;
					isBadFormat := not isCorrectLength;
					self.medicaid_fac_num := Healthcare_Shared.Functions.cleanAlphaNumeric(medicaid_in);
					self.medicaid_fac_num_st := map(isMissing => Healthcare_Shared.Constants.stat_Missing,
																					isBadFormat => Healthcare_Shared.Constants.stat_BadFormat,0);
				end;
			return row(create_row);
		end;		
//Set birthdate		
		export Healthcare_Shared.layouts_commonized.layout_all_birthdate set_birthdate(string birthdate_in) := function
				Healthcare_Shared.layouts_commonized.layout_all_birthdate create_row := transform
					isMissing := birthdate_in = '' or birthdate_in= '0';
					isCorrectLength := length(birthdate_in) = 8;
					isBadFormat := not isMissing and not isCorrectLength;
					self.birthdate := Healthcare_Shared.Functions.cleanOnlyNumbers(birthdate_in);
					self.birthdate_st := map(isMissing => Healthcare_Shared.Constants.stat_Missing,
																	 isBadFormat => Healthcare_Shared.Constants.stat_BadFormat,0);
				end;
			return row(create_row);
		end;		
//Set ssn		
		export Healthcare_Shared.layouts_commonized.layout_all_ssn set_ssn(string ssn_in) := function
				Healthcare_Shared.layouts_commonized.layout_all_ssn create_row := transform
					isMissing := ssn_in = '';
					isCorrectLength := length(ssn_in) = 9;
					isBadFormat := not isMissing and not isCorrectLength;
					self.ssn := Healthcare_Shared.Functions.cleanOnlyNumbers(ssn_in);
					self.ssn_st := map(isMissing => Healthcare_Shared.Constants.stat_Missing,
																	 isBadFormat => Healthcare_Shared.Constants.stat_BadFormat,0);
				end;
			return row(create_row);
		end;		
//Set specialty		
		export Healthcare_Shared.layouts_commonized.layout_all_specialty set_specialty(string specialty_in, string subspecialty) := function
				Healthcare_Shared.layouts_commonized.layout_all_specialty create_row := transform
					isMissing := specialty_in = '';
					isBadFormat := false;//reserved for validation function for valid specialties
					cleanSpecialty := Healthcare_Shared.Functions.convertSpecialty2Int(specialty_in,subspecialty);
					self.specialty := cleanSpecialty;
					self.specialty_st := map(isMissing => Healthcare_Shared.Constants.stat_Missing,
																	 isBadFormat => Healthcare_Shared.Constants.stat_BadFormat,0);
				end;
			return row(create_row);
		end;		
END;