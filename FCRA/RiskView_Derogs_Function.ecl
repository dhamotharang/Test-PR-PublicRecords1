import risk_indicators, doxie_files, riskwise, codes, census_data, liensv2, liensv2_services, did_add, bankruptcyv3;

export RiskView_Derogs_Function(dataset(risk_indicators.Layout_BocaShell_Neutral) shell, unsigned4 HistoryDateYYYYMMDD=99999999) := function

cutoff_date := if(HistoryDateYYYYMMDD=99999999, FCRA.RiskView_Derogs_Module.todaysdate, (string8)HistoryDateYYYYMMDD);

search_rec := record
	unsigned4 seq;
	unsigned6 did;
	string9 ssn;
	string30 fname;
	string30 lname;
	string30 mname;
	// flag fields
	string20 flag_file_id;
   string20 file_id;
   string100 record_id;
end;

// only concerned with override records from the following 3 files
set_bk_file_ids := [fcra.file_id.BANKRUPTCY];
set_derog_file_ids := [fcra.file_id.BANKRUPTCY, fcra.file_id.LIEN];

with_did_flags := join(shell, fcra.Key_Override_Flag_DID, 
		keyed((string)left.did=right.l_did) and 
		right.file_id in set_derog_file_ids,  // don't add the ids unless it's 1 of the derog files
	transform(search_rec, self.seq := left.shell_input.seq, 
		self.did := left.did, 
		self.ssn := left.shell_input.ssn,
		self.fname := left.shell_input.fname,
		self.lname := left.shell_input.lname,
		self.mname := left.shell_input.mname,
		self := right), left outer, keep(100));
// output(with_did_flags, named('with_did_flags'));

// just in case the did not found
with_ssn_flags := join(with_did_flags, fcra.Key_Override_Flag_SSN, 
					keyed(left.ssn=right.l_ssn) and 
					datalib.NameMatch (Left.fname, left.mname, Left.lname, right.fname, right.mname, right.lname)<3 and
					right.file_id in set_derog_file_ids and // don't add the ids unless it's 1 of the derog files
					(unsigned)left.did<>(unsigned)right.did, // don't duplicate records that we already got a hit by did
		transform(search_rec, self.seq := left.seq, 
					self.did := left.did, 
					self.ssn := left.ssn, 
					self.fname := left.fname, 
					self.lname := left.lname,
					self.mname := left.mname,
					use_right := right.ssn<>'';
					self.flag_file_id := if(use_right, right.flag_file_id, left.flag_file_id);
					self.file_id := if(use_right, right.file_id, left.file_id);
					self.record_id := if(use_right, right.record_id, left.record_id);
   ), left outer, keep(100));



bk_search_layout := record
	string10   seq_number;
	string50 	 tmsid;
	string5    court_code;
	string7    case_number;
	string2    debtor_type;
	string3    debtor_seq;
	string20   debtor_fname;
	string20   debtor_mname;
	string20   debtor_lname;
	string5    debtor_name_suffix;
	FCRA.RiskView_Derogs_Module.layout_report_address_out;
end;

bk_main_layout := record
	string1	  source;	
	string5	  court_code;
	string7	  case_number;
	string12	 id;
	string10	 seq_number;
	string8	  date_filed;
	string8	  date_created;
	string50	 court_name;
	string40	 court_location;
	string20	 court_state;  // comes from mapping of court code
	string8	  case_closing_date;
	string3	  chapter;
	string10	 orig_filing_type;
	string12	 filing_status;
	string3	  orig_chapter;
	string8	  orig_filing_date;
	string3	  corp_flag;
	string8	  meeting_date;
	string8	  meeting_time;
	string90	 address_341;
	string8  	disposed_date;
	string35	 disposition;
	string8		 converted_date;
	string35	 judge_name;
	string128	record_type;
	string5	  assets_no_asset_indicator;
	string1	  filing_type;
	string1	  filer_type;
	string20	 filer_type_mapped;  // comes from mapping of filer_type
	string3	  pro_se_ind;
	string5	  judges_identification;
end;

bk_working := record
	search_rec input;
	bk_search_layout bk_search;
	bk_main_layout bk_main;
end;
		
boolean isFCRA := true;
		
