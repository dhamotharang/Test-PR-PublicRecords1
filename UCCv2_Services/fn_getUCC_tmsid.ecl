// Get UCC data for a set of tmsid records

// code modeled after LiensV2_Services/fn_get_liens_tmsid

import UCCv2, Address, doxie, doxie_raw, ut, fcra, STD, FFD;

MAX_OVERRIDE_LIMIT := FCRA.compliance.MAX_OVERRIDE_LIMIT;

export fn_getUCC_tmsid(
  dataset(UCCv2_services.layout_tmsid) in_tmsids,
	string in_ssn_mask_type,
	boolean IsFCRA = false,
	dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
	dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
	integer8 inFFDOptionsMask = 0
) := function
  
	boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
	boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
	
	doxie.MAC_Header_Field_Declare(IsFCRA); //only: DisplayMatchedParty_value, application_type_value
	k_main	:= UCCV2.Key_Rmsid_Main (IsFCRA);
	k_party	:= UCCV2.Key_Rmsid_Party (IsFCRA);
  
  t_tmsid := typeof (UCCv2_Services.layout_rmsid.tmsid);
  t_rmsid := typeof (UCCv2_Services.layout_rmsid.rmsid);

	// FCRA: overrides
  _party_puids := SET (flagfile (file_id = FCRA.FILE_ID.UCC_PARTY), record_id);
  _party_ffid := SET (flagfile (file_id = FCRA.FILE_ID.UCC_PARTY), flag_file_id);

  _main_puids := SET (flagfile (file_id = FCRA.FILE_ID.UCC), record_id);
  _main_ffid := SET (flagfile (file_id = FCRA.FILE_ID.UCC), flag_file_id);

	// 	GET PARTY INFO FIRST FOR PULL IDS
	uccv2_services.layout_ucc_party_raw xf_party_copy(k_party R) := transform
		self.address1			:= Address.Addr1FromComponents(
														R.prim_range, R.predir, R.prim_name,
														R.suffix, R.postdir, R.unit_desig, R.sec_range);
		self.address2			:= Address.Addr2FromComponents(
														R.v_city_name, R.st, R.zip5);
		self.addr_suffix	:= R.suffix;
	  self							:= R;
	end;
	ds_party_data := join (in_tmsids, k_party,
		keyed (left.tmsid = right.tmsid) and
		(~IsFCRA or ((string)right.persistent_record_id not in _party_puids)),
		xf_party_copy(right),
		limit(10000,skip)
	);

  // overrides (FCRA side only)
  party_override := CHOOSEN (fcra.key_override_ucc.party (keyed (flag_file_id IN _party_ffid)), MAX_OVERRIDE_LIMIT);
  // put overrides into same layout, combine main data and overrides;
  party_override_st := project (party_override, recordof (k_party));
  party_fcra := ds_party_data + project (party_override_st, xf_party_copy (Left));// uccv2_services.layout_ucc_party_raw;

	uccv2_services.layout_ucc_party_raw addPartyStatementIDs(uccv2_services.layout_ucc_party_raw l, FFD.Layouts.PersonContextBatchSlim r) := transform,
		skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs)))
		self.statementids := r.StatementIDs,
		self.isdisputed := r.isdisputed,
		self := l
	end;

	party_fcra_ffd := join(party_fcra, slim_pc_recs(datagroup = FFD.Constants.DataGroups.UCC_PARTY),
		(string)left.persistent_record_id = right.RecID1 and
		(((unsigned)left.did  = (unsigned) right.lexid) OR (right.acctno = FFD.Constants.SingleSearchAcctno))
		, addPartyStatementIDs(left, right), 
		left outer, keep(1), limit(0));

  ds_party_raw := if (IsFCRA, party_fcra_ffd, ds_party_data);
		
	l_k_main := record
		k_main;
		FFD.Layouts.CommonRawRecordElements;
	end;

  // TODO: check if pulling allowed on FCRA side
	tmsids_pulled := fn_pullIDs(ds_party_raw,application_type_value);
	in_tmsids_pulled := project(tmsids_pulled, transform(UCCv2_services.layout_tmsid, self := left));

													
	// ======================================================================= Retrieve filing info
	// join inputs to index to get raw data
	filing_raw_reg := join (in_tmsids_pulled, k_main,
													keyed(left.tmsid = right.tmsid) and
		// keyed (~IsFCRA or (left.rmsid = right.rmsid)) and
                          (~IsFCRA or ((string)right.persistent_record_id not in _main_puids)),
													TRANSFORM(l_k_main,SELf := RIGHT),
													limit(10000,skip)
	                    );
  Doxie_Raw.MAC_ENTRP_CLEAN(filing_raw_reg,filing_date,filing_raw_entrp);
	main_data := IF(ut.industryclass.is_Entrp,filing_raw_entrp,filing_raw_reg);

  // overrides (FCRA side only)
  main_override := CHOOSEN (fcra.key_override_ucc.main (keyed (flag_file_id IN _main_ffid)), MAX_OVERRIDE_LIMIT);
  // put overrides into same layout, combine main data and overrides; TODO: apply FCRA-filtering
  main_override_st := project (main_override, l_k_main);
  main_fcra := (main_data + main_override_st)(fcra.compliance.ucc.is_ok ((string) STD.Date.Today(), orig_filing_date));

	l_k_main addMainStatementIDs(l_k_main l, FFD.Layouts.PersonContextBatchSlim r) := transform,
		skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs)))
		self.statementids := r.StatementIDs,
		self.isdisputed := r.isdisputed,
		self := l
	end;

	main_fcra_ffd := join(main_fcra, slim_pc_recs(datagroup = FFD.Constants.DataGroups.UCC),
		(string)left.persistent_record_id = right.RecID1 and
		((right.acctno = FFD.Constants.SingleSearchAcctno)) // not batch safe
		, addMainStatementIDs(left, right), 
		left outer, keep(1), limit(0));

  filing_raw_ucc := if (IsFCRA, main_fcra_ffd, main_data);


	// ======================================================================= Retrieve history data

  // Filings(history) section layout is now in grandfather/father/grandchild format.

	// First create a temp father dataset/layout from data on the key main file
  temp_father_layout := record
	  k_main.tmsid;              //needed for the grandfather layout & linking to the party file
		k_main.orig_filing_number; //needed for checking to create boolean on the grandfather layout
		k_main.orig_filing_type;   //needed for checking to create boolean on the grandfather layout	
		k_main.orig_filing_date;   //needed for checking to create boolean on the grandfather layout	
		k_main.process_date;   		//needed for keeping most recent filing when matching filing numbers occur.		
		uccv2_services.layout_ucc_hist; // data from main file neeed for final layout
		FFD.Layouts.CommonRawRecordElements;
	end;
	
	temp_father_layout xf_main_copy(l_k_main r) := transform
	  // Create empty "filing_parties" grandchild dataset for now
		self.filing_parties := dataset([],UCCv2_Services.layout_ucc_hist_parties);
		self.isdisputed := r.isdisputed;
		self.statementids := r.statementids;
		// take rest of fields from right (k_main) file
	  self := r;
	end;

	// Get history/filing records/data from main key file
	ds_history_temp_father := project(filing_raw_ucc, xf_main_copy (Left));

	// Next sort records by tmsid and filing date, number, etc.
	// and then dedup identical filings, preserving ones with greatest expiration date.
  ds_history_deduped_father := dedup(sort(ds_history_temp_father, tmsid, 
	                                                                filing_date, 
														  	     					                    filing_number, 
														 				                              filing_type,
																																	-process_date,
														 				                              -expiration_date,
														             			                    record),
													           tmsid, filing_date, filing_number, filing_type);

  // "Filing_Parties" grandchild dataset transform
	UCCv2_Services.layout_ucc_hist_parties xf_party(
                                   UCCv2_Services.layout_ucc_party_raw l) := transform
	   self.party_type_desc := map(l.party_type = 'A' => 'ASSN',
		                             l.party_type = 'C' OR
																 l.party_type = 'S' => 'SECD',
																 l.party_type = 'D' => 'DEBT',
																 l.party_type);
		 self.party_name      := IF(l.company_name<>'',l.company_name,
		                            STD.Str.CleanSpaces(l.fname + ' ' + l.mname + ' ' + l.lname + ' ' + l.name_suffix));
	end;

	temp_father_layout xf_father(temp_father_layout l, dataset(UCCv2_Services.layout_ucc_party_raw) r) := transform
	  // since we keep here only party name and type, we need to remove duplicates:
	  r_dedupped := DEDUP(
		                    SORT(r,party_type,company_name,lname,fname,mname,name_suffix,record),
												party_type,company_name,lname,fname,mname,name_suffix);
	 // Fill in "filing_parties" grandchild dataset 
		self.filing_parties := project(
		                       choosen(r_dedupped,UCCv2_Services.Constants.MAXCOUNT_FILING_PARTIES),
													 xf_party(left));
		
		self.isdisputed := l.isdisputed;
		self.statementids := l.statementids;
	  self := l;
	end;
		
	// Next use a denormalize/group to fill in the filing_parties info.
	ds_history_denormed_father := denormalize(ds_history_deduped_father,ds_party_raw,
		                                      left.tmsid = right.tmsid and
		                                      fn_remove_DNB_rmsid_seq(left.rmsid,left.tmsid) = right.rmsid,
		                                      group,
																					xf_father(left,rows(right)));
  
  // Re-sort after denormalize to put records back in proper order 
	// by tmsid and recency (descending on filing date, number, etc.).
	ds_history_resorted_father := sort(ds_history_denormed_father, tmsid, 
	                                                               -filing_date, 
														  	     					                   -filing_number, 
														 				                             -filing_type,
														 				                             -expiration_date,
														             			                   record);

  // Next create grandfather dataset/layout
	temp_hist_layout := record
		boolean isValidFiling;
	  k_main.tmsid;
		dataset(uccv2_services.layout_ucc_hist) filings{maxcount(UCCv2_Services.Constants.MAXCOUNT_RAW)};
		FFD.Layouts.CommonRawRecordElements;
	end;
	
	temp_hist_layout xf_history_copy(temp_father_layout r) := transform
		self.isValidFiling := if(
			r.filing_number <> '' or r.filing_date <> '' or r.filing_type <> '' or
				r.orig_filing_number <> '' or r.orig_filing_date <> '' or r.orig_filing_type <> '',
			true,
			skip
		);
		self.tmsid := r.tmsid;
	  self.filings := dataset(
			[{
				r.rmsid,
				r.filing_number,
				r.filing_type,
				r.filing_date,
				r.filing_status,
				r.status_type,
				r.page,
				r.expiration_date,
				r.contract_type,
				r.amount,
				r.irs_serial_number,
				r.effective_date,
				r.filing_parties
			}],
			uccv2_services.layout_ucc_hist);
		self.statementids := r.statementids;
		self.isdisputed := r.isdisputed;
	end;

  // Use project to create grandfather 
	ds_history_sort := project(ds_history_resorted_father,xf_history_copy(left));
	
	// Rollup by tmsid
	ds_history_sort xf_hist_rollup_1(ds_history_sort l, ds_history_sort r) := transform
		self.filings := choosen(l.filings + r.filings,UCCv2_Services.Constants.MAXCOUNT_FILINGS);
		self.statementids := dedup(l.statementids + r.statementids, all);
		self.isdisputed := l.isdisputed or r.isdisputed;
		self := l;
	end;
	
	ds_history_rolled := rollup(
		ds_history_sort,
		left.tmsid = right.tmsid,
		xf_hist_rollup_1(left,right)
	);


	// ======================================================================= Retrieve signer data
	
	// Get signer records from key
	temp_signer_layout := record
	  k_main.tmsid;
		dataset(uccv2_services.layout_ucc_signer) signers{maxcount(UCCv2_Services.Constants.MAXCOUNT_SIGNERS)};
	end;
	temp_signer_layout xf_signer_copy(l_k_main r) := transform
		self.tmsid := r.tmsid;
	  self.signers := dataset(
			[{
				r.signer_name,
				r.title
			}],
			uccv2_services.layout_ucc_signer);
	end;
	ds_signers_raw := project(filing_raw_reg, xf_signer_copy (Left));

	// Sort signer records by tmsid
	ds_signers_sort := sort(ds_signers_raw, tmsid);

	// Rollup by tmsid
	ds_signers_sort xf_signer_rollup_1(ds_signers_sort l, ds_signers_sort r) := transform
	  self.tmsid := l.tmsid;
		self.signers := choosen(l.signers + r.signers,UCCv2_Services.Constants.MAXCOUNT_SIGNERS);
	end;
	ds_signers_roll := rollup(
		ds_signers_sort,
		left.tmsid = right.tmsid,
		xf_signer_rollup_1(left,right)
	);
	
	// and dedup identical filings
	ds_signers_roll xf_signer_rollup_2(ds_signers_roll L) := transform
	  self.tmsid   := L.tmsid;
		validSigners := L.signers(signer_name <> '' or title <> '');
		self.signers := dedup( sort(validSigners, record)	);
	end;
	ds_signers_rolled := project(ds_signers_roll, xf_signer_rollup_2(left));


	// ======================================================================= Retrieve Filing Office data
	
	// Get filofc records from key
	temp_filofc_layout := record
	  k_main.tmsid;
		dataset(uccv2_services.layout_ucc_filofc) filing_offices{maxcount(UCCv2_Services.Constants.MAXCOUNT_FILING_OFFICES)};
	end;
	temp_filofc_layout xf_filofc_copy(l_k_main r) := transform
		self.tmsid := r.tmsid;
	  self.filing_offices := dataset(
			[{
				r.filing_agency,
				r.address,
				r.city,
				r.state,
				r.county,
				r.zip
			}],
			uccv2_services.layout_ucc_filofc);
	end;
	ds_filofc_raw := project (filing_raw_reg, xf_filofc_copy (Left));

	// Sort filofc records by tmsid
	ds_filofc_sort := sort(ds_filofc_raw, tmsid);

	// Rollup by tmsid
	ds_filofc_sort xf_filofc_rollup_1(ds_filofc_sort l, ds_filofc_sort r) := transform
	  self.tmsid := l.tmsid;
		self.filing_offices := choosen(l.filing_offices + r.filing_offices,UCCv2_Services.Constants.MAXCOUNT_FILING_OFFICES);
	end;
	ds_filofc_roll := rollup(
		ds_filofc_sort,
		left.tmsid = right.tmsid,
		xf_filofc_rollup_1(left,right)
	);
	
	// and dedup identical filings
	ds_filofc_roll xf_filofc_rollup_2(ds_filofc_roll L) := transform
	  self.tmsid   := L.tmsid;
		validOffices := L.filing_offices(
			filing_agency <> '' OR
				address <> '' OR
				city <> '' OR
				state <> '' OR
				county <> '' OR
				zip <> ''
		);
		self.filing_offices := dedup( sort(validOffices, record)	);
	end;
	ds_filofc_rolled := project(ds_filofc_roll, xf_filofc_rollup_2(left));


	// ======================================================================= Retrieve Collateral data
	
	// Get collateral records from key
	temp_coll_layout := record
	  k_main.tmsid;
		dataset(uccv2_services.layout_ucc_coll) collateral{maxcount(UCCv2_Services.Constants.MAXCOUNT_RAW)};
	end;
	temp_coll_layout xf_coll_copy(l_k_main r) := transform
		self.tmsid := r.tmsid;
	  self.collateral := dataset(
			[{
			  // Temp fix for bug 33695 to store the filing_date (formatted in mm/dd/yyyy format) 
				// and filing_number at the front of collateral_desc field before the actual
				// collateral text.  
				// Once ESP & WEB can handle the additional separate r.filing_number and 
				// r.filing_date fields, this temp fix can be removed.
				if(r.collateral_desc<>'',if(r.filing_date<>'',r.filing_date[5..6] + '/' +  //mm
				                                              r.filing_date[7..8] + '/' +  //dd
																                      r.filing_date[1..4] + ' ' + //yyyy
				                                              trim(r.filing_number,left,right) + 
																											' - ' + r.collateral_desc,
				                                           if(r.orig_filing_date<>'',
																		                  r.orig_filing_date[5..6] + '/' +  //mm
				                                              r.orig_filing_date[7..8] + '/' +  //dd
																                      r.orig_filing_date[1..4] + ' ' + //yyyy
				                                              trim(r.orig_filing_number,left,right) + 
																											' - ' + r.collateral_desc,
																			                r.collateral_desc)),
																	  ''),
				/* Commented out line below is for future use once the ESP & WEB areas can handle
				   the new r.filing_number & r.filing_date fields added below.
        r.collateral_desc,
				*/
				r.collateral_count,
				r.serial_number,
				r.property_desc,
				r.collateral_address,
				if(r.filing_number<>'',r.filing_number,r.orig_filing_number), 
				if(r.filing_date<>'',r.filing_date,r.orig_filing_date)
			}],
			uccv2_services.layout_ucc_coll);
	end;
	ds_coll_nonempty := filing_raw_reg (collateral_desc <> '' OR collateral_count <> '' OR
																			serial_number <> '' OR property_desc <> '' OR
																			collateral_address <> '');
	ds_coll_raw := project (ds_coll_nonempty, xf_coll_copy(Left));

	// Sort collateral records by tmsid and descending on filing_date then filing_number 
	// then dedup on the same fields.
  ds_coll_sort := dedup(sort(ds_coll_raw, tmsid,
	                                        -collateral[1].filing_date, 
																					-collateral[1].filing_number,
																					record),
												tmsid,collateral[1].filing_date,collateral[1].filing_number);

	// Rollup by tmsid
	ds_coll_sort xf_coll_rollup_1(ds_coll_sort l, ds_coll_sort r) := transform
	  self.tmsid := l.tmsid;
		self.collateral := choosen(l.collateral + r.collateral,UCCv2_Services.Constants.MAXCOUNT_COLLATERAL);
	end;
	
	ds_coll_rolled := rollup(
		ds_coll_sort,
		left.tmsid = right.tmsid,
		xf_coll_rollup_1(left,right)
	);


	// ======================================================================= Format party data

	ds_debtor_formatted		:= fn_format_parties(ds_party_raw, 'D', in_ssn_mask_type, IsFCRA);
	ds_secured_formatted	:= fn_format_parties(ds_party_raw, 'S', in_ssn_mask_type, IsFCRA);
	ds_assignee_formatted := fn_format_parties(ds_party_raw, 'A', in_ssn_mask_type, IsFCRA);
	ds_creditor_formatted := fn_format_parties(ds_party_raw, 'C', in_ssn_mask_type, IsFCRA);

  layout_party := RECORD
	  layout_ucc_party_raw_src.tmsid;
	  DATASET(UCCv2_Services.layout_ucc_party) parties{maxcount(25)};
		unsigned2 penalt;
	END;
	
	party_rec := RECORD
		string1 name_type;
		layout_party;
	END;
	
	party_rec xfm_partyType(layout_party l, string1 name_type) := TRANSFORM
		SELF.name_type := name_type;
		SELF := l;
	END;
	
	formatted_parties := DEDUP(SORT(PROJECT(ds_debtor_formatted,xfm_partyType(LEFT,'0'))
	                               + 
																 PROJECT(ds_secured_formatted,xfm_partyType(LEFT,'1'))
																 + 
																 PROJECT(ds_assignee_formatted,xfm_partyType(LEFT,'2'))
																 + 
																 PROJECT(ds_creditor_formatted,xfm_partyType(LEFT,'3'))
																 ,tmsid,penalt,name_type,record),tmsid);
	
	
		// TRANSFORM TO PRIME THE RESULT DATASET
	
	// ======================================================================= Assimilate data
	// First, rollup filings
	// define a temporary layout
	temp_filing_layout := record
		uccv2_services.layout_ucc_filing;
		FFD.Layouts.CommonRawRecordElements;
	end;
	temp_filing_layout toFiling(l_k_main r) := transform
		self.filing_jurisdiction_name := UCCv2_Services.jur2Name(r.filing_jurisdiction);
		self.filing_status := dataset( [{ r.filing_status, r.status_type }], UCCv2_Services.layout_filing_status );
	  self := r;
	end;

	Filing_raw := PROJECT(filing_raw_ucc,toFiling(LEFT));

	// sort by tmsid and recency
	filing_sort := sort(filing_raw, tmsid, -orig_filing_date, -orig_filing_number, orig_filing_type);

	// rollup by tmsid (preferring recent data)
	filing_sort toRollup(filing_sort l, filing_sort r) := transform
	  self.tmsid							:= l.tmsid;
		self.filing_jurisdiction:= if(l.filing_jurisdiction='',	r.filing_jurisdiction,	l.filing_jurisdiction);
		self.filing_jurisdiction_name:= if(l.filing_jurisdiction_name='',	r.filing_jurisdiction_name,	l.filing_jurisdiction_name);
		self.orig_filing_number	:= if(l.orig_filing_number='',	r.orig_filing_number,		l.orig_filing_number);
		self.orig_filing_type		:= if(l.orig_filing_type='',		r.orig_filing_type,			l.orig_filing_type);
		self.orig_filing_date		:= if(l.orig_filing_date='',		r.orig_filing_date,			l.orig_filing_date);
		self.filing_status			:= if(exists(l.filing_status),	l.filing_status,				r.filing_status);
		self.statementids 			:= l.statementids + r.statementids;
		self.isdisputed 				:= l.isdisputed or r.isdisputed;
	end;      
	ds_filing_rolled := rollup(
		filing_sort,
		left.tmsid = right.tmsid,
		toRollup(left,right)
	);

	// Prime the result dataset
	uccv2_services.layout_ucc_rollup xf_project_filing_info(ds_filing_rolled L) := transform
		self.penalt := uccPenalty.large;
		bp := formatted_parties(tmsid=l.tmsid)[1];
		SELf.matched_party.party_type := if(DisplayMatchedParty_value,MAP(bp.name_type ='0' => 'D'
		                            ,bp.name_type ='1' => 'S'
																,bp.name_type ='2' => 'A'
																,'C'),'');
		SELf.matched_party.parsed_party :=if(DisplayMatchedParty_value
		                                     ,PROJECT(bp.parties[1].parsed_parties
		                                     ,UCCv2_Services.assorted_layouts.matched_party_name_rec)[1]
																				 );
		SELf.matched_party.address := if(DisplayMatchedParty_value
		                                ,PROJECT(bp.parties[1].addresses
		                                ,UCCv2_Services.assorted_layouts.matched_party_address_rec)[1]);
		SELF.matched_party := if(DisplayMatchedParty_value,bp.parties[1]);																
		self.statementids := L.statementids;
		self.isdisputed := L.isdisputed;
		self := L;
		self := [];
	end;
	
	ds_primed_rollup := project(ds_filing_rolled, xf_project_filing_info(left));
	
	// Join the debtor information
	ds_primed_rollup xf_join_debtors(ds_primed_rollup L, ds_debtor_formatted R) := transform
	  self.debtors := choosen(R.parties,25);
		UCCv2_Services.mac_PickPenalty()
		self := L;
	end;
	ds_primed_rollup_dXXXX := join(
		ds_primed_rollup, ds_debtor_formatted,
		left.tmsid = right.tmsid,
		xf_join_debtors(left,right),
		left outer,
		keep(10000)
	);

	// Join the secured information
	ds_primed_rollup xf_join_secureds(ds_primed_rollup L, ds_secured_formatted R) := transform
	  self.secureds := choosen(R.parties,10);
		UCCv2_Services.mac_PickPenalty()
		self := L;
	end;
	ds_primed_rollup_dsXXX := join(
		ds_primed_rollup_dXXXX, ds_secured_formatted,
		left.tmsid = right.tmsid,
		xf_join_secureds(left,right),
		left outer,
		keep(10000)
	);

	// Join the assignee information
	ds_primed_rollup xf_join_assignees(ds_primed_rollup L, ds_assignee_formatted R) := transform
	  self.assignees := choosen(R.parties,10);
		UCCv2_Services.mac_PickPenalty()
		self := L;
	end;
	ds_primed_rollup_dsaXX := join(
		ds_primed_rollup_dsXXX, ds_assignee_formatted,
		left.tmsid = right.tmsid,
		xf_join_assignees(left,right),
		left outer,
		keep(10000)
	);

	// Join the creditor information
	ds_primed_rollup xf_join_creditors(ds_primed_rollup L, ds_creditor_formatted R) := transform
	  self.creditors := choosen(R.parties,10);
		UCCv2_Services.mac_PickPenalty()
		self := L;
	end;
	ds_primed_rollup_dsacX := join(
		ds_primed_rollup_dsaXX, ds_creditor_formatted,
		left.tmsid = right.tmsid,
		xf_join_creditors(left,right),
		left outer,
		keep(10000)
	);

	// Join the history information
	ds_primed_rollup xf_join_history(ds_primed_rollup l, ds_history_rolled r) := transform
	  self.filings := choosen(r.filings,UCCv2_Services.Constants.MAXCOUNT_FILINGS);
		self := l;
	end;
	ds_primed_rollup_dsach := join(
		ds_primed_rollup_dsacX, ds_history_rolled,
	  left.tmsid = right.tmsid,
		xf_join_history(left,right),
		left outer,
		keep(10000)
	);

	// Join the signer information
	ds_primed_rollup xf_join_signers(ds_primed_rollup l, ds_signers_rolled r) := transform
	  self.signers := choosen(r.signers,UCCv2_Services.Constants.MAXCOUNT_SIGNERS);
		self := l;
	end;
	ds_primed_rollup_dsachs := join(
		ds_primed_rollup_dsach, ds_signers_rolled,
	  left.tmsid = right.tmsid,
		xf_join_signers(left,right),
		left outer,
		keep(10000)
	);

	// Join the filing office information
	ds_primed_rollup xf_join_filofc(ds_primed_rollup l, ds_filofc_rolled r) := transform
	  self.filing_offices := choosen(r.filing_offices,UCCv2_Services.Constants.MAXCOUNT_FILING_OFFICES);
		self := l;
	end;
	ds_primed_rollup_dsachsf := join(
		ds_primed_rollup_dsachs, ds_filofc_rolled,
	  left.tmsid = right.tmsid,
		xf_join_filofc(left,right),
		left outer,
		keep(10000)
	);
	
	// Join the collateral information
	ds_primed_rollup xf_join_coll(ds_primed_rollup l, ds_coll_rolled r) := transform
	  self.collateral := choosen(r.collateral,UCCv2_Services.Constants.MAXCOUNT_COLLATERAL);
		self := l;
	end;
	ds_primed_rollup_dsachsfc := join(
		ds_primed_rollup_dsachsf, ds_coll_rolled,
	  left.tmsid = right.tmsid,
		xf_join_coll(left,right),
		left outer,
		keep(10000)
	);

  // output(filing_raw_ucc, named('filing_raw_ucc'));	                // DEBUG
	
  // output(in_tmsids,	                named('in_tmsids'));	                // DEBUG
  // output(tmsids_pulled,	            named('tmsids_pulled'));	            // DEBUG
  // output(in_tmsids_pulled,	          named('in_tmsids_pulled'));	          // DEBUG
	// output( ds_party_raw,               named('ds_party_raw') );							// DEBUG
	// output( ds_filing_rolled, 					named('ds_filing_rolled') );				  // DEBUG
	// output( ds_history_temp_father,     named('ds_htpf') );										// DEBUG
	// output( ds_history_deduped_father,  named('ds_hddf') );								    // DEBUG
	// output( ds_history_denormed_father, named('ds_hdnf') );		 						    // DEBUG
	// output( ds_history_resorted_father, named('ds_hrsf') );								    // DEBUG
	// output( ds_history_sort,            named('ds_history_sort') );						// DEBUG	
	// output( ds_history_rolled, 				  named('ds_history_rolled') );					// DEBUG
	// output( ds_signers_rolled, 				named('ds_signers_rolled') );					// DEBUG
	// output( ds_debtor_formatted,				named('ds_debtor_formatted') );				// DEBUG
	// output( ds_secured_formatted,			named('ds_secured_formatted') );			// DEBUG
	// output( ds_assignee_formatted,			named('ds_assignee_formatted') );			// DEBUG
	// output( ds_creditor_formatted,			named('ds_creditor_formatted') );			// DEBUG
	// output( ds_primed_rollup,					named('ds_primed_rollup') );					// DEBUG
	// output( ds_primed_rollup_dXXXX, 		named('ds_primed_rollup_dXXXX') );		// DEBUG
	// output( ds_primed_rollup_dsXXX, 		named('ds_primed_rollup_dsXXX') );		// DEBUG
	// output( ds_primed_rollup_dsaXX, 		named('ds_primed_rollup_dsaXX') );		// DEBUG
	// output( ds_primed_rollup_dsacX,		named('ds_primed_rollup_dsacX') );		// DEBUG
	// output( ds_primed_rollup_dsach, 		named('ds_primed_rollup_dsach') );		// DEBUG
	// output( ds_primed_rollup_dsachsfc,	named('ds_primed_rollup_dsachsfc') );	// DEBUG

	// RETURN THE ROLLED UP DATA
	return( sort(ds_primed_rollup_dsachsfc,-orig_filing_date,record) );
end;
