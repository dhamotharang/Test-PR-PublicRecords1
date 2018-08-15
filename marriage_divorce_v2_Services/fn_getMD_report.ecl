import marriage_divorce_v2_Services, ut, Codes, Census_Data, AutoStandardI, suppress, address, fcra, FFD;

l_result	:= marriage_divorce_v2_Services.layouts.result.wide_tmp;
l_id			:= marriage_divorce_v2_Services.layouts.expanded_id; //layouts.l_id;
l_cparty	:= marriage_divorce_v2_Services.layouts.party_combined.wide;

export dataset(l_result) fn_getMD_report(
			dataset(l_id) in_ids, integer1 NSS_val=suppress.constants.NonSubjectSuppression.doNothing,
			boolean isFCRA = false,
			dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
			dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
			integer8 inFFDOptionsMask = 0
) := function

	boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
	boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);

	params 		:= marriage_divorce_v2_Services.input.params;
	it 				:= AutoStandardI.InterfaceTranslator;
	gm 				:= marriage_divorce_v2_Services.input.gm(isFCRA);
	temp_mod_one := module(project(gm,params,opt)) end;
	temp_mod_two := module(project(gm,params,opt))
		export firstname := gm.entity2_firstname;
		export middlename := gm.entity2_middlename;
		export lastname := gm.entity2_lastname;
		export unparsedfullname := gm.entity2_unparsedfullname;
		export allownicknames := gm.entity2_allownicknames;
		export phoneticmatch := gm.entity2_phoneticmatch;
		export companyname := gm.entity2_companyname;
		export addr := gm.entity2_addr;
		export city := gm.entity2_city;
		export state := gm.entity2_state;
		export zip := gm.entity2_zip;
		export zipradius := gm.entity2_zipradius;
		export phone := gm.entity2_phone;
		export fein := gm.entity2_fein;
		export bdid := gm.entity2_bdid;
		export did := gm.entity2_did;
		export ssn := gm.entity2_ssn;
	end;
		
// canned data for testing
  // _canned :=  _data_canned.Corrections (in_ids);
  // flags := _canned.flagfile;

  flags_main := flagfile (file_id=FCRA.FILE_ID.MARRIAGE);
  flags_search := flagfile (file_id=FCRA.FILE_ID.MARRIAGE_SEARCH);

	md_raw_1 := join(
		in_ids, marriage_divorce_v2_Services.keys.main(isFCRA),
	  keyed(left.record_id = right.record_id)
    and (~ut.IndustryClass.is_knowx or right.state_origin<>'OK')
		and ~(isFCRA and (string)right.persistent_record_id in set(flags_main ((unsigned6)did=left.search_did), record_id)),
		keep (1), limit(0)
	);
	
 rec_md_raw := recordof(md_raw_1);

// canned override key for marriages
  // override_can := _canned.override_can;   													
  // marriage_over := _canned.marriage_over;

	marriage_over := join(flags_main, FCRA.key_override_marriage.marriage_main,
												keyed(left.flag_file_id = right.flag_file_id) and isFCRA,
											  transform(rec_md_raw,
													self.search_did := (unsigned6)left.did, 
													self := right,
													self := []),limit(0));
	
	md_raw_2 := md_raw_1 + marriage_over;
//---------------------------------------FCRA FFD----------------------------------------------------------------	
	
