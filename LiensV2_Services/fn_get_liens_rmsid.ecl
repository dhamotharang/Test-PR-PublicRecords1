// FUNCTION TO GET LIENS FROM A SET OF TMSID
import liensv2,CriminalRecords_Services;
export fn_get_liens_rmsid(
  grouped dataset(liensv2_services.layout_rmsid) in_rmsids,
	string in_ssn_mask_type,
	string32 appType,
  boolean includeCriminalIndicators=false
) := function
  // RMSID INDEX INTO LIENS SEARCH FILE
	k_rmsid := liensv2.key_liens_main_id;
	k_rmsid_party := liensv2.key_liens_party_id;
	// TEMP CASE LAYOUT
	temp_case_layout := record
	  string8 filing_date;
		liensv2.Layout_liens_main_module.layout_liens_main.filing_number;
		string20 filing_type_desc;
		liensv2_services.layout_lien_case;
	end;
	// 	GET PARTY INFO FIRST FOR PULL IDS
	liensv2_services.layout_lien_party_raw xf_party_copy(k_rmsid_party r) := transform
	  self := r;
    self.hasCriminalConviction := false;
    self.isSexualOffender := false;
	end;
	ds_party_raw := join(in_rmsids,k_rmsid_party,
	                    keyed(left.tmsid = right.tmsid) and
											keyed(left.rmsid = right.rmsid),
											xf_party_copy(right),
											keep(10000));
	rmsids_cln := LiensV2_Services.fn_pullIDs(ds_party_raw,appType);

	// CASE INFO COPY TRANSFORM
	temp_case_layout xf_case_copy(k_rmsid r) := transform
		self.filing_status := choosen(r.filing_status,10);
	  self.filing_jurisdiction_name := LiensV2_Services.fn_get_filing_jurisdiction_name(r.filing_jurisdiction);
	  self := r;
	end;
	// JOIN RMSID SET TO INDEX TO GET DATA
	ds_case_raw := join(rmsids_cln,k_rmsid,
	                    keyed(left.tmsid = right.tmsid) and
											keyed(left.rmsid = right.rmsid),
											xf_case_copy(right),
											keep(10000));
	// SORT CASE DATA BY RMSID AND MOST RECENT FILING DATE
	ds_case_sort := sort(ds_case_raw,tmsid,rmsid,-filing_date,-filing_number,filing_type_desc,record);
	// TRANSFORM TO ROLL UP CASE INFO
	ds_case_sort xf_case_rollup(ds_case_sort l, ds_case_sort r) := transform
	  self.tmsid               := l.tmsid;
		self.rmsid               := l.rmsid;
		self.filing_jurisdiction := if(l.filing_jurisdiction = '',r.filing_jurisdiction,l.filing_jurisdiction);
		self.filing_jurisdiction_name := if(l.filing_jurisdiction_name = '',r.filing_jurisdiction_name,l.filing_jurisdiction_name);
		self.filing_state        := if(l.filing_state        = '',r.filing_state       ,l.filing_state       );
		self.orig_filing_number  := if(l.orig_filing_number  = '',r.orig_filing_number ,l.orig_filing_number );
		self.orig_filing_type    := if(l.orig_filing_type    = '',r.orig_filing_type   ,l.orig_filing_type   );
		self.orig_filing_date    := if(l.orig_filing_date    = '',r.orig_filing_date   ,l.orig_filing_date   );
		self.filing_status       := choosen(dedup(sort((l.filing_status + r.filing_status)(filing_status <> '' or filing_status_desc <> '' ),record),record),10);
		self.case_number         := if(l.case_number         = '',r.case_number        ,l.case_number        );
		self.certificate_number  := if(l.certificate_number  = '',r.certificate_number ,l.certificate_number );
		self.release_date        := if(l.release_date        = '',r.release_date       ,l.release_date       );
		self.amount              := if(l.amount              = '',r.amount             ,l.amount             );
		self.eviction            := if(l.eviction            = '',r.eviction           ,l.eviction           );
		self.judg_satisfied_date := if(l.judg_satisfied_date = '',r.judg_satisfied_date,l.judg_satisfied_date);
		self.judg_vacated_date   := if(l.judg_vacated_date   = '',r.judg_vacated_date  ,l.judg_vacated_date  );
		self.judge							 := if(l.judge 							 = '',r.judge							 ,l.judge							 );				
		self.tax_code            := if(l.tax_code            = '',r.tax_code           ,l.tax_code           );
		self := [];
	end;      
	// ROLLUP CASE INFORMATION
	ds_case_rolled := rollup(ds_case_sort,left.tmsid = right.tmsid and left.rmsid = right.rmsid,xf_case_rollup(left,right));
	// FILING INFO COPY TRANSFORM
	temp_hist_layout := record
	  string50 tmsid;
		string50 rmsid;
		dataset(liensv2_services.layout_lien_history) filings{maxcount(15)};
	end;
	temp_hist_layout xf_history_copy(k_rmsid r) := transform
	  self.filings := dataset([{r.filing_number,r.filing_type_desc,r.orig_filing_date,r.filing_date,r.filing_time,r.filing_book,r.filing_page,r.agency,r.agency_state,r.agency_city,r.agency_county}],liensv2_services.layout_lien_history);
		self.tmsid := r.tmsid;
		self.rmsid := r.rmsid;
	end;
	// JOIN RMSID SET TO INDEX TO GET DATA
	ds_history_raw := join(rmsids_cln,k_rmsid,
	                    keyed(left.tmsid = right.tmsid) and
	                    keyed(left.rmsid = right.rmsid),
											xf_history_copy(right),
											keep(10000));
	// SORT HISTORY DATA BY RMSID AND MOST RECENT FILING DATE
	ds_history_sort := sort(ds_history_raw,tmsid,rmsid,record);
	// TRANSFORM TO ROLL UP HISTORY INFO
	ds_history_sort xf_hist_roll_1(ds_history_sort l, ds_history_sort r) := transform
	  self.tmsid := l.tmsid;
		self.rmsid := l.rmsid;
		self.filings := choosen(l.filings & r.filings,15);
	end;
	ds_hist_roll := rollup(ds_history_sort,left.tmsid = right.tmsid and left.rmsid = right.rmsid,xf_hist_roll_1(left,right));
	ds_hist_roll xf_history_rollup(ds_hist_roll l) := transform
	  self.tmsid := l.tmsid;
		self.rmsid := l.rmsid;
		self.filings := dedup(sort(l.filings,-filing_date,-orig_filing_date,-filing_number,filing_type_desc,-filing_book,-filing_page,record),filing_date,filing_number,filing_type_desc)(filing_number <> '' or filing_date <> '' or filing_type_desc <> '');
	end;
	// ROLLUP HISTORY INFORMATION
	ds_history_rolled := project(ds_hist_roll,xf_history_rollup(left));
  // ADD CRIM INDICATORS
  ds_recsIn := PROJECT(ds_party_raw,TRANSFORM({liensv2_services.layout_lien_party_raw,STRING12 UniqueId},SELF.UniqueId:=LEFT.did,SELF:=LEFT));
  CriminalRecords_Services.MAC_Indicators(ds_recsIn,ds_recsOut);
  ds_recs_party_raw := IF(includeCriminalIndicators,PROJECT(ds_recsOut,liensv2_services.layout_lien_party_raw),ds_party_raw);
	// PARTY COPY TRANSFORM
	ds_debtor_formatted := fn_format_parties(ds_recs_party_raw(name_type = 'D'),in_ssn_mask_type);
	ds_creditor_formatted := fn_format_parties(ds_recs_party_raw(name_type = 'C'),in_ssn_mask_type);
	ds_attorney_formatted := fn_format_parties(ds_recs_party_raw(name_type = 'A'),in_ssn_mask_type);
	ds_thd_formatted := fn_format_parties(ds_recs_party_raw(name_type = 'T'),in_ssn_mask_type);
	// TRANSFORM TO PRIME THE RESULT DATASET
	liensv2_services.layout_lien_rollup xf_project_case_info(ds_case_rolled l) := transform
	  self.tmsid := l.tmsid;
		self.rmsid := l.rmsid;
		self := l;
		self := [];
	end;
	// PROJECT CASE INFO INTO ROLLUP LAYOUT
	ds_primed_rollup := project(ds_case_rolled,xf_project_case_info(left));
	// TRANSFORM TO JOIN THE DEBTOR INFORMATION
	ds_primed_rollup xf_join_debtors(ds_primed_rollup l, ds_debtor_formatted r) := transform
	  self.debtors := choosen(r.parties,25);
	  liensv2_services.mac_PickPenalty()
	  self.multiple_debtor := count(r.parties) > 1;
		self := l;
	end;
	// TRANSFORM TO JOIN THE CREDITOR INFORMATION
	ds_primed_rollup xf_join_creditors(ds_primed_rollup l, ds_creditor_formatted r) := transform
	  self.creditors := choosen(r.parties,10);
	  liensv2_services.mac_PickPenalty(l.penalt)
		self := l;
	end;
	// TRANSFORM TO JOIN THE ATTORNEY INFORMATION
	ds_primed_rollup xf_join_attorneys(ds_primed_rollup l, ds_attorney_formatted r) := transform
	  self.attorneys := choosen(r.parties,10);
	  liensv2_services.mac_PickPenalty(l.penalt)
		self := l;
	end;
	// TRANSFORM TO JOIN THE THD INFORMATION
	ds_primed_rollup xf_join_thds(ds_primed_rollup l, ds_thd_formatted r) := transform
	  self.thds := choosen(r.parties,10);
	  liensv2_services.mac_PickPenalty(l.penalt)
		self := l;
	end;
	// TRANSFORM TO JOIN THE HISTORY INFORMATION
	ds_primed_rollup xf_join_history(ds_primed_rollup l, ds_history_rolled r) := transform
	  self.filings := choosen(r.filings,15);
		self := l;
	end;
	// JOIN DEBTOR INFORMATION
	ds_primed_rollup_dxxxx := join(ds_primed_rollup,ds_debtor_formatted,
	                              left.tmsid = right.tmsid and
																left.rmsid = right.rmsid,
																xf_join_debtors(left,right),
																left outer);
	// JOIN CREDITOR INFORMATION
	ds_primed_rollup_dcxxx := join(ds_primed_rollup_dxxxx,ds_creditor_formatted,
	                              left.tmsid = right.tmsid and
																left.rmsid = right.rmsid,
																xf_join_creditors(left,right),
																left outer);
	// JOIN ATTORNEY INFORMATION
	ds_primed_rollup_dcaxx := join(ds_primed_rollup_dcxxx,ds_attorney_formatted,
	                              left.tmsid = right.tmsid and
																left.rmsid = right.rmsid,
																xf_join_attorneys(left,right),
																left outer);
	// JOIN THD INFORMATION
	ds_primed_rollup_dcatx := join(ds_primed_rollup_dcaxx,ds_thd_formatted,
	                              left.tmsid = right.tmsid and
																left.rmsid = right.rmsid,
																xf_join_thds(left,right),
																left outer);
	// JOIN HISTORY INFORMATION
	ds_primed_rollup_dcath := join(ds_primed_rollup_dcatx,ds_history_rolled,
	                              left.tmsid = right.tmsid and
																left.rmsid = right.rmsid,
																xf_join_history(left,right),
																left outer);
	// RETURN THE ROLLED UP DATA
	return sort(ds_primed_rollup_dcath,-orig_filing_date,record);
end;