bk_step1a := join(with_ssn_flags, BankruptcyV3.key_bankruptcyV3_did(isFCRA),
				left.did!=0 and keyed(left.did=right.did) and
				(TRIM (Right.court_code) + Right.case_number <> left.record_id),  // filter out any records that match the correction file
				transform(bk_working, 
						self.bk_search := right,
						self.input := left,
						self := []), 
						atmost(riskwise.max_atmost));


bk_step1 := join(bk_step1a, BankruptcyV3.key_bankruptcyv3_search_full_bip(isFCRA),
				left.bk_search.tmsid!='' and keyed(left.bk_search.tmsid=right.tmsid) and
				(TRIM (Right.tmsid) + trim(Right.name_type) + trim(right.did) <> left.input.record_id) and  // filter out any search records that match the correction file
				right.name_type='D',
				transform(bk_working, 
						self.bk_search.debtor_fname := right.fname;
						self.bk_search.debtor_mname := right.mname;
						self.bk_search.debtor_lname := right.lname;
						self.bk_search.debtor_name_suffix := right.name_suffix;
						self.bk_search.suffix := right.addr_suffix;
						self.bk_search.z5 := right.zip;
						self.bk_search := right;
						self.bk_main.disposition := trim(stringlib.stringtouppercase(right.disposition));	
						self.bk_main.disposed_date := right.discharged;
						self.bk_main.chapter := right.chapter;
						self.bk_main.filing_type := right.filing_type;
						self.bk_main.pro_se_ind := right.pro_se_ind;
						self.bk_main.record_type := right.record_type;
						self.bk_main.converted_date := right.converted_date;
						self.input := left,
						self := []), 
						atmost(riskwise.max_atmost));


bankrupt_search_overrides:= join(with_ssn_flags, fcra.key_override_bkv3_search_ffid, 
							keyed(right.flag_file_id = left.flag_file_id) and 
							left.file_id in set_bk_file_ids,
						transform(bk_working, 
							self.bk_search.debtor_fname := right.fname;
							self.bk_search.debtor_mname := right.mname;
							self.bk_search.debtor_lname := right.lname;
							self.bk_search.debtor_name_suffix := right.name_suffix;
							self.bk_search.suffix := right.addr_suffix;
							self.bk_search.z5 := right.zip;
							self.bk_search := right;
							self.bk_main.disposition := trim(stringlib.stringtouppercase(right.disposition));	
							self.bk_main.disposed_date := right.discharged;
							self.bk_main.chapter := right.chapter;
							self.bk_main.filing_type := right.filing_type;
							self.bk_main.pro_se_ind := right.pro_se_ind;
							self.bk_main.record_type := right.record_type;
							self.bk_main.converted_date := right.converted_date;
							self.input := left,
							self := []));
bk_step2 := ungroup(bk_step1 + bankrupt_search_overrides);

bk_main := BankruptcyV3.key_bankruptcyV3_main_full(isFCRA);

// if no s_casenum in the result, means there was no bankruptcy hit or the bankruptcy was older than 10 years
bk_working add_bankruptcy(bk_step2 le, bk_main rt) := transform
	self.bk_main.court_name := codes.BANKRUPTCIES.COURT_CODE(rt.court_code);
	self.bk_main.court_state := codes.GENERAL.STATE_LONG(rt.court_code[1..2]);
	self.bk_main.filer_type_mapped :=  codes.BANKRUPTCIES.FILER_TYPE(rt.filer_type);
	
	self.bk_main.disposition := le.bk_main.disposition;	
	self.bk_main.disposed_date := le.bk_main.disposed_date;
	self.bk_main.chapter := le.bk_main.chapter;
	self.bk_main.filing_type := le.bk_main.filing_type;
	self.bk_main.pro_se_ind := le.bk_main.pro_se_ind;
	self.bk_main.record_type := le.bk_main.record_type;
	self.bk_main.converted_date := le.bk_main.converted_date;
							
	self.bk_main := rt;
	self := le;
end;

bankrupt_full := JOIN (bk_step2, bk_main,
						LEFT.bk_search.tmsid<>'' AND
						keyed(LEFT.bk_search.tmsid = RIGHT.tmsid) AND
						FCRA.bankrupt_is_ok(cutoff_date,RIGHT.date_filed) and 
						(unsigned)right.date_filed <= (unsigned)cutoff_date and
						(TRIM (Right.court_code) + Right.case_number <> left.input.record_id),  // filter out any records that match the correction file
						add_bankruptcy(left, right),
						ATMOST(riskwise.max_atmost));
							
							