// Remove or mark Disputed md & add StatementIDs
	rec_md_raw xformMD ( rec_md_raw L, FFD.Layouts.PersonContextBatchSlim R ) := transform,
		skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs))) 
			self.StatementIDs := r.StatementIds;
			self.isDisputed :=	r.isDisputed;
			self := L;
	end;
		
															
	md_raw_ds  := join(md_raw_2, slim_pc_recs, 
												 (string)left.persistent_record_id = right.RecID1 and
												 ( 	(left.search_did  = (unsigned) right.lexid) OR 
														(right.acctno = FFD.Constants.SingleSearchAcctno) 
												 )and 
												 right.DataGroup = FFD.Constants.DataGroups.MARRIAGE,
  											 xformMD(left, right), 
												 left outer,
												 keep(1),
												 limit(0));													
	
	md_raw := if(isFCRA,md_raw_ds,md_raw_1);
	
	//-------------------------------------------------------------------------------------------------------													
	

	
	party_raw_1 := join(in_ids, marriage_divorce_v2_Services.keys.search(isFCRA),
										keyed(left.record_id = right.record_id)
										and ~(isFCRA and (string)right.persistent_record_id in set(flags_search((unsigned6)did=left.search_did),record_id)),
										limit(ut.limits.MARRIAGEDIVORCE_PARTY_PER_RECORD)
									);
	
	rec_party_raw := recordof(party_raw_1);
	
	marriage_party_over := join(flags_search, FCRA.key_override_marriage.marriage_search,
									        		keyed(left.flag_file_id = right.flag_file_id) and isFCRA,
											        transform(rec_party_raw,
																self.search_did := (unsigned6)left.did, 
																self := right),
															limit(0));
	
	
  party_raw_2 := party_raw_1 + marriage_party_over;
	
	//---------------------------------------FCRA FFD----------------------------------------------------------------
	
								
	rec_party_raw xformParty ( rec_party_raw L, FFD.Layouts.PersonContextBatchSlim R ) := transform,
	skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs))) 
		self.StatementIDs := r.StatementIds;
		self.isDisputed :=	r.isDisputed;
		self := L;
		self := [];
	end;
	
	party_raw_ds  := join(party_raw_2, slim_pc_recs, 
												(string)left.persistent_record_id = right.RecID1 and
												( 	(left.search_did  = (unsigned) right.lexid) OR 
														(right.acctno = FFD.Constants.SingleSearchAcctno) 
												) and
												right.DataGroup = FFD.Constants.DataGroups.MARRIAGE_SEARCH,
   											xformParty(left, right), 
												left outer,
												keep(1),
												limit(0));	
																			
	party_raw :=  if(isFCRA,party_raw_ds,party_raw_1);
