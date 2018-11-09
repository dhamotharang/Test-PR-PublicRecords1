import liensv2,doxie,CriminalRecords_Services, FFD, FCRA, ut, STD;

export GetCRSOutput (
  GROUPED DATASET (liensv2_services.layout_lien_party_raw) party_in, //join with key_party_id
  DATASET (liensv2_services.layout_liens_case_extended) case_in,
  DATASET (liensv2_services.layout_liens_history_extended) history_in,
	string in_ssn_mask_type,
  boolean IsFCRA = FALSE,
	string filter_id = '',
	BOOLEAN return_multiple_pages = FALSE,
  BOOLEAN includeCriminalIndicators = FALSE,
	DATASET (FFD.Layouts.PersonContextBatchSlim) ds_slim_pc = FFD.Constants.BlankPersonContextBatchSlim,
	integer8 inFFDOptionsMask = 0,
	integer FCRAPurpose = FCRA.FCRAPurpose.NoValueProvided	
) := FUNCTION

  doxie.MAC_Header_Field_Declare(IsFCRA); // only for DisplayMatchedParty_value !
	
	// FCRA FFD  
	ds_ffd := LiensV2_Services.fn_doFcraCompliance(party_in, case_in,
																								 history_in, ds_slim_pc, 
																								 inFFDOptionsMask);
  
	ds_party_raw_pre :=  if(IsFCRA,group(sort(ds_ffd._party,acctno),acctno), party_in);
	ds_case_raw_pre  :=  if(IsFCRA, ds_ffd._case, case_in);
	ds_history_raw   :=  if(IsFCRA, ds_ffd._history, history_in);
	
	// Populate insurance flag for parties
	rParty_w_ins_flag :=
	record(liensv2_services.layout_lien_party_raw)
		string8 orig_filing_date;
		boolean bcbflag;
	end;
	
	rParty_w_ins_flag tInsuranceFlag(liensv2_services.layout_lien_party_raw l, liensv2_services.layout_liens_case_extended r) :=
	transform
		self.orig_filing_date := r.orig_filing_date;
		self.bcbflag          := r.bcbflag;
		self                  := l;
	end;
	
	ds_party_raw_w_ins_flag := join(ungroup(ds_party_raw_pre),
																	ds_case_raw_pre,
																	left.tmsid = right.tmsid and
																	left.rmsid = right.rmsid,
																	tInsuranceFlag(left, right),
																	limit(0), keep(1));
	
	ds_party_raw_w_ins_flag_sort := group(sort(ds_party_raw_w_ins_flag, tmsid, orig_filing_date, rmsid, if(bcbflag, 0, 1)), tmsid);
	
	rParty_w_ins_flag tIterate(rParty_w_ins_flag l, rParty_w_ins_flag r) :=
	transform
		self.orig_filing_date := if(l.orig_filing_date = '', r.orig_filing_date, l.orig_filing_date);
		self.bcbflag          := if(FCRA.lien_is_ok((string)STD.Date.Today(), self.orig_filing_date), r.bcbflag, FALSE);
		self                  := r;
	end;
	
	ds_party_raw_w_ins_flag_itr := ungroup(iterate(ds_party_raw_w_ins_flag_sort, tIterate(left, right)));
	
	// Filter records for FCRA insurance
	ds_party_raw_filter := if(isFCRA and FCRAPurpose = FCRA.FCRAPurpose.InsuranceApplication,
                            group(sort(project(ds_party_raw_w_ins_flag_itr(bcbflag), liensv2_services.layout_lien_party_raw), acctno), acctno),
                            ds_party_raw_pre);
  
  ds_party_raw := project(ds_party_raw_filter, transform(liensv2_services.layout_lien_party_raw, self.rmsid := '', self := left));
  
  //===== ROLLUP CASE =====
	
	// SORT CASE DATA BY TMSID AND MOST RECENT FILING DATE
  ds_case_raw := project(ds_case_raw_pre, transform(LiensV2_Services.layout_liens_case_extended, self.rmsid := '', self := left));
	ds_case_sort := sort (ds_case_raw, tmsid, orig_filing_date, -filing_number, filing_type_desc, record);
	
	// TRANSFORM TO ROLL UP CASE INFO
	ds_case_sort xf_case_rollup(ds_case_sort l, ds_case_sort r) := transform
	  self.acctno			   			 := l.acctno;
	  self.tmsid               := l.tmsid;
	  self.persistent_record_id:= l.persistent_record_id;
		self.filing_jurisdiction := if(l.filing_jurisdiction = '',r.filing_jurisdiction,l.filing_jurisdiction);
		self.filing_jurisdiction_name := if(l.filing_jurisdiction_name = '',r.filing_jurisdiction_name,l.filing_jurisdiction_name);
		self.filing_state        := if(l.filing_state        = '',r.filing_state       ,l.filing_state       );
		self.orig_filing_number  := if(l.orig_filing_number  = '',r.orig_filing_number ,l.orig_filing_number );
		self.orig_filing_type    := if(l.orig_filing_type    = '',r.orig_filing_type   ,l.orig_filing_type   );
		self.orig_filing_date    := if(l.orig_filing_date    = '',r.orig_filing_date   ,l.orig_filing_date   );
		self.filing_status       := choosen((l.filing_status & r.filing_status)(filing_status <> '' or filing_status_desc <> '' ),10);
    // We are changing the value for bcbflag deviating from the norm of not changing the vendor provided value for fcra services
    // In this case, it's fine since we are not returning the value back to the customer and also, it's happening inside a rollup
		self.bcbflag 						 := if(FCRA.lien_is_ok((string)STD.Date.Today(), self.orig_filing_date),
																		if(l.bcbflag, l.bcbflag, r.bcbflag), FALSE);
		self.case_number         := if(l.case_number         = '',r.case_number        ,l.case_number        );
		self.release_date        := if(l.release_date        = '',r.release_date       ,l.release_date       );
		self.amount              := if(l.amount              = '',r.amount             ,l.amount             );
		self.eviction            := if(l.eviction            = '',r.eviction           ,l.eviction           );
		self.judg_satisfied_date := if(l.judg_satisfied_date = '',r.judg_satisfied_date,l.judg_satisfied_date);
		self.judg_vacated_date   := if(l.judg_vacated_date   = '',r.judg_vacated_date  ,l.judg_vacated_date  );
		self.irs_serial_number   := if(l.irs_serial_number   = '',r.irs_serial_number  ,l.irs_serial_number  );
		self.certificate_number  := if(l.certificate_number  = '',r.certificate_number ,l.certificate_number );
		self.judge							 := if(l.judge 							 = '',r.judge							 ,l.judge							 );
		self.legal_lot           := if(l.legal_lot           = '',r.legal_lot          ,l.legal_lot          );
		self.legal_block         := if(l.legal_block         = '',r.legal_block        ,l.legal_block        );
		self.tax_code            := if(l.tax_code            = '',r.tax_code           ,l.tax_code           );
		self.statementIds 			 := l.statementIds + r.statementIds;
		self.IsDisputed 				 := l.IsDisputed or r.IsDisputed;
		self                     := [];
	end;      
	
	// ROLLUP CASE INFORMATION
	ds_case_rolled := rollup(ds_case_sort, left.tmsid = right.tmsid, xf_case_rollup(left,right));
	
	ds_case_filtered := ds_case_rolled(~IsFCRA OR (FCRAPurpose != FCRA.FCRAPurpose.InsuranceApplication) OR bcbflag); //If FCRAPurpose=6 return only records with bcbflag set to true, else return all. 
	
  //===== ROLLUP HISTORY =====

	ds_history_sort := sort(ds_history_raw, tmsid, record);

	// TRANSFORM TO ROLL UP HISTORY INFO
	layout_liens_history_extended xf_hist_roll_1(ds_history_sort l, ds_history_sort r) := transform
	  self.tmsid  := l.tmsid;
		self.acctno := l.acctno;
		// Choosen not good since we are doing a dedup later and should be restricting the number of records after that
		// And we need to know the oldest filing date and can't determine the value correctly if we only keep the first 15 records
		self.filings := choosen(l.filings & r.filings, 15);
	end;
	
	ds_hist_roll := rollup(ds_history_sort, left.tmsid = right.tmsid, xf_hist_roll_1(left,right));

	layout_liens_history_extended xf_history_rollup(ds_hist_roll l) := transform
		// FCRA - Insurance liens and judgments, FCRAPurpose = 6
		oldest_orig_filing_dt := min(l.filings, orig_filing_date);
		is_liens_ok := FCRA.lien_is_ok((string)STD.Date.Today(), oldest_orig_filing_dt);
		filings := if(isFCRA and FCRAPurpose = FCRA.FCRAPurpose.InsuranceApplication,
                  if(is_liens_ok, l.filings(bcbflag), dataset([], LiensV2_Services.layout_lien_history_w_bcb)),
                  l.filings);
		
	  self.tmsid := l.tmsid;
		self.acctno := l.acctno;
		self.filings := dedup(sort(filings,
															-filing_date,-orig_filing_date,-filing_number,filing_type_desc,-filing_book,-filing_page,record),
													filing_date,orig_filing_date,filing_number,filing_type_desc)(filing_number <> '' or filing_date <> '' or filing_type_desc <> '');
	end;
	
	ds_history_rolled := project(ds_hist_roll,xf_history_rollup(left));
	
  // ADD CRIM INDICATORS
  ds_recsIn := PROJECT(ds_party_raw,TRANSFORM({liensv2_services.layout_lien_party_raw,STRING12 UniqueId},SELF.UniqueId:=LEFT.did,SELF:=LEFT));
  CriminalRecords_Services.MAC_Indicators(ds_recsIn,ds_recsOut);
  ds_recs_party_raw := IF(includeCriminalIndicators,PROJECT(ds_recsOut,liensv2_services.layout_lien_party_raw),ds_party_raw);

	// PARTY COPY TRANSFORM
	ds_debtor_formatted   := LiensV2_Services.fn_format_parties(ds_recs_party_raw(name_type = 'D'), in_ssn_mask_type, IsFCRA, return_multiple_pages);
	ds_creditor_formatted := LiensV2_Services.fn_format_parties(ds_recs_party_raw(name_type = 'C'), in_ssn_mask_type, IsFCRA, return_multiple_pages);
	ds_attorney_formatted := LiensV2_Services.fn_format_parties(ds_recs_party_raw(name_type = 'A'), in_ssn_mask_type, IsFCRA, return_multiple_pages);
	ds_thd_formatted      := LiensV2_Services.fn_format_parties(ds_recs_party_raw(name_type = 'T'), in_ssn_mask_type, IsFCRA, return_multiple_pages);


  /* PICK the MATCHED PARTY*/

	layout_lien_rollup_with_page_no := RECORD		
		liensv2_services.layout_lien_rollup;
		INTEGER page_no;		
	END;

	
	layout_parties_having_page_no := RECORD
		liensv2.layout_liens_party.tmsid;
		liensv2.layout_liens_party.rmsid;
		DATASET(liensv2_services.layout_lien_party) parties {maxcount(LiensV2.Constants.MAXCOUNT_PARTIES)};
		unsigned2 penalt;
		INTEGER page_no;
	END;
	
	party_rec := RECORD
		string1 name_type;
		layout_parties_having_page_no;
	END;
	
	party_rec xfm_partyType(layout_parties_having_page_no l, string1 name_type) := TRANSFORM
		SELF.name_type := name_type;
		SELF := l;
	END;
	
	formatted_parties := DEDUP(SORT(PROJECT(ds_debtor_formatted,xfm_partyType(LEFT,'0'))
	                              + PROJECT(ds_creditor_formatted,xfm_partyType(LEFT,'1'))
																+ PROJECT(ds_attorney_formatted,xfm_partyType(LEFT,'2'))
																+ PROJECT(ds_thd_formatted,xfm_partyType(LEFT,'3'))
																 ,tmsid,penalt,name_type,record),tmsid);

	// TRANSFORM TO PRIME THE RESULT DATASET
	
	layout_lien_rollup_with_page_no xf_project_case_info(ds_case_filtered l) := transform

		bp := formatted_parties(tmsid = l.tmsid);

	  self.tmsid := l.tmsid;
		SELf.matched_party.party_type := if(DisplayMatchedParty_value,
		                                    MAP(bp[1].name_type ='0' => 'D'
		                                       ,bp[1].name_type ='1' => 'C'
		                                       ,bp[1].name_type ='2' => 'A'
		                                       ,bp[1].name_type ='3' => 'T'
		                                       ,''),
		                                    '');
													
		SELf.matched_party.parsed_party := if(DisplayMatchedParty_value
		                                     ,PROJECT(bp.parties[1].parsed_parties,layout_lien_party_name)[1]);
		SELf.matched_party.address := if(DisplayMatchedParty_value
		                                ,PROJECT(bp.parties[1].addresses,assorted_layouts.matched_party_address_rec)[1]);
		self := l;
		self := [];
	end;

	// PROJECT CASE INFO INTO ROLLUP LAYOUT
	ds_primed_rollup := project(ds_case_filtered, xf_project_case_info(left));

	// Determine the number of pages (i.e. records) that the system must return. We need to determine this 
	// beforehand, since we'll be joining all of the record sections based on tmsid and page_no.
	
	rec_max_pages_per_tmsid := RECORD
		layout_lien_rollup_with_page_no;
		INTEGER max_pages;
	END;

	rec_max_pages_per_tmsid xfm_determine_max_pages(ds_primed_rollup l) :=
		TRANSFORM
			SELF.tmsid     := l.tmsid;
			SELF.max_pages := MAX( MAX(ds_debtor_formatted(tmsid = l.tmsid), page_no),
														 MAX(ds_creditor_formatted(tmsid = l.tmsid), page_no),
														 MAX(ds_attorney_formatted(tmsid = l.tmsid), page_no),
														 MAX(ds_thd_formatted(tmsid = l.tmsid), page_no)		
														);
			SELF           := l;
		END;
		
	ds_tmsids_with_max_pages := PROJECT(ds_primed_rollup, xfm_determine_max_pages(LEFT));

	ds_party_recs_seed := NORMALIZE(ds_tmsids_with_max_pages, 
																 LEFT.max_pages, 
																 TRANSFORM(layout_lien_rollup_with_page_no,
																					 SELF.tmsid    := LEFT.tmsid,
																					 SELF.page_no  := COUNTER,
																					 SELF          := LEFT,
																					 SELF          := [])
																);	

	// ***** Assemble the report by joining individual sections to the final ut.out layout. *****

	// TRANSFORM TO JOIN THE DEBTOR INFORMATION
	layout_lien_rollup_with_page_no xf_join_debtors(layout_lien_rollup_with_page_no l, ds_debtor_formatted r) := transform
		SELF.tmsid   := l.tmsid,
		SELF.page_no := l.page_no,
		self.multiple_debtor := count(r.parties) > 1;
		self.debtors :=  r.parties(filter_id = '' OR exists(parsed_parties(person_filter_id = filter_id)));
		liensv2_services.mac_pickPenalty()
		self := l;
	end;
	
	// TRANSFORM TO JOIN THE CREDITOR INFORMATION
	layout_lien_rollup_with_page_no xf_join_creditors(layout_lien_rollup_with_page_no l, ds_creditor_formatted r) := transform
		SELF.tmsid   := l.tmsid,
		SELF.page_no := l.page_no,	
	  self.creditors := r.parties;
	  liensv2_services.mac_PickPenalty(l.penalt)
		self := l;
	end;
	
	// TRANSFORM TO JOIN THE ATTORNEY INFORMATION
	layout_lien_rollup_with_page_no xf_join_attorneys(layout_lien_rollup_with_page_no l, ds_attorney_formatted r) := transform
		SELF.tmsid   := l.tmsid,
		SELF.page_no := l.page_no,	
	  self.attorneys := r.parties;
	  liensv2_services.mac_PickPenalty(l.penalt)
		self := l;
	end;
	
	// TRANSFORM TO JOIN THE THD INFORMATION
	layout_lien_rollup_with_page_no xf_join_thds(layout_lien_rollup_with_page_no l, ds_thd_formatted r) := transform
		SELF.tmsid   := l.tmsid,
		SELF.page_no := l.page_no,	
	  self.thds := r.parties;
	  liensv2_services.mac_PickPenalty(l.penalt)
		self := l;
	end;
	
	// TRANSFORM TO JOIN THE HISTORY INFORMATION
	layout_lien_rollup_with_page_no xf_join_history(layout_lien_rollup_with_page_no l, ds_history_rolled r) := transform
		SELF.tmsid   := l.tmsid,
		SELF.page_no := l.page_no,
		self.filings := r.filings;
		self := l;
	end;
	
	// JOIN DEBTOR INFORMATION
	ds_primed_rollup_dxxxx := join(ds_party_recs_seed /* ds_primed_rollup */, ds_debtor_formatted,
	                              left.tmsid = right.tmsid AND
																LEFT.page_no = RIGHT.page_no,
																xf_join_debtors(left,right),
																left outer, keep(1000));
																
	// JOIN CREDITOR INFORMATION
	ds_primed_rollup_dcxxx := join(ds_primed_rollup_dxxxx, ds_creditor_formatted,
	                              left.tmsid = right.tmsid AND
																LEFT.page_no = RIGHT.page_no,
																xf_join_creditors(left,right),
																left outer, keep(1000));
																
	// JOIN ATTORNEY INFORMATION
	ds_primed_rollup_dcaxx := join(ds_primed_rollup_dcxxx, ds_attorney_formatted,
	                              left.tmsid = right.tmsid AND
																LEFT.page_no = RIGHT.page_no,
																xf_join_attorneys(left,right),
																left outer, keep(1000));
																
	// JOIN THD INFORMATION
	ds_primed_rollup_dcatx := join(ds_primed_rollup_dcaxx, ds_thd_formatted,
	                              left.tmsid = right.tmsid AND
																LEFT.page_no = RIGHT.page_no,
																xf_join_thds(left,right),
																left outer, keep(1000));
																
	// JOIN HISTORY INFORMATION (we're not paginating filing history)
	ds_primed_rollup_dcath := join(ds_primed_rollup_dcatx, ds_history_rolled,
	                              left.tmsid = right.tmsid AND
																LEFT.page_no = 1,
																xf_join_history(left,right),
																left outer, keep(1000));	
	
	// Slim off page_no.
	ds_results := PROJECT(ds_primed_rollup_dcath,LiensV2_Services.layout_lien_rollup);
	
  //DEBUG	
   // ut.out(ds_party_raw_pre);
   // ut.out(ds_case_raw_pre);
   // ut.out(ds_case_raw);
   // ut.out(ds_history_raw);
   // ut.out(ds_party_raw);
   // ut.out(ds_case_rolled);
   // ut.out(ds_case_filtered);
   // ut.out(ds_history_rolled);
   // ut.out(formatted_parties);
   // ut.out(ds_party_recs_seed);

	RETURN SORT(ds_results, -orig_filing_date, record);

end;