bankrupt_main_overrides := join(bk_step2, fcra.key_override_bkv3_main_ffid, 
						keyed(right.flag_file_id = left.input.flag_file_id) and 
						left.input.file_id in set_bk_file_ids,
						transform(bk_working,
									self.bk_main.court_name := codes.BANKRUPTCIES.COURT_CODE(right.court_code);
									self.bk_main.court_state := codes.GENERAL.STATE_LONG(right.court_code[1..2]);
									self.bk_main.filer_type_mapped :=  codes.BANKRUPTCIES.FILER_TYPE(right.filer_type);
									self.bk_main.disposition := left.bk_main.disposition;	
									self.bk_main.disposed_date := left.bk_main.disposed_date;
									self.bk_main.chapter := left.bk_main.chapter;
									self.bk_main.filing_type := left.bk_main.filing_type;
									self.bk_main.pro_se_ind := left.bk_main.pro_se_ind;
									self.bk_main.record_type := left.bk_main.record_type;
									self.bk_main.converted_date := left.bk_main.converted_date;
									self.bk_main := right;
									self := left), atmost(riskwise.max_atmost));

all_bankruptcy := ungroup(bankrupt_full + bankrupt_main_overrides);


bk_w_county_name := join(all_bankruptcy(bk_main.disposition not in fcra.riskview_derogs_module.closed_bk_dispositions), //filter out any records from the report that are closed bankruptcies
						Census_Data.Key_Fips2County,
						left.bk_search.st<>'' and left.bk_search.county<>'' and
                        keyed (left.bk_search.st = right.state_code) and
                        keyed (left.bk_search.county[3..5] = right.county_fips),
                        transform(bk_working, self.bk_search.county_name := right.county_name, self := left),
						left outer, KEEP (1));


liens_party_layout := record
	string50 tmsid;
	string50 rmsid;
	string1 name_type := '';
	string12 DID  := '';
	string5  title					;
	string20 fname					;
	string20 mname					;
	string20 lname					;
	string5  name_suffix		;
	string9 ssn := '';
	FCRA.RiskView_Derogs_Module.layout_report_address_out;
	string10 phone := '';
	string8  date_first_seen := '';
	string8  date_last_seen := '';
	string8  date_vendor_first_reported := '';
	string8  date_vendor_last_reported := '';
end;

liens_main_layout := record
	string50 tmsid;
	string50 rmsid;
	string8 process_date;
	string1 record_code := '';
	string50 filing_jurisdiction := '';
	string25 filing_jurisdiction_name := '';
	string10 filing_state := '';
	string20 orig_filing_number := '';
	string8 orig_filing_date := '';
	string25 case_number   := '';
	string20 filing_status := '';
	string65 filing_status_desc := '';
	string20 filing_number := '';
	string30 filing_type_desc := '';
	string6 filing_book := '';
	string6 filing_page := '';
	string8 release_date := '';
	string30 amount := '';
	string1 eviction := '';
	string8 effective_date := '';
	string8 lapse_date := '';
	string8 expiration_date := '';
	string70 agency :='';
	string2 agency_state :='';
end;

liens_working := record
	search_rec input;
	liens_party_layout liens_party;
	liens_main_layout liens_main;
	boolean open_lien;
end;


liens_step1 := JOIN (with_ssn_flags, liensv2.key_liens_DID_FCRA,
                      left.did!=0 and keyed (Left.did = Right.did),
				transform(liens_working, 
						self.liens_party.tmsid := right.tmsid,
						self.liens_party.rmsid := right.rmsid,
						self.input := left,
						self := []), 
						atmost(riskwise.max_atmost));