//-------------------------------------------------------------------------------------------------------	

  // check if non-subject suppression was requested
  nss_ind := suppress.constants.NonSubjectSuppression;

  rec_party_raw RestrictNonsubject (rec_party_raw L) := transform
      boolean isSubject := L.did = L.search_did;
    self.record_id := L.record_id;
    self.which_party := L.which_party;
    self.search_did := l.search_did;
    self.lname := if (isSubject, L.lname, fcra.constants.FCRA_Restricted);
    self := if (isSubject, L);
  end;  
                                          
  nss_party := map (nss_val = nss_ind.returnBlank => party_raw (search_did = did),
                    nss_val = nss_ind.returnRestrictedDescription => project (party_raw, RestrictNonsubject (Left)),
                    party_raw);
  
	// populate county_name in party data
	party_fips := join(nss_party, Census_Data.Key_Fips2County,
									left.st<>'' and	left.county<>'' and
									keyed(left.st = right.state_code) and
									keyed(left.county[3..5] = right.county_fips),
									left outer, keep(1), limit(0)
                  );
	// NOTE: Similar to Census_Data.MAC_Fips2County_Keyed, but based on a fractional field


  // combine party info, which is spreaded between multiple parties' records.
  party_grp := group (sort (party_fips, record_id, search_did), record_id, search_did);
  party_rec := recordof (party_grp);
	parties_combo_rec := {l_id; l_cparty p1; l_cparty p2};
  
  l_cparty FormatParty (party_rec party, party_rec party_alias) := transform
		self.csz := if (party.p_city_name = '','', stringlib.Stringcleanspaces(trim(party.p_city_name) + ', ' + party.st + ' ' + party.zip));
		self.addr1 := Address.Addr1FromComponents (party.prim_range, party.predir, party.prim_name, party.suffix,
                                               party.postdir, party.unit_desig, party.sec_range);
		self.name := party.nameasis;
		self.did := if (party.did <> 0,party.did, party_alias.did);
		self.alias := party_alias.nameasis;
    self.StatementIds := party.StatementIDs + party_alias.StatementIDs;
		self.isDisputed := party.IsDisputed or party_alias.IsDisputed;
    self := party;
  end;
  
 parties_combo_rec SetParties (party_rec L, dataset (party_rec) R) := transform
    Self.record_id := L.record_id;
    Self.search_did := L.search_did;
    // at most 1 record of each type:
      p1  := choosen (R (which_party = 'P1'), 1)[1];
      p1a := choosen (R (which_party = 'P1A'), 1)[1];
      p2  := choosen (R (which_party = 'P2'), 1)[1];
      p2a := choosen (R (which_party = 'P2A'), 1)[1];
    Self.p1 := row (FormatParty (p1, p1a));
    Self.p2 := row (FormatParty (p2, p2a));
		Self 		:= []; 
		 
  end;
  party_combo := ROLLUP (party_grp, GROUP, SetParties (Left, rows (Left)));


	// Compute penalties
	penaltyName(params in_mod, l_cparty r) := FUNCTION
		name :=	MODULE(PROJECT(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))	
								EXPORT lastname      	:= it.lname_value.val(in_mod);      
								EXPORT middlename    	:= it.mname_value.val(in_mod);     
								EXPORT firstname     	:= it.fname_value.val(in_mod);      
								EXPORT allow_wildcard := FALSE;
								EXPORT lname_field    := r.lname;						                          
								EXPORT mname_field    := r.mname; 
								EXPORT fname_field    := r.fname; 
						END;
		RETURN AutoStandardI.LIBCALL_PenaltyI_Indv_name.val(name);
	END;

	penalt_addr( params in_mod, l_cparty r) := function
    addr := MODULE(PROJECT(in_mod, AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))
						// The 'input' address:
							EXPORT predir         	:= it.predir_value.val(in_mod);
							EXPORT prim_name      	:= it.pname_value.val(in_mod);
							EXPORT prim_range     	:= it.prange_value.val(in_mod);
							EXPORT postdir        	:= it.postdir_value.val(in_mod);
							EXPORT addr_suffix    	:= it.addr_suffix_value.val(in_mod);
							EXPORT sec_range      	:= it.sec_range_value.val(in_mod);
							EXPORT p_city_name    	:= it.city_value.val(in_mod);
							EXPORT st             	:= it.state_value.val(in_mod); 
							EXPORT z5             	:= it.zip_val.val(in_mod);	
							// The address in the matching record:						
							EXPORT allow_wildcard  	:= FALSE;					
							EXPORT city_field      	:= r.v_city_name;
							EXPORT city2_field     	:= '';
							EXPORT pname_field     	:= r.prim_name;
							EXPORT postdir_field   	:= r.postdir;
							EXPORT prange_field    	:= r.prim_range;
							EXPORT predir_field    	:= r.predir;
							EXPORT state_field     	:= r.st;
							EXPORT suffix_field    	:= r.suffix;
							EXPORT zip_field       	:= r.zip;						
							EXPORT sec_range_field 	:= r.sec_range;
							EXPORT useGlobalScope  	:= FALSE;
						END;				
		return AutoStandardI.LIBCALL_PenaltyI_Addr.val(addr);
	end;
			  	
	penaltyDID(params in_mod, l_cparty r) := FUNCTION
		did_ :=	MODULE(PROJECT(in_mod,AutoStandardI.LIBIN.PenaltyI_DID.full,opt))	
							EXPORT did      := it.did_value.val(in_mod);  
							EXPORT did_field    := (STring) r.did;	 
						END;
		RETURN AutoStandardI.LIBCALL_PenaltyI_DID.val(did_);
	END;

  
  // transform to final layout, calculate penalties. Should I 
 	l_result AttachParties (rec_md_raw L, parties_combo_rec R) := transform
		self.party1 := R.p1;
		self.party2 := R.p2;
		self.state_origin_name := codes.St2Name(L.state_origin);
		
		party1_penalt_E1 := penalt_addr(temp_mod_one,R.p1) + penaltyDID(temp_mod_one,R.p1) + penaltyName(temp_mod_one,R.p1);
		party1_penalt_E2 := penalt_addr(temp_mod_one,R.p2) + penaltyDID(temp_mod_one,R.p2) + penaltyName(temp_mod_one,R.p2);
		
		party1_penalt := if( party1_penalt_E1 <  party1_penalt_E2, party1_penalt_E1,  party1_penalt_E2 );
			
		party2_penalt_E1 :=	penalt_addr(temp_mod_two,R.p1) + penaltyDID(temp_mod_two,R.p1) + penaltyName(temp_mod_two,R.p1);
		party2_penalt_E2 :=	penalt_addr(temp_mod_two,R.p2) + penaltyDID(temp_mod_two,R.p2) + penaltyName(temp_mod_two,R.p2);
		
		party2_penalt := if( party2_penalt_E1 <  party2_penalt_E2, party2_penalt_E1,  party2_penalt_E2 );
		
		self.penalt := if ( isFCRA,0,
												if(gm.TwoPartySearch,max(party1_penalt,party2_penalt),party1_penalt));
		
		isMarriage					:= (L.filing_type='3');
		self.filing_dt			:= if( isMarriage, L.marriage_filing_dt,			L.divorce_filing_dt			);
		self.filing_number	:= if( isMarriage, L.marriage_filing_number,	L.divorce_filing_number	);

		// Everything else
		self := L;
		self := []; //? partyX_name_format, partyX_times_married, partyX_race
	end;
  
  md_val := join (md_raw, party_combo,
                  left.record_id=right.record_id and left.search_did = right.search_did,
                  AttachParties (Left, Right),
                  // transform(compact_party_rec, self.p1:=right.p1, self.p2:=right.p2, self:=left),
                  keep(1), limit (0));
                  
	// sort & dedup
	md_sd := dedup( sort( md_val, penalt, -filing_dt, -marriage_dt, record ) );
	
	// fill in filing_type_name
	k_codes		:= Codes.Key_Codes_V3;
  maxraw		:= 500;
  
	md_ftype := join(md_sd, k_codes,
								keyed(right.file_name='MARRIAGE_DIVORCE') and
								keyed(right.field_name='FILING_TYPE') and
								left.filing_type = right.code,
								transform( l_result, self.filing_type_name := right.long_desc, self := left),
								left outer, limit(maxraw), keep(1)
							);
	
	// fill in party1.party_type_name
	md_ptype1 := join(md_ftype, k_codes,
									keyed(right.file_name='MARRIAGE_DIVORCE') and
									keyed(right.field_name='PARTY1_TYPE') and
									left.party1.party_type = right.code,
									transform( l_result, self.party1.party_type_name := right.long_desc, self := left),
									left outer, limit(maxraw), keep(1)
								);
	
	// fill in party2.party_type_name
	md_ptype2 := join(md_ptype1, k_codes,
									keyed(right.file_name='MARRIAGE_DIVORCE') and
									keyed(right.field_name='PARTY2_TYPE') and
									left.party2.party_type = right.code,
									transform( l_result, self.party2.party_type_name := right.long_desc, self := left),
									left outer, limit(maxraw), keep(1)
								);
	
	// suppress sensitive data
	Suppress.MAC_Suppress(md_ptype2,md_tmp,gm.applicationtype,Suppress.Constants.LinkTypes.DID,party1.did);
	Suppress.MAC_Suppress(md_tmp,md_pulled,gm.applicationtype,Suppress.Constants.LinkTypes.DID,party2.did);
	
	// Debugging
