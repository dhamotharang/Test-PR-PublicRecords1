IMPORT doxie, Census_Data, doxie_cbrs, suppress, codes, BankruptcyV2_Services, FFD;

EXPORT doxie.layout_bk_output_ext GetCRSOutput (
		DATASET (bankrupt.layout_bk_crs_main) bk_main,
		DATASET (bankrupt.layout_bk_crs_search) bk_search,
		unsigned3 dateVal = 0,
		// unsigned1 dppa_purpose = 0, // isn't used
		// unsigned1 glb_purpose = 0,  // isn't used
		STRING6 ssn_mask_value = 'NONE',
		unsigned1 score_threshold_value = 10, //to avoid calling Doxie.MAC_Header_Field_Declare
		boolean IsFCRA = FALSE
	) := FUNCTION

	// ===== Adjust MAIN-FILE to output layout, add court_state
	doxie.layout_bk_output_ext AddFileds (bankrupt.layout_bk_crs_main L) := transform 
		self.court_state := codes.GENERAL.STATE_LONG(l.court_code[1..2]);
		self.filer_type_mapped := '';
		self.debtor_records := []; 
		self := l;
		self := []; // ext fields
	end;
	f_main := project (bk_main((dateVal = 0) OR ((unsigned3)(orig_filing_date[1..6]) <= dateVal)), AddFileds (Left));

	// ===== Ameliorate SEARCH-FILE records
	//can't use it this way, see #22236
	//fetched_noblank := sort (DEDUP (bk_search, ALL), seq_number);
	fetched_noblank := sort (dedup (bk_search, ALL), seq_number);

	// set penalty (non-FCRA only)
	fetched_withblank := record
		fetched_noblank;
		STRING10 blank_field := ''; //to substitute required phone_field in MAC_Header_Result_Rank
	end;
	fetched := project (fetched_noblank, transform (fetched_withblank, SELF := Left));							
								
	doxie.MAC_Header_Result_Rank(debtor_fname,debtor_mname,debtor_lname,
															 debtor_ssn,blank_field,debtor_DID,
															 predir,prim_range,prim_name,suffix,postdir,sec_range,
															 v_city_name,blank_field,st,z5,
															 blank_field,false); //returns dataset outf1 with layout of fetched_withblank + penalty


	fetched_withblank_fcra := record
		unsigned2 penalt := 0;
		fetched_noblank;
		STRING10 blank_field := '';
	end;
	fetched_fcra := project (fetched_noblank, transform (fetched_withblank_fcra, SELF := Left));							


	outf_penalty := IF (IsFCRA, fetched_fcra, outf1);

	// get county
	// TODO: check if we need frca-version of Census_Data.Key_Fips2County
	search_county_rec := record
		unsigned2 penalt;
		bk_search;
		string25  county_name;
	end;

	search_county_rec get_county(outf_penalty l, Census_Data.Key_Fips2County r) := transform
		self.penalt := l.penalt;
		self.county_name := r.county_name;
		self := l;
	end;

	f_search_nomask := join(outf_penalty, Census_Data.Key_Fips2County,
													keyed (left.st = right.state_code) and
													keyed (left.county[3..5] = right.county_fips),
													get_county(left, right),left outer, KEEP (1));

	doxie.MAC_PruneOldSSNs(f_search_nomask, f_search_nomask_pruned, debtor_ssn, debtor_DID);
	doxie_cbrs.mac_mask_ssn(f_search_nomask_pruned, f_search_masked, debtor_ssn)

	// we cannot change (blank/exclude) SSNs for FCRA: exact data we have should be returned
	f_search := IF (IsFCRA, f_search_nomask, f_search_masked);

	//----------------------------- NAME
	search_name_rec := record
		string5   court_code;
		string7   case_number;
		string1   debtor_type1;
		bankrupt.layout_bk_search_name;
	end;

	search_name_rec get_search_names(f_search l) := transform
		self.debtor_type1 := l.debtor_type[1];
		self := l;
	end;

	search_names := project(f_search, get_search_names(left));
	f_search_names_all := dedup(sort(search_names,record),record);
	f_search_names := choosen(group(f_search_names_all,case_number,court_code,debtor_type1),Bankrupt.max_children_constant);

	//----------------------------- ADDRESS
	search_addr_rec := record
		string5   court_code;
		string7   case_number;
		string1   debtor_type1;
		bankrupt.layout_bk_search_addr;
	end;

	search_addr_rec get_search_addrs(f_search l) := transform
		self.debtor_type1 := l.debtor_type[1];
		self := l;
	end;

	search_addrs := project(f_search, get_search_addrs(left));
	f_search_addrs_all := dedup(sort(search_addrs,record),record);
	f_search_addrs := choosen(group(f_search_addrs_all,case_number,court_code,debtor_type1),Bankrupt.max_children_constant);

	doxie.layout_bk_child_ext init_search_out(f_search l):= transform,SKIP(l.debtor_type not in ['P','S'])
		self.names := [];
		self.addresses := [];
		self := l;
	end; 

	search_out_init := project(f_search,init_search_out(left));

	doxie.layout_bk_child_ext addNames(search_out_init l, f_search_names r) := transform
		self.names := l.names + dataset([{r.debtor_title,r.debtor_fname,r.debtor_mname,
																			r.debtor_lname,r.debtor_name_suffix,r.debtor_company}],
										bankrupt.layout_bk_search_name);
		self := l;
	end;

	search_out_prep := denormalize (search_out_init, f_search_names,
																	(left.case_number = right.case_number) and
																	(left.court_code = right.court_code) and
																	(left.debtor_type = right.debtor_type1),
																	addNames(left, right));

	doxie.layout_bk_child_ext addAddrs(search_out_prep l, f_search_addrs r) := transform
		self.addresses := l.addresses + dataset([{r.prim_range,  r.predir,      r.prim_name,
											r.suffix,      r.postdir,     r.unit_desig,
											r.sec_range,   r.p_city_name, r.v_city_name,
											r.st,          r.z5,          r.zip4, 
											r.cart,        r.cr_sort_sz,  r.lot, 
											r.lot_order,   r.dbpc,		  r.chk_digit,
											r.rec_type,    r.county,      r.geo_lat,
											r.geo_long, 	  r.msa,         r.geo_blk,
											r.geo_match,   r.err_stat,    r.county_name}],
														bankrupt.layout_bk_search_addr);
			 self := l;
	end;

	f_search_out := denormalize(search_out_prep, f_search_addrs,
															(left.case_number = right.case_number) and
															(left.court_code = right.court_code) and
															(left.debtor_type = right.debtor_type1),
															addAddrs(left, right));



	// Combine both MAIN- and SEARCH- recs together for final output

	doxie.layout_bk_output_ext addSearch(f_main L, f_search_out R, integer C) := transform
		self.debtor_records := choosen (L.debtor_records + R, BankruptcyV2_Services.layouts.PARTIES_PER_ROLLUP);
		self.penalt := if(C = 1, R.penalt, MIN(L.penalt,R.penalt));
		self := L;
	end;			 

	out_f := denormalize(f_main, f_search_out,
											 (left.case_number = right.case_number) and
											 (left.court_code = right.court_code),
											 addSearch(left, right, counter));

	//Sort by whole record: if input is did only, then penalty are all zero.
	srt_out_f := sort(out_f, whole record);

	srt_out_f trans_bk_code(srt_out_f L) := transform
		self.court_name := codes.BANKRUPTCIES.COURT_CODE(l.court_code);
		self.filer_type_mapped :=  codes.BANKRUPTCIES.FILER_TYPE(l.filer_type);
		self := L;
	end;

	srtout := project(srt_out_f,trans_bk_code(left));
				
	RETURN srtout;

END;