/*	
//////////////////////////////////////////////////////////////////////////////////////////

this liens_step1 can replace original liens_step1 if FCRA copy of the ssn key is created	

//////////////////////////////////////////////////////////////////////////////////////////					

liens_did_step1 := JOIN (with_ssn_flags, liensv2.key_liens_DID_FCRA,
                      left.did!=0 and keyed (Left.did = Right.did),
				transform(liens_working, 
						self.liens_party.tmsid := right.tmsid,
						self.liens_party.rmsid := right.rmsid,
						self.input := left,
						self := []), 
						atmost(riskwise.max_atmost));						
// output(liens_did_step1, named('liens_did_step1'));

liens_ssn_step1 := join(with_ssn_flags, liensv2.key_liens_SSN,  // TODO:  GET AN FCRA COPY OF THIS KEY ON THE FCRA ROXIE
							left.ssn!='' and keyed( left.ssn = right.ssn),
							transform(liens_working, 
							self.liens_party.tmsid := right.tmsid,
							self.liens_party.rmsid := right.rmsid,
							self.input := left,
							self := []), 
							atmost(riskwise.max_atmost)); 

// output(liens_ssn_step1, named('liens_ssn_step1'));

liens_step1 := dedup(sort(ungroup(liens_did_step1 + liens_ssn_step1), input.seq, liens_party.tmsid, liens_party.rmsid), input.seq, liens_party.tmsid, liens_party.rmsid);
// output(liens_step1, named('liens_step1'));
*/
					  
liens_step2 := JOIN (liens_step1, liensv2.key_liens_party_id_FCRA, 
					 Left.liens_party.tmsid<>'' AND 
					 keyed (Left.liens_party.tmsid = Right.tmsid) and 
					 keyed (Left.liens_party.rmsid = Right.rmsid) and
					 right.name_type='D' and 
					 
					 // MAKE SURE WE ONLY RETURN LIENS DATA FOR THE INPUT PERSON
					 (left.input.did=(unsigned)right.did OR
					 (did_add.ssn_match_score(left.input.ssn,right.ssn) between 90 and 100 AND
					 risk_indicators.FnameScore(left.input.fname,right.fname) BETWEEN 80 AND 100 AND 
					 risk_indicators.LnameScore(left.input.lname,right.lname) BETWEEN 80 AND 100)) 
					 					 and		 
					 ((string50)right.tmsid + (string50)right.rmsid <> left.input.record_id  // old way - exclude corrected records from prior to 11/13/2012
						and trim((string)right.persistent_record_id) <> left.input.record_id ),  // new way - exclude corrected records that match the persistent_record_id		
					 transform(liens_working, self.liens_party := right, self := left),
					 ATMOST(keyed (Left.liens_party.tmsid = Right.tmsid) and 
							keyed (Left.liens_party.rmsid = Right.rmsid), riskwise.max_atmost));

liens_step2_overrides := join(liens_step1, fcra.key_Override_liensv2_party_ffid,
								keyed(right.flag_file_id = left.input.flag_file_id) and 
								left.input.file_id = fcra.file_id.LIEN,
								transform(liens_working, self.liens_party := right, self := left), atmost(riskwise.max_atmost));
// output(liens_step2_overrides, named('liens_step2_overrides'));

all_lien_party_info := ungroup(liens_step2 + liens_step2_overrides);

					  
liens_step3 := JOIN (all_lien_party_info, liensv2.key_liens_main_id_FCRA, 
					 Left.liens_party.tmsid<>'' AND
					 keyed (Left.liens_party.tmsid = Right.tmsid) and 
					 keyed (Left.liens_party.rmsid = Right.rmsid) and
					 ((string50)right.tmsid + (string50)right.rmsid <> left.input.record_id  // old way - exclude corrected records from prior to 11/13/2012
						and trim((string)right.persistent_record_id) <> left.input.record_id ) and  // new way - exclude corrected records that match the persistent_record_id		
					 FCRA.lien_is_ok (cutoff_date, right.orig_filing_date) and
					 (unsigned)right.orig_filing_date <= (unsigned)cutoff_date,
					 transform(liens_working, 
								status_count := count(right.filing_status);  // get the latest status
								filing_status := trim(stringlib.stringtouppercase(right.filing_status[status_count].filing_status));
								filing_status_desc := trim(stringlib.stringtouppercase(right.filing_status[status_count].filing_status_desc));
								self.liens_main.filing_status := filing_status;								
								self.liens_main.filing_status_desc := filing_status_desc;
								self.liens_main.filing_jurisdiction_name := LiensV2_Services.fn_get_filing_jurisdiction_name(right.filing_jurisdiction);
								
								self.liens_main := right, 
								
								self.open_lien := ((filing_status not in fcra.riskview_derogs_module.closed_lien_status and 
													filing_status_desc not in fcra.riskview_derogs_module.closed_lien_status)  // status rules
										and (trim(right.release_date)='' and trim(left.liens_party.date_last_seen)=''))   // additional release date check
											// for historical mode
											or ( (unsigned)right.release_date>=(unsigned)cutoff_date or (unsigned)left.liens_party.date_last_seen>=(unsigned)cutoff_date),							   
								self := left),
					 ATMOST(keyed (Left.liens_party.tmsid = Right.tmsid) and 
							keyed (Left.liens_party.rmsid = Right.rmsid), riskwise.max_atmost));