/* 	output( override_can,			named('override_can') );
   	output( md_raw_1,			named('md_raw_1') );
   	output( marriage_over,			named('marriage_over') );
   	output( md_raw,			named('md_raw') );
   	output( party_raw,			named('party_raw') );
   	output( md_val,			named('md_val') );
*/
	
	// output( in_ids,			named('in_ids') );
	//output( party_combo,	named('party_combo') );
	//output(party_raw,named('party_raw') );
	// output( nss_party,		named('nss_party') );
	// output( party_fips,	named('party_fips') );
	// output( md_p1,				named('md_p1') );
	// output( md_p2,				named('md_p2') );
	// output( md_val,			named('md_val') );
	// output( md_sd,				named('md_sd') );
	// output( md_ftype,		named('md_ftype') );
	// output( md_ptype1,		named('md_ptype1') );
	// output( md_ptype2,		named('md_ptype2') );
	// output( md_tmp,			named('md_tmp') );
	// output( md_pulled,		named('md_pulled') );
	// output(md_p2,named('md_p2'));
	// output(md_p2f,named('md_p2f'));
 // output(party_raw,named('party_raw'));
 // output(md_raw,named('md_raw'));
 // output(slim_pc_recs,named('slim_pc_recs'));
	
	return md_pulled;
end;