IMPORT Autokey_batch, AutoHeaderI, AutoStandardI, Doxie, LN_PropertyV2_Services, uccv2_services,  
       prof_LicenseV2_Services, Prof_License, Address, doxie_raw, ut, NID, BatchServices, fcra, LN_PropertyV2,
       AutoHeaderV2, STD;

SSN_LABEL 				:= PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_SSN.full, opt);
ADDRESS_LABEL 		:= PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Addr.full, opt);
FULLNAME_LABEL(boolean isFCRA = false) 		:= PROJECT(AutoStandardI.GlobalModule(isFCRA), AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt);
COMPANYNAME_LABEL := PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt);

ADDRESS_ACCEPTABLE_THRESHOLD  := 4;
LASTNAME_ACCEPTABLE_THRESHOLD := 5;
FULLNAME_ACCEPTABLE_THRESHOLD := 5;
NONBLANK_BOGUS_VALUE        := 'XXXXXX';


EXPORT Functions := MODULE

	shared tmp_penalt_layout := record
				    unsigned2 penalt;
	end;
	
	SHARED tmp_int_layout := RECORD
		UNSIGNED2 val := 0;
	END;
	// ***** General purpose, numeric formatting functions for batch services. *****
	
	// strip decimal values and any sort of punction. 
	// To be used for searching loan amout index for Property DZLD service.
	EXPORT  fn_strip_loan_amt(string amt) := function
			cleaned := (integer)stringlib.stringfilter(amt,'0123456789.');
		RETURN (String)cleaned;
	END;
	
	// strip any sort of punction. 
	EXPORT  fn_no_punct(string val) := function
			cleaned := stringlib.stringfilter(val,'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');
		RETURN cleaned;
	END;
	
	SHARED insert_comma(STRING amount, INTEGER pos) :=
		FUNCTION
			RETURN IF( LENGTH(amount) <= pos,
								 amount,
								 amount[ 1..LENGTH(amount)-pos ] + ',' + amount[ LENGTH(amount)-(pos-1)..LENGTH(amount) ]
								);
		END;
		
	// The following function accepts a numeric value as the input parameter (e.g. '455271', '187.53') and
	// converts it into a formatted currency value (e.g. '$455,271.00', '$187.53', respectively).
	EXPORT convert_to_currency(STRING amount) := 
		FUNCTION
			
			THOUSANDS := 6;     MILLIONS := 10;     BILLIONS := 14;
			
			trimmed_amount := TRIM(amount,LEFT,RIGHT);
			
			amt := IF( StringLib.StringFindCount(trimmed_amount, '.') >= 1,
								 trimmed_amount,
								 trimmed_amount + '.00'
								);

			RETURN IF( trimmed_amount = '',
			           '',
			           '$' + insert_comma(insert_comma(insert_comma(amt,THOUSANDS),MILLIONS),BILLIONS)
			          );			
		END;
	
	// The following function accepts a numeric value as the input parameter (e.g. '455271', '18753') 
	// as cents and converts it into a formatted currency value (e.g. '$4,552.71', '$187.53', respectively).
	EXPORT convert_cents_to_currency(STRING amount) := 
		FUNCTION
			
			THOUSANDS := 6;     MILLIONS := 10;     BILLIONS := 14;
			
			trimmed_amount := TRIM(amount,LEFT,RIGHT);
			
			amt := trimmed_amount[1..(LENGTH(trimmed_amount)-2)] + '.' + trimmed_amount[(LENGTH(trimmed_amount)-1)..LENGTH(trimmed_amount)];

			RETURN IF( trimmed_amount = '',
			           '',
			           '$' + insert_comma(insert_comma(insert_comma(amt,THOUSANDS),MILLIONS),BILLIONS)
			          );			
		END;
		
	EXPORT convert_to_rate(STRING rate) := 
		FUNCTION
		
			trimmed_rate := TRIM(rate);
			
			RETURN IF( trimmed_rate = '',
			           '',
			           CASE( StringLib.StringFindCount(trimmed_rate, '.'), 
			                         0 => trimmed_rate[ 1..LENGTH(trimmed_rate)-2 ] + '.' + trimmed_rate[ LENGTH(trimmed_rate)-1..LENGTH(trimmed_rate) ] + '%', // insert both decimal and '%'
			                         1 => trimmed_rate + '%',
			                 /* ELSE */   trimmed_rate       // invalid rate; do nothing to format it.
			                 )
			          );
		END;
	
	// ***** Other general purpose functions for batch services. *****
	
	SHARED fn_GetDids(Autokey_batch.Layouts.rec_inBatchMaster le, 
										unsigned2 did_limit = 100, 
										AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full args = project(AutoStandardI.GlobalModule(), AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full, opt)) := FUNCTION
			tempdmod := MODULE(PROJECT(args, AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full, opt))
				EXPORT lastname           := le.name_last;  
				EXPORT firstname          := le.name_first; 
				EXPORT prim_name          := le.prim_name;
				EXPORT prim_range         := le.prim_range;
				EXPORT addr_suffix        := le.addr_suffix;
				EXPORT city               := le.p_city_name;
				EXPORT state              := le.st;
				EXPORT zip                := le.z5;				
				EXPORT ssn                := le.ssn;
				EXPORT fein               := le.fein;
				EXPORT dob                := (UNSIGNED8)le.dob;
				EXPORT useGlobalScope     := FALSE;
				EXPORT BOOLEAN forceLocal := TRUE;
				EXPORT BOOLEAN noFail     := TRUE;
				EXPORT did      					:= if(le.did<>0,(string) le.did,'');

        // .reference is the same as .do minus [pruning, filter minors, household]
        export boolean household := false;
        // export boolean IncludeMinors := args.IncludeMinors; // this is particularly questionable