liens_step3_overrides := JOIN (all_lien_party_info, fcra.key_Override_liensv2_main_ffid,
								keyed(right.flag_file_id = left.input.flag_file_id) and 
								left.input.file_id = fcra.file_id.LIEN,
					 transform(liens_working, 
								status_count := count(right.filing_status);  // get the latest status
								filing_status := trim(stringlib.stringtouppercase(right.filing_status[status_count].filing_status));
								filing_status_desc := trim(stringlib.stringtouppercase(right.filing_status[status_count].filing_status_desc));
								self.liens_main.filing_status := filing_status;								
								self.liens_main.filing_status_desc := filing_status_desc;
								self.liens_main.filing_jurisdiction_name := LiensV2_Services.fn_get_filing_jurisdiction_name(right.filing_jurisdiction);
								self.liens_main := right, 
								self.open_lien := ((filing_status not in fcra.riskview_derogs_module.closed_lien_status and 
													filing_status_desc not in fcra.riskview_derogs_module.closed_lien_status)  // status rules
										and (trim(right.release_date)='' and trim(left.liens_party.date_last_seen)=''))   // additional release date check
											// for historical mode
											or ( (unsigned)right.release_date>=(unsigned)cutoff_date or (unsigned)left.liens_party.date_last_seen>=(unsigned)cutoff_date),							   
								self := left),
					 ATMOST(riskwise.max_atmost));
// output(liens_step3_overrides, named('liens_step3_overrides'));

all_lien_info := ungroup(liens_step3 + liens_step3_overrides);

							 
liens_step4 := dedup(sort(all_lien_info, input.seq, liens_main.tmsid, -liens_main.orig_filing_date, 
							-liens_main.filing_number, -liens_party.date_first_seen, -liens_party.date_last_seen), input.seq, liens_main.tmsid);


// bonnie made decision that customers will only want to see open_liens in the final report, filter out closed liens before joining to get county name
liens_w_county_name := join(liens_step4(open_lien), Census_Data.Key_Fips2County,
						left.liens_party.st<>'' and left.liens_party.county<>'' and
                        keyed (left.liens_party.st = right.state_code) and
                        keyed (left.liens_party.county[3..5] = right.county_fips),
                        transform(liens_working, self.liens_party.county_name := right.county_name, self := left),
						left outer, KEEP (1));


fcra.riskview_derogs_module.batch_layout summarize_bk_derogs(shell le, bk_w_county_name rt) := transform
	bk_on_file := rt.bk_main.case_number<>'';
	self.seq := le.shell_input.seq;
	self.did  := le.did;
	
	self.bankrupt := if(bk_on_file and rt.bk_main.disposition not in fcra.riskview_derogs_module.closed_bk_dispositions, 'Y', 'N') ;
	
	self.bankruptcy := rt.bk_main;
	self.bankruptcy := rt.bk_search;
	self.liens := [];
	self := le;
end;

j := join(shell, bk_w_county_name, left.shell_input.seq=right.input.seq,
			summarize_bk_derogs(left,right), left outer);  // use left outer to retain the seq and did


