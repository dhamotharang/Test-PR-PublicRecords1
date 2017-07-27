// Get UCC data for a set of rmsid records

// code modeled after LiensV2_Services.fn_get_liens_rmsid

import UCCv2, Address;

export fn_getUCC_rmsid(
  dataset(UCCv2_services.layout_rmsid) in_rmsids,
	string in_ssn_mask_type,
	BOOLEAN return_multiple_pages = FALSE,
	string32 appType
) := function

	in_tmsids := dedup( sort( project(in_rmsids, UCCv2_services.layout_tmsid), record ) );

	k_main	:= UCCV2.Key_Rmsid_Main ();
	k_party	:= UCCV2.Key_Rmsid_Party ();

	// 	GET PARTY INFO FIRST FOR PULL IDS
	uccv2_services.layout_ucc_party_raw_src xf_party_copy(k_party R) := transform
		self.address1			:= Address.Addr1FromComponents(
														R.prim_range, R.predir, R.prim_name,
														R.suffix, R.postdir, R.unit_desig, R.sec_range);
		self.address2			:= Address.Addr2FromComponents(
														R.v_city_name, R.st, R.zip5);
		self.addr_suffix	:= R.suffix;
	  self							:= R;
	end;
	ds_party_raw := join(
		in_tmsids, k_party,
		keyed(left.tmsid = right.tmsid),
		xf_party_copy(right),
		limit(10000,skip)
	);

	tmsids_pulled := fn_pullIDs(project(ds_party_raw,uccv2_services.layout_ucc_party_raw),appType);
	in_tmsids_pulled := join(in_tmsids, tmsids_pulled, left.tmsid = right.tmsid, 
														transform(UCCv2_services.layout_tmsid, self := left));
	
	
	// ======================================================================= Retrieve filing info

	// define a temporary layout to allow sorting for most recent filing for a tmsid.
	k_main_lay := uccv2.layout_UCC_common.layout_ucc_new;
	temp_filing_layout := RECORD
			uccv2_services.layout_ucc_filing_src;
			k_main_lay.filing_number;
			k_main_lay.filing_type;
			k_main_lay.filing_date;
	END;

	temp_filing_layout toFiling(k_main r) := transform
		self.filing_jurisdiction_name := UCCv2_Services.jur2Name(r.filing_jurisdiction);
		self.filing_status := dataset( [{ r.filing_status, r.status_type }], UCCv2_Services.layout_filing_status );
	  self := r;
	end;

	// join inputs to index to get raw data
	filing_raw := join(
		in_tmsids_pulled, k_main,
	  keyed(left.tmsid = right.tmsid),
		toFiling(right),
		limit(10000,skip)
	);

	// sort by tmsid and recency
	filing_sort := sort(filing_raw, tmsid, -filing_date, -filing_number, filing_type, RECORD);
	
	// rollup by tmsid (preferring recent data)
	filing_sort toRollup(filing_sort l, filing_sort r) := transform
	  self.tmsid							:= l.tmsid;
		self.filing_jurisdiction:= if(l.filing_jurisdiction='',	r.filing_jurisdiction,	l.filing_jurisdiction);
		self.filing_jurisdiction_name:= if(l.filing_jurisdiction_name='',	r.filing_jurisdiction_name,	l.filing_jurisdiction_name);
		self.orig_filing_number	:= if(l.orig_filing_number='',	r.orig_filing_number,		l.orig_filing_number);
		self.orig_filing_type		:= if(l.orig_filing_type='',		r.orig_filing_type,			l.orig_filing_type);
		self.orig_filing_date		:= if(l.orig_filing_date='',		r.orig_filing_date,			l.orig_filing_date);
		self.orig_filing_time		:= if(l.orig_filing_time='',		r.orig_filing_time,			l.orig_filing_time);
		self.filing_status			:= if(exists(l.filing_status),	l.filing_status,				r.filing_status);
		self.cmnt_effective_date:= if(l.cmnt_effective_date='',	r.cmnt_effective_date,	l.cmnt_effective_date);
		self.description				:= if(l.description='',					r.description,					l.description);
		self.filing_number := '';
		self.filing_type := '';
		self.filing_date := '';
	end;      
	ds_filing_rolled := rollup(
		filing_sort,
		left.tmsid = right.tmsid,
		toRollup(left,right)
	);


	// ======================================================================= Retrieve history data

  // Filings(history) section layout is now in grandfather/father/grandchild format.

	// First create a temp father dataset/layout from data on the key main file
  temp_father_layout := record
	  k_main.tmsid;              //needed for the grandfather layout & linking to the party file
		k_main.orig_filing_number; //needed for checking to create boolean on the grandfather layout
		k_main.orig_filing_type;   //needed for checking to create boolean on the grandfather layout	
		k_main.orig_filing_date;   //needed for checking to create boolean on the grandfather layout	
		k_main.process_date;   		//needed for keeping most recent filing when matching filing numbers occur.	
		uccv2_services.layout_ucc_hist_src; // data from main file neeed for final layout
	end;
	
	temp_father_layout xf_main_copy(k_main r) := transform
	  // Create empty "filing_parties" grandchild dataset for now
		self.filing_parties := dataset([],UCCv2_Services.layout_ucc_hist_parties);
		// take rest of fields from right (k_main) file
	  self := r;
	end;

	// Get history/filing records/data from main key file
	ds_history_temp_father := join(
		in_tmsids_pulled, k_main,
		keyed(left.tmsid = right.tmsid),
		xf_main_copy(right),
		limit(10000,skip)
	);

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
                                   UCCv2_Services.layout_ucc_party_raw_src l) := transform
	   self.party_type_desc := map(l.party_type = 'A' => 'ASSN',
		                             l.party_type = 'C' OR
																 l.party_type = 'S' => 'SECD',
																 l.party_type = 'D' => 'DEBT',
																 l.party_type);
		 self.party_name      := IF(l.company_name<>'',l.company_name,
		                            trim(trim(l.fname,left,right) + ' ' + 
																     trim(l.mname,left,right) + ' ' + 
																     trim(l.lname,left,right) + ' ' + 
																     trim(l.name_suffix,left,right),left,right));
	end;

	temp_father_layout xf_father(temp_father_layout l, dataset(UCCv2_Services.layout_ucc_party_raw_src) r) := transform
	 // Fill in "filing_parties" grandchild dataset 
		self.filing_parties := project(
		                       choosen(r,UCCv2_Services.Constants.MAXCOUNT_FILING_PARTIES),
													 xf_party(left));
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
		dataset(uccv2_services.layout_ucc_hist_src) filings{maxcount(UCCv2_Services.Constants.MAXCOUNT_RAW)};
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
				r.filing_number_indc,
				r.filing_type,
				r.filing_date,
				r.filing_time,
				r.filing_status,
				r.status_type,
				r.page,
				r.expiration_date,
				r.contract_type,
				r.vendor_entry_date,
				r.vendor_upd_date,
				r.statements_filed,
				r.continuious_expiration,
				r.microfilm_number,
				r.amount,
				r.irs_serial_number,
				r.effective_date,
				r.filing_parties
			}],
			uccv2_services.layout_ucc_hist_src);
	end;

  // Use project to create grandfather
  ds_history_sort := project(ds_history_resorted_father,xf_history_copy(left));

	// Rollup by tmsid
	ds_history_sort xf_hist_rollup_1(ds_history_sort l, ds_history_sort r) := transform
		self.filings := choosen(l.filings + r.filings,UCCv2_Services.Constants.MAXCOUNT_FILINGS);
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
	temp_signer_layout xf_signer_copy(k_main r) := transform
		self.tmsid := r.tmsid;
	  self.signers := dataset(
			[{
				r.signer_name,
				r.title
			}],
			uccv2_services.layout_ucc_signer);
	end;
	ds_signers_raw := join(
		in_tmsids_pulled, k_main,
		keyed(left.tmsid = right.tmsid),
		xf_signer_copy(right),
		limit(10000,skip)
	);

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
	temp_filofc_layout xf_filofc_copy(k_main r) := transform
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
	ds_filofc_raw := join(
		in_tmsids_pulled, k_main,
		keyed(left.tmsid = right.tmsid),
		xf_filofc_copy(right),
		limit(10000,skip)
	);

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
		dataset(uccv2_services.layout_ucc_coll_src) collateral{maxcount(UCCv2_Services.Constants.MAXCOUNT_RAW)};
	end;

	temp_coll_layout xf_coll_copy(k_main r) := transform
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
				r.prim_machine,
				r.sec_machine,
				r.manufacturer_code,
				r.manufacturer_name,
				r.model,
				r.model_year,
				r.model_desc,
				r.collateral_count,
				r.manufactured_year,
				r.new_used,
				r.serial_number,
				r.property_desc,
				r.borough,
				r.block,
				r.lot,
				r.collateral_address,
				r.air_rights_indc,
				r.subterranean_rights_indc,
				r.easment_indc, 
				if(r.filing_number<>'',r.filing_number,r.orig_filing_number), 
				if(r.filing_date<>'',r.filing_date,r.orig_filing_date)		
			}],
			uccv2_services.layout_ucc_coll_src);
	end;

	ds_coll_raw := join(
		in_tmsids_pulled, k_main,
		keyed(left.tmsid = right.tmsid)
		AND 
		(right.	collateral_desc <> '' OR
		 right.collateral_count <> '' OR
		 right.serial_number <> '' OR
		 right.property_desc <> '' OR
		 right.collateral_address <> ''),
		xf_coll_copy(right),
		limit(10000,skip)
	);

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

  ds_coll_rolled := rollup(ds_coll_sort, left.tmsid = right.tmsid, xf_coll_rollup_1(left,right));


	// ======================================================================= format party data
	ds_debtor_formatted		:= fn_format_parties_src(ds_party_raw, 'D', in_ssn_mask_type, UCCv2_Services.Constants.MAXCOUNT_DEBTORS, return_multiple_pages);
	ds_secured_formatted	:= fn_format_parties_src(ds_party_raw, 'S', in_ssn_mask_type, UCCv2_Services.Constants.MAXCOUNT_SECUREDS, return_multiple_pages);
	ds_assignee_formatted := fn_format_parties_src(ds_party_raw, 'A', in_ssn_mask_type, UCCv2_Services.Constants.MAXCOUNT_ASSIGNEES, return_multiple_pages);
	ds_creditor_formatted := fn_format_parties_src(ds_party_raw, 'C', in_ssn_mask_type, UCCv2_Services.Constants.MAXCOUNT_CREDITORS, return_multiple_pages);
	
	// ======================================================================= determine max pages

	// Determine the number of pages (i.e. records) that the system must return. We need to determine this 
	// beforehand, since we'll be joining all of the record sections based on tmsid and page_no.
	
	rec_max_pages_per_filing := RECORD
		uccv2_services.layout_ucc_filing_src;
		INTEGER max_pages;
	END;

	rec_max_pages_per_filing xfm_determine_max_pages(ds_filing_rolled l) :=
		TRANSFORM
			SELF.max_pages := MAX( MAX(ds_debtor_formatted(tmsid = l.tmsid), page_no),
														 MAX(ds_secured_formatted(tmsid = l.tmsid), page_no),
														 MAX(ds_assignee_formatted(tmsid = l.tmsid), page_no),
														 MAX(ds_creditor_formatted(tmsid = l.tmsid), page_no)		
														);
			SELF           := l;
		END;
		
	ds_tmsids_with_max_pages := PROJECT(ds_filing_rolled, xfm_determine_max_pages(LEFT));

	rec_filing_with_page_no := RECORD
		uccv2_services.layout_ucc_filing_src;
		INTEGER page_no;
	END;
	
	ds_party_recs_seed := NORMALIZE(ds_tmsids_with_max_pages, 
																 LEFT.max_pages, 
																 TRANSFORM(rec_filing_with_page_no,
																					 SELF.tmsid    := LEFT.tmsid;
																					 SELF.page_no  := COUNTER;
																					 SELF          := LEFT;)
																);

	// ======================================================================= Assimilate data

	layout_ucc_rollup_src_with_page_no := RECORD
		uccv2_services.layout_ucc_rollup_src;
		INTEGER page_no;
	END;
	
	// Prime the result dataset
	layout_ucc_rollup_src_with_page_no xf_project_filing_info(ds_party_recs_seed L, ds_filing_rolled R) := transform
		SELF.tmsid   := l.tmsid;
		SELF.page_no := l.page_no;	
		self.penalt  := uccPenalty.large;
		self := R;
		self := [];
	end;
	
	ds_primed_rollup_XXXXX := JOIN(ds_party_recs_seed, ds_filing_rolled,
	                                left.tmsid = right.tmsid AND
	                                LEFT.page_no = 1,
	                                xf_project_filing_info(left,right),
	                                left outer,
	                                keep(10000));
	
	// Join the debtor information
	layout_ucc_rollup_src_with_page_no xf_join_debtors(layout_ucc_rollup_src_with_page_no L, ds_debtor_formatted R) := transform
		SELF.tmsid   := l.tmsid;
		SELF.page_no := l.page_no;
	  self.debtors := R.parties;
		UCCv2_Services.mac_PickPenalty()
		self := L;
	end;
	ds_primed_rollup_dXXXX := join(
		ds_primed_rollup_XXXXX, ds_debtor_formatted,
		left.tmsid = right.tmsid AND
		LEFT.page_no = RIGHT.page_no,
		xf_join_debtors(left,right),
		left outer,
		keep(10000)
	);

	// Join the secured information
	layout_ucc_rollup_src_with_page_no xf_join_secureds(layout_ucc_rollup_src_with_page_no L, ds_secured_formatted R) := transform
		SELF.tmsid   := l.tmsid;
		SELF.page_no := l.page_no;	
	  self.secureds := R.parties;
		UCCv2_Services.mac_PickPenalty()
		self := L;
	end;
	ds_primed_rollup_dsXXX := join(
		ds_primed_rollup_dXXXX, ds_secured_formatted,
		left.tmsid = right.tmsid AND
		LEFT.page_no = RIGHT.page_no,
		xf_join_secureds(left,right),
		left outer,
		keep(10000)
	);

	// Join the assignee information
	layout_ucc_rollup_src_with_page_no xf_join_assignees(layout_ucc_rollup_src_with_page_no L, ds_assignee_formatted R) := transform
		SELF.tmsid   := l.tmsid;
		SELF.page_no := l.page_no;	
	  self.assignees := R.parties;
		UCCv2_Services.mac_PickPenalty()
		self := L;
	end;
	ds_primed_rollup_dsaXX := join(
		ds_primed_rollup_dsXXX, ds_assignee_formatted,
		left.tmsid = right.tmsid AND
		LEFT.page_no = RIGHT.page_no,
		xf_join_assignees(left,right),
		left outer,
		keep(10000)
	);

	// Join the creditor information
	layout_ucc_rollup_src_with_page_no xf_join_creditors(layout_ucc_rollup_src_with_page_no L, ds_creditor_formatted R) := transform
		SELF.tmsid   := l.tmsid;
		SELF.page_no := l.page_no;	
	  self.creditors := R.parties;
		UCCv2_Services.mac_PickPenalty()
		self := L;
	end;
	ds_primed_rollup_dsacX := join(
		ds_primed_rollup_dsaXX, ds_creditor_formatted,
		left.tmsid = right.tmsid AND
		LEFT.page_no = RIGHT.page_no,
		xf_join_creditors(left,right),
		left outer,
		keep(10000)
	);

	// Join the history information
	layout_ucc_rollup_src_with_page_no xf_join_history(layout_ucc_rollup_src_with_page_no l, ds_history_rolled r) := transform
		SELF.tmsid   := l.tmsid;
		SELF.page_no := l.page_no;
	  self.filings := choosen(r.filings,UCCv2_Services.Constants.MAXCOUNT_FILINGS);
		self := l;
	end;
	ds_primed_rollup_dsach := join(
		ds_primed_rollup_dsacX, ds_history_rolled,
	  left.tmsid = right.tmsid AND
		left.page_no = 1,
		xf_join_history(left,right),
		left outer,
		keep(10000)
	);

	// Join the signer information
	layout_ucc_rollup_src_with_page_no xf_join_signers(layout_ucc_rollup_src_with_page_no l, ds_signers_rolled r) := transform
	  SELF.tmsid   := l.tmsid;
		SELF.page_no := l.page_no;
		self.signers := choosen(r.signers,UCCv2_Services.Constants.MAXCOUNT_SIGNERS);
		self := l;
	end;
	ds_primed_rollup_dsachs := join(
		ds_primed_rollup_dsach, ds_signers_rolled,
	  left.tmsid = right.tmsid AND
		left.page_no = 1,
		xf_join_signers(left,right),
		left outer,
		keep(10000)
	);

	// Join the filing office information
	layout_ucc_rollup_src_with_page_no xf_join_filofc(layout_ucc_rollup_src_with_page_no l, ds_filofc_rolled r) := transform
	  SELF.tmsid   := l.tmsid;
		SELF.page_no := l.page_no;
		self.filing_offices := choosen(r.filing_offices,UCCv2_Services.Constants.MAXCOUNT_FILING_OFFICES);
		self := l;
	end;
	ds_primed_rollup_dsachsf := join(
		ds_primed_rollup_dsachs, ds_filofc_rolled,
	  left.tmsid = right.tmsid AND
		left.page_no = 1,
		xf_join_filofc(left,right),
		left outer,
		keep(10000)
	);
	
	// Join the collateral information
	layout_ucc_rollup_src_with_page_no xf_join_coll(layout_ucc_rollup_src_with_page_no l, ds_coll_rolled r) := transform
	  SELF.tmsid   := l.tmsid;
		SELF.page_no := l.page_no;
		self.collateral := choosen(r.collateral,UCCv2_Services.Constants.MAXCOUNT_COLLATERAL);
		self := l;
	end;
	ds_primed_rollup_dsachsfc := join(
		ds_primed_rollup_dsachsf, ds_coll_rolled,
	  left.tmsid = right.tmsid AND
		left.page_no = 1,
		xf_join_coll(left,right),
		left outer,
		keep(10000)
	);
	

	// output( in_tmsids_pulled, NAMED('in_tmsids_pulled') );                   // DEBUG
	// output( ds_party_raw, named('ds_party_raw') );														// DEBUG
	// output( ds_filing_rolled, named('ds_filing_rolled') );										// DEBUG
	// output( ds_history_temp_father, named('ds_htpf') );											  // DEBUG
	// output( ds_history_deduped_father, named('ds_hddf') );								    // DEBUG
	// output( ds_history_denormed_father, named('ds_hdnf') );		 					      // DEBUG
	// output( ds_history_resorted_father, named('ds_hrsf') );		 						    // DEBUG
	// output( ds_history_sort, named('ds_history_sort') );											// DEBUG
	// output( ds_history_rolled, named('ds_history_rolled') );									// DEBUG
	// output( ds_signers_rolled, named('ds_signers_rolled') );									// DEBUG
	// output( ds_filofc_rolled, named('ds_filofc_rolled') );										// DEBUG
  // output( ds_coll_raw, named('ds_coll_raw') );												      // DEBUG
  // output( ds_coll_sort, named('ds_coll_sort') );												    // DEBUG
	// output( ds_coll_rolled, named('ds_coll_rolled') );												// DEBUG
	// output( ds_debtor_formatted, named('ds_debtor_formatted') );							// DEBUG
	// output( ds_secured_formatted, named('ds_secured_formatted') );						// DEBUG
	// output( ds_assignee_formatted, named('ds_assignee_formatted') );					// DEBUG
	// output( ds_creditor_formatted, named('ds_creditor_formatted') );					// DEBUG
	// output( ds_primed_rollup, named('ds_primed_rollup') );										// DEBUG
	// output( ds_primed_rollup_dsach, named('ds_primed_rollup_dsach') );				// DEBUG
	// output( ds_primed_rollup_dsachsfc, named('ds_primed_rollup_dsachsfc') );	// DEBUG
		// output(ds_party_recs_seed,named('ds_party_recs_seed'));
	// OUTPUT( ds_tmsids_with_max_pages, NAMED('ds_tmsids_with_max_pages') );
	// OUTPUT( ds_party_recs_seed, NAMED('ds_party_recs_seed') );
	
	// Return
	
	// Slim off the page_no.
	ds_rollup := PROJECT(ds_primed_rollup_dsachsfc, UCCv2_Services.layout_ucc_rollup_src) ;
	
	// RETURN THE ROLLED UP DATA
	return( SORT(ds_rollup, -orig_filing_date, record) );
	
end;