// I'm not comfortable with this, but it is backward compatible
        export boolean IncludeMinors := true;

        export boolean KeepOldSsns := true;
			END;

			// Note: AutoHeaderI/LIBCALL_FetchI_Hdr_Indv/do method is impossible to implement now due to the compile-
			// time error on the keyword 'skip'. Instead, we'll invoke 'references', which will perform a DID lookup
			// on the person him-herself, but not on the household. We'll switch back to the 'do' method when Gavin 
			// fixes the problem with 'skip'. See bug #32760.
			// RETURN CHOOSEN(AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.references(tempdmod),did_limit);

      ds_search := AutoHeaderV2.LIBCALL_conversions.GetPreprocessedInputDataset (tempdmod);
      // library wrapper call
      dids := AutoHeaderV2.get_dids (ds_search, AutoHeaderV2.Constants.SearchCode.NOFAIL);
      return choosen (project (dids,doxie.layout_references), did_limit);
	END;
	// Obtain a set of dids for each batch input record. Return only acctno and did. ( 1 acctno --> M dids )
	EXPORT fn_find_dids_and_append_to_acctno( DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ak_input = DATASET([],Autokey_batch.Layouts.rec_inBatchMaster),
	                                          unsigned2 in_did_limit = 100) := FUNCTION
			
			// .. Attach a dataset of dids to input record.
			rec_inBatchMaster_plus_DIDs := RECORD
				Autokey_batch.Layouts.rec_inBatchMaster;
				DATASET(doxie.layout_references) dids{MAXCOUNT(100)};
			END;
				
			// .. Use LIBCALL_FetchI_Hdr_Indv to grab DIDs.
			rec_inBatchMaster_plus_DIDs xfm_DeepDiveForDids(Autokey_batch.Layouts.rec_inBatchMaster le) := 
				TRANSFORM				
					SELF.dids := fn_GetDids(le, in_did_limit);	
					SELF      := le;
				END;
			
			ds_input_with_DIDs := PROJECT(ak_input, xfm_DeepDiveForDids(LEFT));
			
			// .. Normalize the dids dataset returned with each acctno to individual dids.
			doxie.layout_references_acctno xfm_normalize_dids(rec_inBatchMaster_plus_DIDs l, doxie.layout_references r) := 
				TRANSFORM
					SELF.acctno := l.acctno;
					SELF.did    := r.did;
					SELF        := [];
				END;
			
			ds_normalized_dids := NORMALIZE(ds_input_with_DIDs, LEFT.dids, xfm_normalize_dids(LEFT,RIGHT));

			ds_normalized_dids_ddpd := DEDUP(SORT(ds_normalized_dids, acctno, did), acctno, did);
			
			RETURN ds_normalized_dids_ddpd;

	END;
	
	EXPORT fn_GetBdids(Autokey_batch.Layouts.rec_inBatchMaster le) := FUNCTION
			tempdmod := MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full, opt))
				EXPORT companyname        := le.comp_name; 
				EXPORT prim_name          := le.prim_name;
				EXPORT prim_range         := le.prim_range;
				EXPORT addr_suffix        := le.addr_suffix;
				EXPORT addr								:= StringLib.StringCleanSpaces(
																		le.prim_range + ' ' +
																		le.predir + ' ' +
																		le.prim_name + ' ' +
																		le.addr_suffix + ' ' +
																		le.postdir + ' ' +
																		le.sec_range);
				EXPORT city               := le.p_city_name;
				EXPORT state              := le.st;
				EXPORT zip                := le.z5;				
				EXPORT fein               := le.fein;
				EXPORT useGlobalScope     := FALSE;
				EXPORT BOOLEAN forceLocal := TRUE;
				EXPORT BOOLEAN noFail     := TRUE;
			END;

			RETURN choosen(AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(tempdmod), 100);
	END;
	
	// Obtain a set of dids for each batch input record. Return only acctno and did. ( 1 acctno --> M dids )
	EXPORT fn_find_bdids_and_append_to_acctno( DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ak_input = DATASET([],Autokey_batch.Layouts.rec_inBatchMaster),
	                                            unsigned2 in_bdid_limit = 100) := FUNCTION
			
			// .. Attach a dataset of dids to input record.
			rec_inBatchMaster_plus_BDIDs := RECORD
				Autokey_batch.Layouts.rec_inBatchMaster;
				DATASET(doxie.Layout_ref_bdid) bdids{MAXCOUNT(100)};
			END;
				
			// .. Use LIBCALL_FetchI_Hdr_Indv to grab DIDs.
			rec_inBatchMaster_plus_BDIDs xfm_DeepDiveForBdids(Autokey_batch.Layouts.rec_inBatchMaster le) := 
				TRANSFORM				
					SELF.bdids := fn_GetBdids(le);	
					SELF       := le;
				END;
			
			ds_input_with_BDIDs := PROJECT(ak_input, xfm_DeepDiveForBdids(LEFT));
			
			// .. Normalize the dids dataset returned with each acctno to individual dids.
			layout_ref_bdid_acctno := RECORD
				STRING20 acctno := '';
				doxie.Layout_ref_bdid;
			END;
			
			layout_ref_bdid_acctno xfm_normalize_bdids(rec_inBatchMaster_plus_BDIDs l, doxie.Layout_ref_bdid r) := 
				TRANSFORM
					SELF.acctno := l.acctno;
					SELF.bdid   := r.bdid;
				END;
			
			ds_normalized_bdids := NORMALIZE(ds_input_with_BDIDs, LEFT.bdids, xfm_normalize_bdids(LEFT,RIGHT));

			ds_normalized_bdids_ddpd := DEDUP(SORT(ds_normalized_bdids, acctno, bdid), acctno, bdid);
			
			RETURN ds_normalized_bdids_ddpd;

	END;
	
	EXPORT match_code_result(BOOLEAN MatchName, BOOLEAN MatchStreetAddress,
                                     BOOLEAN MatchCity, BOOLEAN MatchState,
																		 BOOLEAN MatchZip, BOOLEAN MatchSSN,
																		 BOOLEAN MatchDOB, BOOLEAN MatchDID) := FUNCTION
			STRING BLNK := '';
			STRING1 STR_MATCH_NAME := 'N';
			STRING1 STR_MATCH_STREET_ADDRESS := 'A';
			STRING1 STR_MATCH_CITY := 'C';
			STRING1 STR_MATCH_STATE := 'T';
			STRING1 STR_MATCH_ZIP := 'Z';
			STRING1 STR_MATCH_SSN := 'S';
			STRING1 STR_MATCH_DOB := 'D';
			STRING1 STR_MATCH_DID := 'L';

			UNSIGNED2 V_MATCH_NAME  := 1 << 1;
			UNSIGNED2 V_MATCH_STREET_ADDRESS :=  1 << 2;
			UNSIGNED2 V_MATCH_CITY  := 1 << 3;
			UNSIGNED2 V_MATCH_STATE := 1 << 4;
			UNSIGNED2 V_MATCH_ZIP   := 1 << 5;
			UNSIGNED2 V_MATCH_SSN   := 1 << 6;
			UNSIGNED2 V_MATCH_DOB   := 1 << 7;
			UNSIGNED2 V_MATCH_DID   := 1 << 8;

			getMatchVal(BOOLEAN isMatch, UNSIGNED2 matchVal) := IF (isMatch, matchVal, 0);

			
			nameMatchVal(BOOLEAN isMatch) := getMatchVal(isMatch, V_MATCH_NAME);
			addrMatchVal(BOOLEAN isMatch) := getMatchVal(isMatch, V_MATCH_STREET_ADDRESS);
			cityMatchVal(BOOLEAN isMatch) := getMatchVal(isMatch, V_MATCH_CITY);
			stateMatchVal(BOOLEAN isMatch):= getMatchVal(isMatch, V_MATCH_STATE);
			zipMatchVal(BOOLEAN isMatch)  := getMatchVal(isMatch, V_MATCH_ZIP);
			ssnMatchVal(BOOLEAN isMatch)  := getMatchVal(isMatch, V_MATCH_SSN);
			dobMatchVal(BOOLEAN isMatch)  := getMatchVal(isMatch, V_MATCH_DOB);
			didMatchVal(BOOLEAN isMatch)  := getMatchVal(isMatch, V_MATCH_DID);
									 
		unsigned2 result(boolean MatchName, boolean MatchStreetAddress,
                                     boolean MatchCity, boolean MatchState,
																		 boolean MatchZip, boolean MatchSSN,
																		 boolean MatchDOB, boolean MatchDID)
							:= 	nameMatchVal(MatchName) + addrMatchVal(MatchStreetAddress) +
							    cityMatchVal(MatchCity) + stateMatchVal(MatchState) +
									zipMatchVal(MatchZip)   + ssnMatchVal(MatchSSN) + 			 
									dobMatchVal(MatchDOB)   + didMatchVal(MatchDID);

			getMatchStr(UNSIGNED2 flags)
		:= IF(flags & V_MATCH_NAME <> 0, STR_MATCH_NAME, BLNK) +
			 IF(flags & V_MATCH_STREET_ADDRESS <> 0, STR_MATCH_STREET_ADDRESS, BLNK) +
			 IF(flags & V_MATCH_CITY <> 0, STR_MATCH_CITY, BLNK) +
			 IF(flags & V_MATCH_STATE <> 0, STR_MATCH_STATE, BLNK) +
			 IF(flags & V_MATCH_ZIP <> 0, STR_MATCH_ZIP, BLNK) +
			 IF(flags & V_MATCH_SSN <> 0, STR_MATCH_SSN, BLNK) +
			 IF(flags & V_MATCH_DOB <> 0, STR_MATCH_DOB, BLNK) +
			 IF(flags & V_MATCH_DID <> 0, STR_MATCH_DID, BLNK);

		RETURN getMatchStr(result(MatchName,MatchStreetAddress,MatchCity,
		                          MatchState,MatchZip,MatchSSN,MatchDob,MatchDID));			 
	END;
	
	EXPORT merge_match_codes(string8 mc1, string8 mc2) := function
		 c := mc1 + mc2;
		 return 
			IF(StringLib.StringContains(c, 'N', TRUE), 'N', '') + 
			IF(StringLib.StringContains(c, 'A', TRUE), 'A', '') + 
			IF(StringLib.StringContains(c, 'C', TRUE), 'C', '') + 
			IF(StringLib.StringContains(c, 'T', TRUE), 'T', '') + 
			IF(StringLib.StringContains(c, 'Z', TRUE), 'Z', '') +
			IF(StringLib.StringContains(mc2, 'S', TRUE), 'S', '') + // we do not want to propagate SSN match
			IF(StringLib.StringContains(c, 'D', TRUE), 'D', '') + 
			IF(StringLib.StringContains(c, 'L', TRUE), 'L', '');
	end;
	
	// ***** Domain-specific functions. *****
	EXPORT LN_Property := MODULE
			// Calculate penalties for the first four entities in a party, and return the lower penalty value.
			BOOLEAN return_assessments      := FALSE : STORED('Return_Assessments');
			BOOLEAN return_deeds            := FALSE : STORED('Return_Deeds');
			BOOLEAN return_mortgages        := FALSE : STORED('Return_Mortgages');
			BOOLEAN return_all              := (return_assessments AND return_deeds AND return_mortgages) OR
																					NOT (return_assessments OR return_deeds OR return_mortgages);
			assess_set:= if(return_assessments,['A'],[]);					 
			deed_set:= if(return_deeds,['D'],[]);					 
			mort_set:= if(return_mortgages,['M'],[]);		
	
		EXPORT return_record_types :=  if (return_all,['A','D','M'],assess_set + deed_set + mort_set);
		
				PT := LN_PropertyV2.Constants.PARTY_TYPE;		
				//Party type filters
				BOOLEAN return_pt_owner 			:= FALSE : STORED('Return_Owners');
				BOOLEAN return_pt_borrower		:= FALSE : STORED('Return_Borrower');
				BOOLEAN return_pt_seller			:= FALSE : STORED('Return_Seller');
				BOOLEAN return_pt_care_of			:= FALSE : STORED('Return_Care_Of');
				BOOLEAN return_pt_property		:= FALSE : STORED('Return_Property');
				
				UNSIGNED PARTY_TYPE_VAL := (0 	+ if (return_pt_owner,			PT.OWNER, 0)  
																				+	if (return_pt_borrower, 	PT.BORROWER, 0) 
																				+ if (return_pt_seller,  	PT.SELLER, 0) 
																				+ if (return_pt_care_of,  	PT.CARE_OF, 0)
																				+ if (return_pt_property,  PT.PROPERTY, 0)
																		);		
																		
  	EXPORT return_party_types :=  MAP( PARTY_TYPE_VAL =0 => LN_PropertyV2.Constants.PARTY_TYPE.ALL_PARTY_TYPES,
																			PARTY_TYPE_VAL
																	);

	//Full Name Penalty Calculation
		fullnames_to_compare(LN_PropertyV2_Services.layouts.parties.entity r, STRING in_lname, STRING in_mname, STRING in_fname, Boolean isFCRA = false) := FUNCTION
				RETURN  
					// Last name may be blank in the first entity if the entity happens to be a trust.
					MODULE(FULLNAME_LABEL(isFCRA))						
						EXPORT lastname       := in_lname;     // the 'input' last name
						EXPORT middlename     := in_mname;     // the 'input' middle name
						EXPORT firstname      := in_fname;     // the 'input' first name
						EXPORT lname_field    := IF(TRIM(r.lname,LEFT,RIGHT) = '', NONBLANK_BOGUS_VALUE, r.lname); 		 // the last name in the matching record
						EXPORT mname_field    := r.mname;			 // the middle name in the matching record
						EXPORT fname_field    := r.fname;			 // the first name in the matching record						
						EXPORT allow_wildcard := FALSE;
					END;			
		END;
		
		tmp_penalt_layout clac_nm_penalt(LN_PropertyV2_Services.layouts.parties.entity L, STRING in_lname, STRING in_mname, STRING in_fname, Boolean isFCRA = false) := TRANSFORM
			SELF.penalt := AutoStandardI.LIBCALL_PenaltyI_Indv_name.val(fullnames_to_compare(L, in_lname, in_mname, in_fname, isFCRA));
		END;	
		
		EXPORT penalize_fullname(BatchServices.Layouts.LN_Property.rec_input_and_matchcodes l, 
		                         DATASET(LN_PropertyV2_Services.layouts.parties.entity) r,boolean isFCRA=false) := FUNCTION				
				name_penalty := PROJECT(R, clac_nm_penalt(LEFT, L.name_last, L.name_middle, L.name_first, isFCRA));
			RETURN MIN(name_penalty, penalt);
		END;
		
	//Company Name Penalty Calculation
		cname_to_compare(LN_PropertyV2_Services.layouts.parties.entity L,STRING120 in_comp_nm) := FUNCTION
				RETURN
					MODULE(COMPANYNAME_LABEL)
					EXPORT companyname 			:= in_comp_nm;
					EXPORT cname_field 			:= L.cname;
					EXPORT allow_wildcard 	:= FALSE;
				END;
		END;

		tmp_penalt_layout clac_comp_nm_penalt(LN_PropertyV2_Services.layouts.parties.entity L, STRING120 in_comp_nm) := TRANSFORM
			SELF.penalt := AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(cname_to_compare(L, in_comp_nm));
		END;
		
		EXPORT penalize_business_name(BatchServices.Layouts.LN_Property.rec_input_and_matchcodes l,
																	DATASET(LN_PropertyV2_Services.layouts.parties.entity) r) := FUNCTION
					comp_penalty := PROJECT(R, clac_comp_nm_penalt(LEFT, L.comp_name));
			RETURN MIN(comp_penalty, penalt);
		END;

	//SSN Penalty Calculation
		ssn_to_compare(LN_PropertyV2_Services.layouts.parties.entity L,STRING9 in_ssn) := FUNCTION
			RETURN
					MODULE(SSN_LABEL)
						EXPORT ssn            	:= in_ssn;
						EXPORT ssn_field      	:= L.app_ssn;
						EXPORT allow_wildcard 	:= FALSE;
					END;			
			END;

		tmp_penalt_layout clac_ssn_penalt(LN_PropertyV2_Services.layouts.parties.entity L, STRING9 in_ssn) := TRANSFORM
			SELF.penalt := AutoStandardI.LIBCALL_PenaltyI_SSN.val(ssn_to_compare(L, in_ssn));
		END;
		
		EXPORT penalize_ssn(BatchServices.Layouts.LN_Property.rec_input_and_matchcodes l,
		                    DATASET(LN_PropertyV2_Services.layouts.parties.entity) r) :=	FUNCTION
					ssn_penalty := PROJECT(R, clac_ssn_penalt(LEFT, l.ssn));
			RETURN MIN (ssn_penalty, penalt);
		END;
		
		
		// Calculate penalties for the first four entities in a party, and return the lower penalty value.
			EXPORT lastnames_to_compare(BatchServices.Layouts.LN_Property.rec_input_and_matchcodes l, 
													LN_PropertyV2_Services.layouts.parties.pparty r, unsigned i,boolean isFCRA=false) := 
			FUNCTION
			RETURN  
					MODULE(FULLNAME_LABEL(isFCRA))						
						EXPORT lastname       := l.name_last;       // the 'input' last name
						EXPORT allow_wildcard := FALSE;
						EXPORT lname_field    := IF( TRIM(r.entity[i].lname,LEFT,RIGHT) = '', NONBLANK_BOGUS_VALUE, r.entity[i].lname); // the last name in the matching record
						EXPORT mname_field    := '';
						EXPORT fname_field    := '';						
					END;			
			END;

		EXPORT penalize_lastname(BatchServices.Layouts.LN_Property.rec_input_and_matchcodes l, 
		                         LN_PropertyV2_Services.layouts.parties.pparty r,boolean isFCRA=false) :=
			FUNCTION								
				
				// Last name may be blank in the first entity if the entity happens to be a trust.
				lastnames_to_compare_1 := lastnames_to_compare(l,r,1,isFCRA);
				
				// Last name may be blank in the second entity if the entity doesn't exist. 
				lastnames_to_compare_2 := lastnames_to_compare(l,r,2,isFCRA);
					
				entity_1_penalty := AutoStandardI.LIBCALL_PenaltyI_Indv_name.val(lastnames_to_compare_1);
				entity_2_penalty := AutoStandardI.LIBCALL_PenaltyI_Indv_name.val(lastnames_to_compare_2);
				
				RETURN MIN(entity_1_penalty, entity_2_penalty);
				
			END;
		
			EXPORT address_to_compare(BatchServices.Layouts.LN_Property.rec_input_and_matchcodes l, 
		                        LN_PropertyV2_Services.layouts.parties.pparty r) :=
			FUNCTION			
				RETURN 
					MODULE(ADDRESS_LABEL)
					
						// The 'input' address:
						EXPORT predir         := l._predir;
						EXPORT prim_name      := l._prim_name;
						EXPORT prim_range     := l._prim_range;
						EXPORT postdir        := l._postdir;
						EXPORT addr_suffix    := l._addr_suffix;
						EXPORT sec_range      := l._sec_range;
						EXPORT p_city_name    := l._p_city_name;
						EXPORT st             := l._st;
						EXPORT z5             := l._z5;					
						
						// The address in the matching record:						
						EXPORT allow_wildcard := FALSE;					
						EXPORT city_field     := r.p_city_name;
						EXPORT city2_field    := '';
						EXPORT pname_field    := r.prim_name;
						EXPORT postdir_field  := r.postdir;
						EXPORT prange_field   := r.prim_range;
						EXPORT predir_field   := r.predir;
						EXPORT state_field    := r.st;
						EXPORT suffix_field   := r.suffix;
						EXPORT zip_field      := r.zip;
						
						EXPORT useGlobalScope := FALSE;
					END;
			END;	
		// Calculate penalty for a pair of addresses.			
		EXPORT penalize_address(BatchServices.Layouts.LN_Property.rec_input_and_matchcodes l, 
		                        LN_PropertyV2_Services.layouts.parties.pparty r) :=
			FUNCTION			
				RETURN AutoStandardI.LIBCALL_PenaltyI_Addr.val(address_to_compare(l,r));
			END;			
		
		// The following function assigns the appropriate matchcode. We take advantage of the short-circuit in 
		// the MAP function to determine the appropriate match level, from loosest to most stringent. The match-
		// codes (in that order) are:
		//    '0'   = no match
		//    'AZ5' = Address Only Match 
		//    'LAZ' = Last Name and Address Match 
		//    'FAZ' = Full Name and Address Match 
		//
		// Note that, if the party is a Property, we don't attempt a lastname or fullname match. Duh. I know.
		EXPORT fn_apply_penalty(BatchServices.Layouts.LN_Property.rec_input_and_matchcodes l, 
		                       LN_PropertyV2_Services.layouts.parties.pparty r,boolean isFCRA = false) := 
			FUNCTION
				entities := R.entity;
				matchcode := MAP( ( l._prim_name != '' AND l.name_first != '' AND 
				                    penalize_fullname(L, entities, isFCRA) <= FULLNAME_ACCEPTABLE_THRESHOLD ) 
				                                                                          => 'FAZ' 
				                  ,
				                  ( l._prim_name != '' AND l.name_last != '' AND 
													  penalize_lastname(l,r,isFCRA) <= LASTNAME_ACCEPTABLE_THRESHOLD )
													                                                        => 'LAZ'
				                  ,
				                  ( l._prim_name != '' AND 
													  penalize_address(l,r)  <= ADDRESS_ACCEPTABLE_THRESHOLD ) 
													                                                        => 'AZ5'
				                  ,
				                  /* ELSE.............................................. */     '0' 
				            );										

				RETURN matchcode;
				
		END;
			
	  EXPORT BOOLEAN fn_match_name(dataset (LN_PropertyV2_Services.layouts.parties.entity) LE,
	                     LN_PropertyV2_Services.layouts.batch_in R)  := FUNCTION												     																						 																											
        tmp_int_layout x_name(LN_PropertyV2_Services.layouts.parties.entity ent,
					                LN_PropertyV2_Services.layouts.batch_in R) := TRANSFORM              
	      SELF.val := if (((ent.fname = R.name_first and R.name_first <> '') OR NID.mod_PFirstTools.PFLeqPFR(ent.fname,R.name_first) AND R.name_first <> '') AND
		 						              (ent.lname = R.name_last and R.name_last <> ''), 1, 2);              														 
        END;							 					   
	  	  ret_val := if (min(project(LE, x_name(LEFT,R)), val) = 1, TRUE, FALSE);
        RETURN (ret_val);									
	  END;
	
	  EXPORT BOOLEAN fn_match_did(dataset( LN_propertyV2_Services.layouts.parties.entity) LE,
	                     LN_PropertyV2_Services.layouts.batch_in R) := FUNCTION
        tmp_int_layout x_did(LN_PropertyV2_Services.layouts.parties.entity ent,
					                LN_PropertyV2_Services.layouts.batch_in R) := TRANSFORM  											 
        SELF.val := if ((((unsigned6) ent.did = R.did) and (R.did <> 0)), 1, 2);
		  END;
		  ret_val := if (min(project(LE, x_did(LEFT,R)), val) = 1, TRUE, FALSE);			
		  RETURN (ret_val);									 
    END;				
	
	  EXPORT BOOLEAN fn_match_ssn(dataset( LN_propertyV2_Services.layouts.parties.entity) LE,
	                     LN_PropertyV2_Services.layouts.batch_in R) := FUNCTION
        tmp_int_layout loopit(LN_PropertyV2_Services.layouts.parties.entity ent,
					                LN_PropertyV2_Services.layouts.batch_in R) := TRANSFORM  											 
        SELF.val := if ((ent.app_ssn = stringlib.stringfilterout(R.ssn, '-') AND (R.ssn <> '')), 1, 2);
		  END;
		  ret_val := if (min(project(LE, loopit(LEFT,R)), val) = 1, TRUE, FALSE);			
		  RETURN (ret_val);									 
    END;	
		
		 EXPORT BOOLEAN fn_match_streetAddress ( dataset (LN_propertyV2_Services.layouts.parties.pparty) LE,
	                                         LN_PropertyV2_Services.layouts.batch_in RI) := FUNCTION
		  tmp_int_layout xform_streetAddr(LN_propertyV2_Services.layouts.parties.pparty L,
					                                LN_PropertyV2_Services.layouts.batch_in R) := TRANSFORM
			  self.val := if ((L.prim_name = R.prim_name AND R.prim_name <> '')AND (L.prim_range = R.prim_range AND R.prim_range <> '') AND
				                (L.predir = R.predir AND R.predir <> '')       AND (L.postdir = R.postdir AND R.postdir <> '')       AND
												(L.suffix = R.addr_suffix AND R.addr_suffix <> ''), 1, 2);
		  END;
		  ret_val := if (min(project(LE, xform_streetAddr(LEFT,RI)), val) = 1, TRUE,FALSE);
		  return (ret_val);
    END;
		 // city
		  EXPORT BOOLEAN fn_match_city( dataset (LN_propertyV2_Services.layouts.parties.pparty) LE,
	                                Autokey_batch.Layouts.rec_inBatchMaster RI)  := FUNCTION	
																	
      tmp_int_layout xform_city( LN_propertyV2_Services.layouts.parties.pparty  L,
					                    Autokey_batch.Layouts.rec_inBatchMaster R) := TRANSFORM              	            
           self.val := if (L.p_city_name = R.p_city_name and R.p_city_name <> '', 1, 2); 				   
      END;							 					   
		  ret_val := if (min(project(LE, xform_city(LEFT,RI)), val) = 1, TRUE, FALSE);
      RETURN (ret_val);									
	  END;
		  // state
		  EXPORT BOOLEAN fn_match_state( dataset (LN_propertyV2_Services.layouts.parties.pparty) LE,
	                                Autokey_batch.Layouts.rec_inBatchMaster RI)  := FUNCTION	
																
      tmp_int_layout xform_state( LN_propertyV2_Services.layouts.parties.pparty  L,
					                    Autokey_batch.Layouts.rec_inBatchMaster R) := TRANSFORM              	            
           self.val := if ( L.st = R.st and R.st <> '', 1, 2); 				   
      END;							 					   
		  ret_val := if (min(project(LE, xform_state(LEFT,RI)), val) = 1, TRUE, FALSE);
      RETURN (ret_val);									
	  END;
		// zip5
		
		  EXPORT BOOLEAN fn_match_zip( dataset (LN_propertyV2_Services.layouts.parties.pparty) LE,
	                                Autokey_batch.Layouts.rec_inBatchMaster RI)  := FUNCTION	
																	
      tmp_int_layout xform_zip( LN_propertyV2_Services.layouts.parties.pparty  L,
					                    Autokey_batch.Layouts.rec_inBatchMaster R) := TRANSFORM              	            
           self.val := if ( L.zip = R.z5 AND R.z5 <> '', 1, 2); 				   
      END;							 					   
		  ret_val := if (min(project(LE, xform_zip(LEFT,RI)), val) = 1, TRUE, FALSE);
      RETURN (ret_val);									
	  END;
			
	END;

	
	EXPORT Sample_Service := MODULE
	
		EXPORT penalize_fullname(BatchServices.Layouts.layout_batch_in_for_penalties l, 
		                         LN_PropertyV2_Services.layouts.parties.entity r) :=
			FUNCTION				

				names_to_compare :=  
					MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))	
						
						// The 'input' name:
						EXPORT lastname       := l._name_last;   
						EXPORT middlename     := l._name_middle; 
						EXPORT firstname      := l._name_first;  

						// The name in the matching record:
						EXPORT lname_field    := r.lname; 
						EXPORT mname_field    := r.mname; 
						EXPORT fname_field    := r.fname; 					
						
						EXPORT allow_wildcard := FALSE;
					END;
				
				RETURN AutoStandardI.LIBCALL_PenaltyI_Indv_name.val(names_to_compare);

			END;
			
		EXPORT penalize_address(BatchServices.Layouts.layout_batch_in_for_penalties l, 
		                        LN_PropertyV2_Services.layouts.parties.pparty r) :=
			FUNCTION			
			
				addresses_to_compare := 
					MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))
					
						// The 'input' address:
						EXPORT predir         := l._predir;
						EXPORT prim_name      := l._prim_name;
						EXPORT prim_range     := l._prim_range;
						EXPORT postdir        := l._postdir;
						EXPORT addr_suffix    := l._addr_suffix;
						EXPORT sec_range      := l._sec_range;
						EXPORT p_city_name    := l._p_city_name;
						EXPORT st             := l._st;
						EXPORT z5             := l._z5;					
						
						// The address in the matching record:						
						EXPORT allow_wildcard := FALSE;					
						EXPORT city_field     := r.p_city_name;
						EXPORT city2_field    := '';
						EXPORT pname_field    := r.prim_name;
						EXPORT postdir_field  := r.postdir;
						EXPORT prange_field   := r.prim_range;
						EXPORT predir_field   := r.predir;
						EXPORT state_field    := r.st;
						EXPORT suffix_field   := r.suffix;
						EXPORT zip_field      := r.zip;
						
						EXPORT useGlobalScope := FALSE;
					END;
				
				RETURN AutoStandardI.LIBCALL_PenaltyI_Addr.val(addresses_to_compare);

			END;	
			


		EXPORT penalize_record(BatchServices.Layouts.layout_batch_in_for_penalties input_rec, 
		                       BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos match_rec) :=
			FUNCTION
			
				UCase        := StringLib.StringToUpperCase;					

				property     := match_rec.parties( UCase(party_type) = 'P' )[1];
				first_owner  := match_rec.parties( UCase(party_type) = 'O' )[1].entity[1];
				second_owner := match_rec.parties( UCase(party_type) = 'O' )[1].entity[2];
				seller       := match_rec.parties( UCase(party_type) = 'S' )[1].entity[1];

				RETURN MIN( penalize_fullname(input_rec,first_owner),
				            penalize_fullname(input_rec,second_owner),
										penalize_fullname(input_rec,seller) )
				       + penalize_address(input_rec,property);
			END;
	
	END;
	
	EXPORT UCC := MODULE	      
	       penalt_addr( Batchservices.layouts.ucc.rec_autokey_batch_tmsid l,
				              dataset(uccv2_services.layout_ucc_party_address_src) r) := function
 
            ds_out_addr_penalt := project(r, transform(tmp_penalt_layout,
											addresses_to_compare := 
						MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))
					
						// The 'input' address:
							EXPORT predir         := l.predir;
							EXPORT prim_name      := l.prim_name;
							EXPORT prim_range     := l.prim_range;
							EXPORT postdir        := l.postdir;
							EXPORT addr_suffix    := l.addr_suffix;
							EXPORT sec_range      := l.sec_range;
							EXPORT p_city_name    := l.p_city_name;
							EXPORT st             := l.st;
							EXPORT z5             := l.z5;					
						
							// The address in the matching record:						
							EXPORT allow_wildcard  := FALSE;					
							EXPORT city_field      := left.v_city_name;
							EXPORT city2_field     := '';
							EXPORT pname_field     := left.prim_name;
							EXPORT postdir_field   := left.postdir;
							EXPORT prange_field    := left.prim_range;
							EXPORT predir_field    := left.predir;
							EXPORT state_field     := left.st;
							EXPORT suffix_field    := left.addr_suffix;
							EXPORT zip_field       := left.zip5;						
							EXPORT sec_range_field := left.sec_range;
							EXPORT useGlobalScope  := FALSE;
						END;				
						
						  highPenalt := if (left.address1 = '', 20, 0);
							
						self.penalt := max(AutoStandardI.LIBCALL_PenaltyI_Addr.val(addresses_to_compare), highPenalt);
					));				
						return min(ds_out_addr_penalt, penalt);				
				end;
				
	       penalt_ind_name(  batchservices.layouts.ucc.rec_autokey_batch_tmsid  l,
				                   dataset (uccv2_services.layout_ucc_party_parsed_src) r) := function
																	// project necessary cause of multiple layers in addresses and
																	// parsed parties
				   ds_out_indname_penalt := project(r, transform(tmp_penalt_layout,						 					 
					 tempindvmod :=                               
						MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))						
							EXPORT lastname       := l.name_last;       // the 'input' last name
							EXPORT middlename     := l.name_middle;     // the 'input' middle name
							EXPORT firstname      := l.name_first;      // the 'input' first name
							EXPORT allow_wildcard := FALSE;
							EXPORT useGlobalScope := FALSE;
							EXPORT lname_field    := left.lname;	// matching record					                           
							EXPORT mname_field    := left.mname; 
							EXPORT fname_field    := left.fname; 				
						END;					 								    
						 high_ind_penalt := if (left.lname = '' AND left.fname ='', 20, 0);
				   self.penalt := max(AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempindvmod), high_ind_penalt);					              
				   ));				   
				   return min(ds_out_indname_penalt, penalt);					 
				end;
					  
		export tmp_penalt_layout penalt_func_calculate(  batchservices.layouts.ucc.rec_autokey_batch_tmsid l,
				                        DATASET(uccv2_services.layout_ucc_party_src) r
															
			                                   )  := FUNCTION
		
							 out_ds := PROJECT(r, TRANSFORM(tmp_penalt_layout,	
									tempbizmod := MODULE(PROJECT(AutoStandardI.GlobalModule(),
				                           AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
										EXPORT allow_wildcard := FALSE;
										EXPORT useGlobalScope := FALSE;
									  EXPORT companyname    := l.comp_name;									
										EXPORT cname_field    := left.orig_name;																			
									END;				
                 high_biz_penalt := if (left.orig_name = '', 20, AutoStandardI.LIBCALL_PenaltyI_Biz_name.val(tempBizMod));
									tmp_addr := if (exists(left.addresses),  penalt_addr(l, left.addresses), 20);															 
									tmp_ind_name := if (exists(left.parsed_parties), penalt_ind_name(l, left.parsed_parties), 20);						
								self.penalt := (unsigned2)  min(high_biz_penalt, tmp_ind_name) +  tmp_addr;
								));     															
						 return out_ds;
						  // represents just one row penalty.
				END;							 							 
	END;  // ucc module
 
  
  EXPORT PL := MODULE	
	    geo_l := record
				Prof_License.Layout_proLic_in.cart;
				Prof_License.Layout_proLic_in.cr_sort_sz;
				Prof_License.Layout_proLic_in.lot;
				Prof_License.Layout_proLic_in.lot_order;
				Prof_License.Layout_proLic_in.dpbc;
				Prof_License.Layout_proLic_in.chk_digit;
				Prof_License.Layout_proLic_in.record_type;
				Prof_License.Layout_proLic_in.ace_fips_st;
				Prof_License.Layout_proLic_in.county;
				Prof_License.Layout_proLic_in.geo_lat;
				Prof_License.Layout_proLic_in.geo_long;
				Prof_License.Layout_proLic_in.msa;
				Prof_License.Layout_proLic_in.geo_blk;
				Prof_License.Layout_proLic_in.geo_match;
				Prof_License.Layout_proLic_in.err_stat;
			end;
	
	    layout_w_penalt3 := record
						Doxie.layout_inBatchMaster.acctno;
						prof_LicenseV2_Services.Assorted_Layouts.Layout_key.uniqueid;
						prof_LicenseV2_Services.Assorted_Layouts.Layout_key.npi;
						String12 prolic_seq_id;
						String12 ProviderId;
						String12 sanc_id;
						string200	DEANumber;		
						prof_LicenseV2_Services.Assorted_Layouts.Layout_Search1- geo_l;
						prof_LicenseV2_Services.Assorted_Layouts.Layout_report1;		
						string1 expired_flag;
				END;

			export fn_pentalize( Autokey_batch.Layouts.rec_inBatchMaster l,																	                       
														  layout_w_penalt3 r) := function
											         						          							 							 
							 tempaddrmod:= 
									MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))					
										//	The 'input' address:
										EXPORT predir         := l.predir;
										EXPORT prim_name      := l.prim_name;
										EXPORT prim_range     := l.prim_range;
										EXPORT postdir        := l.postdir;
										EXPORT addr_suffix    := l.addr_suffix;
										EXPORT sec_range      := l.sec_range;
										EXPORT p_city_name    := l.p_city_name;
										EXPORT st             := l.st;
										EXPORT z5             := l.z5;											
										//	The address in the matching record:						
										EXPORT allow_wildcard  := FALSE;															
										EXPORT city_field      := r.v_city_name;
										EXPORT city2_field     := '';										
										EXPORT pname_field     := r.prim_name;									
										EXPORT prange_field    := r.prim_range;										
										EXPORT postdir_field   := r.postdir;																				
										EXPORT predir_field    := r.predir;									
										EXPORT state_field     := r.st;										
										EXPORT suffix_field    := r.suffix;										
										EXPORT zip_field       := r.zip;											
										EXPORT sec_range_field := r.sec_range;
										EXPORT useGlobalScope  := FALSE;
									END;		
									tmp_addr := AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempaddrmod);				
							 		 
							 tempbizmod := 
									MODULE(PROJECT(AutoStandardI.GlobalModule(),
				                 AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
												   //only use the biz name penalty cause that is all that is filled out.
										EXPORT allow_wildcard := FALSE;
										EXPORT useGlobalScope := FALSE;
									  EXPORT companyname := l.comp_name;																			
										EXPORT cname_field := r.company_name;
									END;				
	                                              
							  biz_name_penalt := AutoStandardI.LIBCALL_PenaltyI_Biz_name.val(tempBizMod);
								tempindvmod :=                               
									MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))						
										EXPORT lastname       := l.name_last;       // the 'input' last name
										EXPORT middlename     := l.name_middle;     // the 'input' middle name
										EXPORT firstname      := l.name_first;      // the 'input' first name
										EXPORT allow_wildcard := FALSE;
										EXPORT useGlobalScope := FALSE;									
									  EXPORT lname_field    := r.lname;			// matching record name information			                          
										EXPORT mname_field    := r.mname; 
										EXPORT fname_field    := r.fname;	
									END;	
									
								tmp_ind_name := AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempindvmod);							 					 					 
								
						 RETURN min( tmp_ind_name, biz_name_penalt ) + tmp_addr;						 
				END;					
				
			EXPORT prof_licensev2_services.assorted_layouts.plBatchMaster_npi
        file_inPLBatchMasterNPI(dataset (prof_licensev2_services.Layout_MLPL_Combined_Input) ds_batch_in_raw1 = DATASET([],prof_licensev2_services.Layout_MLPL_Combined_Input),
				                        BOOLEAN forceSeq = FALSE) := function 
			
				rec := prof_licensev2_services.assorted_layouts.plBatchMaster_npi;

	      raw1 := project(ds_batch_in_raw1, rec);
				raw0 := raw1 : GLOBAL;

				rec tra(rec l) := TRANSFORM
					SELF.max_results := if((UNSIGNED8)l.max_results > 0, l.max_results, '500');
					SELF := l;
				end;

				raw := PROJECT(raw0, tra(LEFT));

				ut.MAC_Sequence_Records(raw, seq, raw_seq)

				pl_batch_return_set := IF(NOT forceSeq AND EXISTS(raw(seq > 0)), raw, raw_seq);
	
			  return pl_batch_return_set;
			end;
	END; // PL
	
	/* 	returns true if SSNs are not the same, but there is one differing digit or two transposed digits */
	export fn_ssn_accunear(string9 ssn1, string9 ssn2) := function
		return (ssn1 != ssn2) AND ut.WithinEditN(ssn1, ssn2, 1);
	end;
	
	export fn_reorder_matchcode(string12 mc) := function
		string mc_addr := if(StringLib.StringContains(mc, BatchServices.MatchCodes.addr, false), 
								BatchServices.MatchCodes.addr, 
								'');
		string mc_name := if(StringLib.StringContains(mc, BatchServices.MatchCodes.name, false), 
								mc_addr + BatchServices.MatchCodes.name, 
								mc_addr);

		string mc_ssn := map(
							StringLib.StringContains(mc, BatchServices.MatchCodes.ssn_full, false) => BatchServices.MatchCodes.ssn_full,
							StringLib.StringContains(mc, BatchServices.MatchCodes.ssn_prob, false) => BatchServices.MatchCodes.ssn_prob,
							StringLib.StringContains(mc, BatchServices.MatchCodes.ssn_red, false) => BatchServices.MatchCodes.ssn_red, 
							'');

		// SSN + partial name
		string mc_partial_name := map(
							StringLib.StringContains(mc, BatchServices.MatchCodes.last_fi, false) => mc_ssn + BatchServices.MatchCodes.last_fi,
							StringLib.StringContains(mc, BatchServices.MatchCodes.lastname, false) => mc_ssn + BatchServices.MatchCodes.lastname,
							StringLib.StringContains(mc, BatchServices.MatchCodes.first_li, false) => mc_ssn + BatchServices.MatchCodes.first_li, 
							StringLib.StringContains(mc, BatchServices.MatchCodes.firstname, false) => mc_ssn + BatchServices.MatchCodes.firstname, 
							mc_ssn);

		string mc_AN := if(mc_name = 'AN', 
								mc_name + mc_partial_name, 
								mc_partial_name + mc_name);

		string mc_zip  := if(StringLib.StringContains(mc, BatchServices.MatchCodes.zip,  false), 
								mc_AN + BatchServices.MatchCodes.zip,  
								mc_AN);
								
		string mc_city := if(StringLib.StringContains(mc, BatchServices.MatchCodes.city, false), 
								mc_zip + BatchServices.MatchCodes.city, 
								mc_zip);
								
		string mc_did	:= if(StringLib.StringContains(mc, BatchServices.MatchCodes.did, false),
								mc_city + BatchServices.MatchCodes.did,
								mc_city);
			
		mc_new := trim(mc_did,all);
	
		return mc_new;
	end;
	
	
	/* 	augments matchcode according to specific logic (outlined in attachment in Bug 51541) 	*/
	EXPORT fn_augment_addr_matchcode(STRING matchcode, 
									 STRING in_addr, 
									 STRING in_city, 
									 STRING in_st, 
									 STRING in_zip,
									 UNSIGNED3 score_did = 0,
									 UNSIGNED3 score_bdid = 0,
									 UNSIGNED3 did_score_threshold = 100,
									 UNSIGNED3 bdid_score_threshold = 100) := FUNCTION
	
		upper_matchcode := StringLib.StringToUpperCase(matchcode);
	
		/* 	ASSUMPTION: if "L" is in existing match code, DID was sent into the query and the DID matched the DID in this
			input record 	*/
		BOOLEAN is_candidate := (StringLib.StringFind(upper_matchcode, MatchCodes.did, 1) != 0)
								AND	
								(
									/* existing match code contains at least SN,PN or RN */
									(
										StringLib.StringFind(upper_matchcode, MatchCodes.name, 1) != 0
										AND
										(	
											StringLib.StringFind(upper_matchcode, MatchCodes.ssn_full, 1) 	!= 0
											OR
											StringLib.StringFind(upper_matchcode, MatchCodes.ssn_prob, 1) 	!= 0
											OR
											StringLib.StringFind(upper_matchcode, MatchCodes.ssn_red,  1) 	!= 0
										)
									)
									OR
									/* DID or BDID score higher than a certain value and not zero */
									(
										(score_did  >= did_score_threshold  AND score_did  > 0 AND did_score_threshold  > 0) 
										OR 
										(score_bdid >= bdid_score_threshold AND score_bdid > 0 AND bdid_score_threshold > 0)
									)
								);
								
		augment_matchcode_a := IF(StringLib.StringFind(upper_matchcode, MatchCodes.addr, 1) = 0 AND TRIM(in_addr, ALL) != '', 
									TRIM(matchcode) + MatchCodes.addr, 
									TRIM(matchcode));
		augment_matchcode_c := IF(StringLib.StringFind(upper_matchcode, MatchCodes.city, 1) = 0 AND TRIM(in_city, ALL) != '' 
																								AND TRIM(in_st,   ALL) != '',
									augment_matchcode_a + MatchCodes.city,
									augment_matchcode_a);
		augment_matchcode_z := IF(StringLib.StringFind(upper_matchcode, MatchCodes.zip, 1)  = 0 AND TRIM(in_zip,  ALL) != '',
									augment_matchcode_c + MatchCodes.zip,
									augment_matchcode_c);
									
		/* if the incoming matchcode is a candidate to be augmented, return the augmented one, otherwise return regular	*/
		matchcode_fin		:= IF(is_candidate, fn_reorder_matchcode(augment_matchcode_z), TRIM(matchcode));
		
		/* 	strip L	*/
		matchcode_noL		:= StringLib.StringFilterOut(matchcode_fin, MatchCodes.did);
		RETURN matchcode_noL;
	END;
	
	
	EXPORT Bankruptcy := MODULE
		/* 
			Function to fix old case numbers to the standard format used to build TMSIDs. 
			The court code that must be used is the 4-digit Banko version of the court code, 
			not the 5 digit 'moxie_court' value.
			(This is a grandfathered practice from Banko batch processing)
		*/
		EXPORT fn_fix_case(STRING8 case_number, STRING4 court_code) := FUNCTION
			case_trim 	:= TRIM(case_number, LEFT, RIGHT);
			court_trim 	:= TRIM(court_code,  LEFT, RIGHT);
			case_len 	:= LENGTH(case_trim);
			
			remove_3rd_digit(STRING case_num) := FUNCTION
				RETURN case_num[1..2] + case_num[4..LENGTH(case_num)];
			END;
			
			replace_3rd_digit_with_zero(STRING case_num) := FUNCTION
				RETURN case_num[1..2] + '0' + case_num[4..LENGTH(case_num)];
			END;
			
			fixed_case_number	:= MAP(
									court_trim IN Constants.Bankruptcy.FIXCASE_FL1_COURTS AND case_len = 8
										=> remove_3rd_digit(case_trim),
									court_trim IN Constants.Bankruptcy.FIXCASE_FL1_COURTS AND case_len = 7
										AND case_trim[3] IN Constants.Bankruptcy.FIXCASE_FL1_XTRA_NUM
										=> replace_3rd_digit_with_zero(case_trim),
									court_trim IN Constants.Bankruptcy.FIXCASE_FL2_COURTS AND case_len = 7
										AND case_trim[1..2] = Constants.Bankruptcy.FIXCASE_FL2_FIRST2
										AND case_trim[3] IN Constants.Bankruptcy.FIXCASE_FL2_XTRA_NUM
										=> replace_3rd_digit_with_zero(case_trim),
									court_trim IN Constants.Bankruptcy.FIXCASE_PA_COURTS AND case_len  = 7
										AND case_trim[3] IN Constants.Bankruptcy.FIXCASE_PA_XTRA_NUM
										AND ( 
												(case_trim[1..2] >= Constants.Bankruptcy.FIXCASE_PA_FIRST2_9L 
													AND case_trim[1..2] <= Constants.Bankruptcy.FIXCASE_PA_FIRST2_9H)
												 OR 
												(case_trim[1..2] >= Constants.Bankruptcy.FIXCASE_PA_FIRST2_0L 
													AND case_trim[1..2] <= Constants.Bankruptcy.FIXCASE_PA_FIRST2_0H)
											)
										=> replace_3rd_digit_with_zero(case_trim),
									court_trim IN Constants.Bankruptcy.FIXCASE_VA_COURTS AND case_len  = 8
										AND case_trim[3] IN Constants.Bankruptcy.FIXCASE_VA_XTRA_NUM
										=> remove_3rd_digit(case_trim),
									case_trim);
			
			RETURN fixed_case_number;
		END;
	END;
	
	EXPORT ApplySSNStateFilter(DATASET(BatchServices.layout_BankruptcyV3_Batch_out) ds_FCRA_data =
			DATASET([],BatchServices.layout_BankruptcyV3_Batch_out),
			DATASET(BatchServices.layout_BankruptcyV3_Batch_in) ds_input
										= DATASET([],	BatchServices.layout_BankruptcyV3_Batch_in)) := FUNCTION 
		/*
		New legislature was passed to allow certain states to not receive hits based on "how" we matched the record
		and dependent on what state the hit is from. The requirement was if the state is in the list of restricted
		states then we can only provide a SSN hit if a form of SSN hit, the name matched and some other aspect it matched.
		(Including if the input state was in the restricted list of states and matched the output state, as we don't have
		a matchcode for just state.)
		*/
			ls_SSNRestrictedInputMatchCode(STRING8 mc) := mc IN ['SN','PN','RN'];
			ls_SSNRestrictedOutputMatchCode(STRING8 mc) := mc NOT IN ['SAZC','SAZ','SZC','SAC','SA','SC','SZ','S','PAZC','PAZ','PZC','PZ','RAZC','RAZ','SN','PN','RN','PAC','RAC'];
			ls_SSNRestrictedState := ['RI'];	
    
			ds_NoninputSSNRestricted := JOIN(ds_FCRA_data, ds_input,
				LEFT.acctno = RIGHT.acctno AND LEFT.Court_st = RIGHT.st AND
				LEFT.Court_st IN ls_SSNRestrictedState
				AND ls_SSNRestrictedInputMatchCode(LEFT.matchcode),
				TRANSFORM(LEFT),
				INNER);					
	
			ds_NonoutputSSNRestricted := ds_FCRA_data(ds_FCRA_data.Court_st NOT IN ls_SSNRestrictedState
				OR (ds_FCRA_data.court_st IN ls_SSNRestrictedState
					AND ls_SSNRestrictedOutputMatchCode(ds_FCRA_data.matchcode)));
		
		ds_fcraOutRecs := sort(ds_NoninputSSNRestricted + ds_NonoutputSSNRestricted, acctno);

			RETURN ds_fcraOutRecs;
		END;

	EXPORT st2abbrev(STRING state) := FUNCTION
		clean_state := ut.CleanSpacesAndUpper(state);
		name2Abbrev := ut.st2abbrev(clean_state);
		validAbbrev := MAP(
			clean_state = 'AL' => 'AL',
			clean_state = 'AK' => 'AK',
			clean_state = 'AR' => 'AR',
			clean_state = 'AS' => 'AS',
			clean_state = 'AZ' => 'AZ',
			clean_state = 'CA' => 'CA',
			clean_state = 'CO' => 'CO',
			clean_state = 'CT' => 'CT',
			clean_state = 'DC' => 'DC',
			clean_state = 'DE' => 'DE',
			clean_state = 'FL' => 'FL',
			clean_state = 'GA' => 'GA',
			clean_state = 'GU' => 'GU',
			clean_state = 'HI' => 'HI',
			clean_state = 'IA' => 'IA',
			clean_state = 'ID' => 'ID',
			clean_state = 'IL' => 'IL',
			clean_state = 'IN' => 'IN',
			clean_state = 'KS' => 'KS',
			clean_state = 'KY' => 'KY',
			clean_state = 'LA' => 'LA',
			clean_state = 'MA' => 'MA',
			clean_state = 'MD' => 'MD',
			clean_state = 'ME' => 'ME',
			clean_state = 'MI' => 'MI',
			clean_state = 'MN' => 'MN',
			clean_state = 'MO' => 'MO',
			clean_state = 'MS' => 'MS',
			clean_state = 'MT' => 'MT',
			clean_state = 'NC' => 'NC',
			clean_state = 'ND' => 'ND',
			clean_state = 'NE' => 'NE',
			clean_state = 'NH' => 'NH',
			clean_state = 'NJ' => 'NJ',
			clean_state = 'NM' => 'NM',
			clean_state = 'NV' => 'NV',
			clean_state = 'NY' => 'NY',
			clean_state = 'OH' => 'OH',
			clean_state = 'OK' => 'OK',
			clean_state = 'OR' => 'OR',
			clean_state = 'PA' => 'PA',
			clean_state = 'PR' => 'PR',
			clean_state = 'RI' => 'RI',
			clean_state = 'SC' => 'SC',
			clean_state = 'SD' => 'SD',
			clean_state = 'TN' => 'TN',
			clean_state = 'TX' => 'TX',
			clean_state = 'US' => 'US',
			clean_state = 'UT' => 'UT',
			clean_state = 'VA' => 'VA',
			clean_state = 'VI' => 'VI',
			clean_state = 'VT' => 'VT',
			clean_state = 'WA' => 'WA',
			clean_state = 'WI' => 'WI',
			clean_state = 'WV' => 'WV',
			clean_state = 'WY' => 'WY',
			'');	
		RETURN IF(name2Abbrev!='', name2Abbrev, validAbbrev);
	END;

END;