fcra.riskview_derogs_module.batch_layout summarize_lien_derogs(shell le, liens_w_county_name rt) := transform
	self.seq := le.shell_input.seq;
	self.did  := le.did;
	
	realtime_fed_set := ['FEDERAL TAX LIEN'];
	historical_fed_set := ['FEDERAL TAX LIEN', 'FEDERAL TAX RELEASE','FEDERAL TAX LIEN RELEASE'];
	fed_set := if(HistoryDateYYYYMMDD=99999999, realtime_fed_set, historical_fed_set);
	
	realtime_state_set :=   ['STATE TAX LIEN', 'ILLINOIS TAX LIEN', 'STATE TAX WARRANT', 'STATE TAX WARRANT RENEWED', 'STATE TAX LIEN RENEWAL'];
	historical_state_set := ['STATE TAX LIEN', 'ILLINOIS TAX LIEN', 'STATE TAX WARRANT', 'STATE TAX WARRANT RENEWED', 'STATE TAX LIEN RENEWAL',
							 'STATE TAX WARRANT RELEASE', 'STATE TAX RELEASE', 'STATE TAX LIEN RELEASE','ILLINOIS TAX RELEASE'];	
	state_set := if(HistoryDateYYYYMMDD=99999999, realtime_state_set, historical_state_set);
	
	realtime_county_set := ['COUNTY TAX LIEN'];
	historical_county_set := ['COUNTY TAX LIEN','COUNTY TAX LIEN RELEASE'];
	county_set := if(HistoryDateYYYYMMDD=99999999, realtime_county_set, historical_county_set);
	
	realtime_child_support_set := ['CHILD SUPPORT PAYMENT'];
	historical_child_support_set := ['CHILD SUPPORT PAYMENT RELEASE', 'CHILD SUPPORT PAYMENT'];
	child_support_set := if(HistoryDateYYYYMMDD=99999999, realtime_child_support_set, historical_child_support_set);
	
	fed_tax_lien := rt.liens_main.filing_type_desc in fed_set and rt.open_lien;
	state_tax_lien := rt.liens_main.filing_type_desc IN state_set and rt.open_lien;
	county_tax_lien := rt.liens_main.filing_type_desc IN county_set and rt.open_lien;
	child_support := rt.liens_main.filing_type_desc IN child_support_set and rt.open_lien;

	self.federal_tax_lien := if(fed_tax_lien, 'Y', 'N');
	self.federal_tax_amount := if(fed_tax_lien, rt.liens_main.amount, fcra.riskview_derogs_module.default_amount);
	self.state_tax_lien := if(state_tax_lien, 'Y', 'N');
	self.state_tax_amount := if(state_tax_lien, rt.liens_main.amount, fcra.riskview_derogs_module.default_amount);
	self.county_tax_lien := if(county_tax_lien, 'Y', 'N');
	self.county_tax_amount := if(county_tax_lien, rt.liens_main.amount, fcra.riskview_derogs_module.default_amount);
	self.child_support := if(child_support, 'Y', 'N');
	self.child_support_amount := if(child_support, rt.liens_main.amount, fcra.riskview_derogs_module.default_amount);
	
	self.liens := rt.liens_main;
	self.liens := rt.liens_party;
	self.bankruptcy := [];
	self := le;
end;

j2 := join(shell, liens_w_county_name, left.shell_input.seq=right.input.seq,
			summarize_lien_derogs(left,right));

merged := sort(ungroup(j(bankruptcy.case_number<>'') + j2), seq);

at_least_1_per_seq := join(j, merged, left.seq=right.seq, 
						transform(fcra.riskview_derogs_module.batch_layout, 
									self.hit := if(left.did!=0, 'Y', 'N');
									// if bankruptcy or liens have data, used merged dataset, otherwise return the default flags in j
									no_hit := right.bankruptcy.case_number='' and right.liens.tmsid='';
									self := if(no_hit, left, right)), left outer);


// output(with_ssn_flags, named('with_ssn_flags'));

// output(bk_step1a, named('bk_step1a'));
// output(bk_step1, named('bk_step1'));
// output(bk_step2, named('bk_step2'));
// output(bankrupt_full, named('bankrupt_full'));
// output(all_bankruptcy, named('all_bankruptcy'));
// output(bk_w_county_name, all, named('bk_w_county_name'));
// output(sort(j, seq), named('bk_summary'));
// output(liens_step1, named('liens_step1'));
// output(liens_step2, named('liens_step2'));
// output(all_lien_party_info, named('all_lien_party_info'));                 		
// output(liens_step3, named('liens_step3'));
// output(all_lien_info, named('all_lien_info'));
// output(liens_step4, named('liens_step4'));
// output(liens_w_county_name, all, named('liens_w_county_name'));
// output(sort(j2, seq), named('liens_summary'));

// output(merged, named('merged_datasets'));						
// output(at_least_1_per_seq, named('at_least_1_per_seq'));

return at_least_1_per_seq;

end;
