// IMPORTANT: at this point this is strictly FCRA attribute (non-FCRA is implemented in /bk_records)

import ut, codes, Riskwise, FCRA, bankrupt, Bankruptcyv3_Services, 
       bankruptcyv3, iesp, suppress, FFD, STD;

// pull bankruptcy data from the BankruptcyV3 keys and puts it back into V1 or V3 layout for return in FCRA comp report
// replaces the line in FCRA comp report that was referencing doxie/bk_records2

EXPORT bk_records_v3 (
	DATASET (doxie.layout_references) dids, 
	string6 ssn_mask = 'NONE',
	string1 party_type = '',
	boolean IsFCRA = true,
	dataset (fcra.Layout_override_flag) ds_flagfile = fcra.compliance.blank_flagfile,
	nonSS = suppress.constants.NonSubjectSuppression.doNothing,
	dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
	integer8 inFFDOptionsMask = 0,
	boolean suppress_withdrawn_bankruptcy = false
) := MODULE

shared rdid := (unsigned6)dids[1].did; //for FCRA dids should only have one record

// ====================================================
// =============== v3 data in v1 layout ===============
// ====================================================

// Note: this code is debtors-based, i.e. all data are derived starting from fetching debtors;
search_rec := record
	unsigned6 did;
	string9 ssn;
	string30 fname;
	string30 lname;
	string30 mname;
	// flag fields
	string20 flag_file_id;
	string20 file_id;
	string100 record_id;
	string50 tmsid := '';
end;

bankrupt_recordid := SET (ds_flagfile, record_id);
bankrupt_ffid := SET (ds_flagfile, flag_file_id);

bk_search_working := record
	search_rec input;
	bankrupt.layout_bk_crs_search;
	string12	CaseID;  //for withdrawn status processing
	string12	DefendantID;  //for withdrawn status processing
  bankrupt.layout_bk_crs_main bk_main;
end;
				
bk_tmsids := join(dids, BankruptcyV3.key_bankruptcyV3_did(isFCRA),
				left.did!=0 and keyed(left.did=right.did) and
				(TRIM (Right.court_code) + Right.case_number NOT IN bankrupt_recordid),  // filter out any records that match the correction file
				transform(bk_search_working, 
						self.input.tmsid := right.tmsid;
						self.input := left,
						self := right,
						self := []), 
						atmost(riskwise.max_atmost));
						
bk_debtors := join(bk_tmsids, BankruptcyV3.key_bankruptcyv3_search_full_bip(isFCRA),
				left.input.tmsid!='' and keyed(left.input.tmsid=right.tmsid) and right.name_type[1]='D' and
				(TRIM (Right.tmsid) + trim(Right.name_type) + trim(right.did) NOT IN bankrupt_recordid), 
				transform(bk_search_working, 
						self.input := left.input,
						self.debtor_ssn := right.ssn,
						self.debtor_title := right.title,
						self.debtor_fname := right.fname,
						self.debtor_mname := right.mname,
						self.debtor_lname := right.lname,
						self.debtor_name_suffix := right.name_suffix,
						self.debtor_company := right.cname,
						self.suffix := right.addr_suffix,
						self.z5 := right.zip,
						self.debtor_did := right.did,
						self.score := right.name_score,
						self.debtor_did_score := '',
						self.bk_main.disposition := trim(stringlib.stringtouppercase(right.disposition));	
						self.bk_main.disposed_date := right.discharged;
						self.bk_main.chapter := right.chapter;
						self.bk_main.filing_type := right.filing_type;
						self.bk_main.orig_filing_type := right.filing_type;
						self.bk_main.pro_se_ind := right.pro_se_ind;
						self.bk_main.record_type := right.record_type;
						self.bk_main.converted_date := right.converted_date;
						self.bk_main.corp_flag := right.corp_flag;
						self.bk_main := [];
						self := right), 
						atmost(riskwise.max_atmost));


bankrupt_debtor_overrides:= join(ds_flagfile, fcra.key_override_bkv3_search_ffid, 
							keyed(right.flag_file_id = left.flag_file_id) and right.name_type[1]='D',
						transform(bk_search_working, 
											self.input.did := (unsigned)left.did;
											self.input := left;
											self.debtor_ssn := right.ssn,
											self.debtor_title := right.title,
											self.debtor_fname := right.fname,
											self.debtor_mname := right.mname,
											self.debtor_lname := right.lname,
											self.debtor_name_suffix := right.name_suffix,
											self.debtor_company := right.cname,
											self.suffix := right.addr_suffix,
											self.z5 := right.zip,
											self.debtor_did := right.did,
											self.score := right.name_score,
											self.debtor_did_score := '',
											self.bk_main.disposition := trim(stringlib.stringtouppercase(right.disposition));	
											self.bk_main.disposed_date := right.discharged;
											self.bk_main.chapter := right.chapter;
											self.bk_main.filing_type := right.filing_type;
											self.bk_main.orig_filing_type := right.filing_type;
											self.bk_main.pro_se_ind := right.pro_se_ind;
											self.bk_main.record_type := right.record_type;
											self.bk_main.converted_date := right.converted_date;
											self.bk_main.corp_flag := right.corp_flag;
											self.bk_main := [];
											self := right),
								limit(0), keep(ut.limits.OVERRIDE_LIMIT));
						
bk_debtors_row := if(exists(bankrupt_debtor_overrides), bankrupt_debtor_overrides, bk_debtors);
Suppress.MAC_Mask(bk_debtors_row, bk_debtors_masked, debtor_ssn, null, true, false, maskVal:=ssn_mask);

// add withdrawn status
withdrawn_bk_key := BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus(,,isFCRA);

bk_search_working xform_add_withdrawn (bk_search_working le, withdrawn_bk_key ri) := transform,
	skip(suppress_withdrawn_bankruptcy AND ri.withdrawndate <> '')
		self.WithdrawnStatus.withdrawnid := ri.withdrawnid;
		self.WithdrawnStatus.withdrawndate := ri.withdrawndate;
		self.WithdrawnStatus.withdrawndisposition := ri.withdrawndisposition;
		self.WithdrawnStatus.withdrawndispositiondate := ri.withdrawndispositiondate;
		self := le;
	end;

bk_debtors_plus_withdrawn := JOIN(bk_debtors_masked, withdrawn_bk_key,
												keyed(left.input.tmsid = right.tmsid and left.caseID = right.caseID  and left.DefendantID = right.DefendantID),
												xform_add_withdrawn(left,right),
												left outer,
												keep(1), limit(0));

attorneys := rollup(sort(
													join(bk_tmsids,BankruptcyV3.key_bankruptcyv3_search_full_bip(isFCRA),
													keyed(left.input.tmsid = right.tmsid) and right.name_type[1] ='A' and
													(trim (Right.tmsid) + trim(Right.name_type) + trim(right.did) NOT IN bankrupt_recordid), 
													transform(right), atmost(ut.limits.BANKRUPT_MAX)),
										tmsid,name_type),
									left.tmsid = right.tmsid and
									left.name_type = right.name_type,
									transform(recordof(BankruptcyV3.key_bankruptcyv3_search_full_bip()),
										self.orig_company := if(left.orig_company = '',right.orig_company,left.orig_company),
										self.orig_name := if(left.orig_name = '',right.orig_name,left.orig_name),
										self.orig_fname := if(left.orig_fname = '',right.orig_fname,left.orig_fname),
										self.orig_mname := if(left.orig_mname = '',right.orig_mname,left.orig_mname),
										self.orig_lname := if(left.orig_lname = '',right.orig_lname,left.orig_lname),
										self := left));
										

with_bk_attorney1 := join(bk_debtors_plus_withdrawn, attorneys,
				left.input.tmsid=right.tmsid and right.name_type='A1',
				transform(bk_search_working, 
						self.input := left.input,
						self.bk_main.attorney_name := if(right.orig_name = '',
							trim(right.orig_fname) + ' ' + trim(right.orig_lname),
							right.orig_name),
						self.bk_main.attorney_phone := right.phone,
						self.bk_main.attorney_company := right.orig_company,
						self.bk_main.attorney_address1 := right.orig_addr1,
						self.bk_main.attorney_address2 := right.orig_addr2,
						self.bk_main.attorney_city := right.orig_city,
						self.bk_main.attorney_st := right.orig_st,
						self.bk_main.attorney_zip := right.orig_zip5,
						self.bk_main.attorney_zip4 := right.orig_zip4,
						self.bk_main := left.bk_main;
						self := left), left outer,
						 keep(1),limit(0));

with_bk_attorney2 := join(with_bk_attorney1, attorneys,
				left.input.tmsid=right.tmsid and right.name_type='A2',
				transform(bk_search_working, 
						self.input := left.input,
						self.bk_main.attorney2_name := if(right.orig_name = '',
								trim(right.orig_fname) + ' ' + trim(right.orig_lname),
								right.orig_name),
							self.bk_main.attorney2_phone := right.phone,
							self.bk_main.attorney2_company := right.orig_company,
							self.bk_main.attorney2_address1 := right.orig_addr1,
							self.bk_main.attorney2_address2 := right.orig_addr2,
							self.bk_main.attorney2_city := right.orig_city,
							self.bk_main.attorney2_st := right.orig_st,
							self.bk_main.attorney2_zip := right.orig_zip5,
							self.bk_main.attorney2_zip4 := right.orig_zip4,
							self.bk_main := left.bk_main;
							self := left), left outer,
						 keep(1),limit(0));

bk_main_key := BankruptcyV3.key_bankruptcyV3_main_full(isFCRA);

// if no s_casenum in the result, means there was no bankruptcy hit or the bankruptcy was older than 10 years
bk_search_working add_bankruptcy_main(bk_search_working le, bk_main_key rt) := transform
	self.bk_main.court_name := codes.BANKRUPTCIES.COURT_CODE(rt.court_code);
	self.bk_main.disposition := le.bk_main.disposition;	
	self.bk_main.disposed_date := le.bk_main.disposed_date;
	self.bk_main.chapter := le.bk_main.chapter;
	self.bk_main.filing_type := le.bk_main.filing_type;
	self.bk_main.orig_filing_type := le.bk_main.orig_filing_type;
	self.bk_main.pro_se_ind := le.bk_main.pro_se_ind;
	self.bk_main.record_type := le.bk_main.record_type;
	self.bk_main.converted_date := le.bk_main.converted_date;
	self.bk_main.corp_flag := le.bk_main.corp_flag;
	self.bk_main.attorney_name := le.bk_main.attorney_name ;
	self.bk_main.attorney_phone := le.bk_main.attorney_phone ;
	self.bk_main.attorney_company := le.bk_main.attorney_company ;
	self.bk_main.attorney_address1 := le.bk_main.attorney_address1 ;
	self.bk_main.attorney_address2 := le.bk_main.attorney_address2 ;
	self.bk_main.attorney_city := le.bk_main.attorney_city ;
	self.bk_main.attorney_st := le.bk_main.attorney_st ;
	self.bk_main.attorney_zip := le.bk_main.attorney_zip ;
	self.bk_main.attorney_zip4 := le.bk_main.attorney_zip4 ;
	self.bk_main.attorney2_name := le.bk_main.attorney2_name ;
	self.bk_main.attorney2_phone := le.bk_main.attorney2_phone ;
	self.bk_main.attorney2_company := le.bk_main.attorney2_company ;
	self.bk_main.attorney2_address1 := le.bk_main.attorney2_address1 ;
	self.bk_main.attorney2_address2 := le.bk_main.attorney2_address2 ;
	self.bk_main.attorney2_city := le.bk_main.attorney2_city ;
	self.bk_main.attorney2_st := le.bk_main.attorney2_st ;
	self.bk_main.attorney2_zip := le.bk_main.attorney2_zip ;
	self.bk_main.attorney2_zip4 := le.bk_main.attorney2_zip4 ;	
	self.bk_main.trustee_name := rt.trusteename;
	self.bk_main.trustee_phone := rt.trusteephone ;
	self.bk_main.trustee_company := '';  //rt.trusteename ;  // no company name for trustee, is it simply the trusteename ??  leaving it blank for now
	self.bk_main.trustee_address1 := rt.trusteeaddress ;
	self.bk_main.trustee_city := rt.trusteecity ;
	self.bk_main.trustee_st := rt.trusteestate ;
	self.bk_main.trustee_zip := rt.trusteezip ;
	self.bk_main.trustee_zip4 := rt.trusteezip4 ;
	self.bk_main := rt;
	self := le;
end;

cutoff_date := (STRING8)Std.Date.Today();

bankrupt_full := JOIN (with_bk_attorney2, bk_main_key,
						LEFT.input.tmsid<>'' AND
						keyed(LEFT.input.tmsid = RIGHT.tmsid) AND
						FCRA.bankrupt_is_ok(cutoff_date,RIGHT.date_filed) and 
						(unsigned)right.date_filed <= (unsigned)cutoff_date and
						(TRIM (Right.court_code) + Right.case_number <> left.input.record_id),  // filter out any records that match the correction file
						add_bankruptcy_main(left, right),
						ATMOST(riskwise.max_atmost));
							
// bankrupt_main_overrides := join(bk_step2, fcra.key_Override_bk_main_ffid, 
bankrupt_main_overrides := join(with_bk_attorney2, fcra.key_override_bkv3_main_ffid, 
						keyed(right.flag_file_id = left.input.flag_file_id),
						transform(bk_search_working,
									self.bk_main.court_name := codes.BANKRUPTCIES.COURT_CODE(right.court_code);
									self.bk_main.disposition := left.bk_main.disposition;	
									self.bk_main.disposed_date := left.bk_main.disposed_date;
									self.bk_main.chapter := left.bk_main.chapter;
									self.bk_main.filing_type := left.bk_main.filing_type;
									self.bk_main.orig_filing_type := left.bk_main.orig_filing_type;
									self.bk_main.pro_se_ind := left.bk_main.pro_se_ind;
									self.bk_main.record_type := left.bk_main.record_type;
									self.bk_main.converted_date := left.bk_main.converted_date;
									self.bk_main.corp_flag := left.bk_main.corp_flag;
									self.bk_main.attorney_name := left.bk_main.attorney_name ;
									self.bk_main.attorney_phone := left.bk_main.attorney_phone ;
									self.bk_main.attorney_company := left.bk_main.attorney_company ;
									self.bk_main.attorney_address1 := left.bk_main.attorney_address1 ;
									self.bk_main.attorney_address2 := left.bk_main.attorney_address2 ;
									self.bk_main.attorney_city := left.bk_main.attorney_city ;
									self.bk_main.attorney_st := left.bk_main.attorney_st ;
									self.bk_main.attorney_zip := left.bk_main.attorney_zip ;
									self.bk_main.attorney_zip4 := left.bk_main.attorney_zip4 ;
									self.bk_main.attorney2_name := left.bk_main.attorney2_name ;
									self.bk_main.attorney2_phone := left.bk_main.attorney2_phone ;
									self.bk_main.attorney2_company := left.bk_main.attorney2_company ;
									self.bk_main.attorney2_address1 := left.bk_main.attorney2_address1 ;
									self.bk_main.attorney2_address2 := left.bk_main.attorney2_address2 ;
									self.bk_main.attorney2_city := left.bk_main.attorney2_city ;
									self.bk_main.attorney2_st := left.bk_main.attorney2_st ;
									self.bk_main.attorney2_zip := left.bk_main.attorney2_zip ;
									self.bk_main.attorney2_zip4 := left.bk_main.attorney2_zip4 ;	
									self.bk_main.trustee_name := right.trusteename;
									self.bk_main.trustee_phone := right.trusteephone ;
									self.bk_main.trustee_company := '';  //right.trusteename ;  // no company name for trustee, is it simply the trusteename ??  leaving it blank for now
									self.bk_main.trustee_address1 := right.trusteeaddress ;
									self.bk_main.trustee_city := right.trusteecity ;
									self.bk_main.trustee_st := right.trusteestate ;
									self.bk_main.trustee_zip := right.trusteezip ;
									self.bk_main.trustee_zip4 := right.trusteezip4 ;		
									self.bk_main := right;
									self := left),
									limit(0), keep(ut.limits.OVERRIDE_LIMIT));

all_bankruptcy := ungroup(bankrupt_full + bankrupt_main_overrides);

f_main_raw := dedup(sort(all_bankruptcy, input.tmsid), input.tmsid); // safe to assume always implicit by did (?)

boolean showDisputedRecords := FFD.FFDMask.isShowDisputedBankruptcies(inFFDOptionsMask);
boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);

bankrupt.layout_bk_crs_main appendMainStatementIDs(bk_search_working l, FFD.Layouts.PersonContextBatchSlim r ) := transform,
	skip((~showDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs)))
		self.StatementIds := r.StatementIDs;
		self.IsDisputed := r.isDisputed;
		self := l.bk_main;
end;

// project the results in to file of main 
f_main := 
	join(f_main_raw, slim_pc_recs(datagroup = FFD.Constants.DataGroups.BANKRUPTCY_MAIN, acctno = FFD.Constants.SingleSearchAcctno),
		left.input.did = (unsigned6) right.lexid 
			and left.input.tmsid = right.recid1,				
		appendMainStatementIDs(left, right),
		left outer, keep(1), limit(0));		
		 
bankrupt.layout_bk_crs_search addDebtorStatementIds(bk_search_working l, FFD.Layouts.PersonContextBatchSlim r ) := transform,
	skip((~showDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs)))
		self.StatementIds := r.StatementIDs;
		self.IsDisputed := r.isDisputed;
		self := l;		
end;

// project the results into search file
raw_search := 
	join(all_bankruptcy, slim_pc_recs(datagroup = FFD.Constants.DataGroups.BANKRUPTCY_SEARCH, acctno = FFD.Constants.SingleSearchAcctno),
		left.input.did = (unsigned6) right.recid3 
			and left.input.tmsid = right.recid1
				and right.recid2 = BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR,
			addDebtorStatementIds(left, right),
			left outer, keep(1), limit(0));		

// re-use the old function to put the results into CRSOutput
bk_formatted := Bankrupt.GetCRSOutput(f_main, raw_search, , , ,IsFCRA);

//by request: leave only records where at least one of the debtors is a subject
bk_out := bk_formatted ((party_type != 'D') or exists (debtor_records ((unsigned6)debtor_did = rdid))); 

//apply non-subject suppression
doxie.Layout_BK_output_ext xformNonSubject (doxie.Layout_BK_output_ext L) := transform
	debtors_supp := L.debtor_records((unsigned6)debtor_did = rdid);
	debtors_restricted := debtors_supp + project(L.debtor_records(~((unsigned6)debtor_did = rdid)), 
																							 transform(doxie.layout_bk_child_ext,
																												self.names := project(left.names, 
																																							transform(bankrupt.layout_bk_search_name,
																																												self.debtor_lname := FCRA.Constants.FCRA_Restricted, 
																																												self := [])),
																												self := []));
	self.debtor_records := map(nonSS = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription => debtors_restricted, 
														 nonSS = Suppress.Constants.NonSubjectSuppression.returnBlank => debtors_supp,
														 L.debtor_records);
	self := L;
end;

bk_nss := project(bk_out, xformNonSubject(left));

bk_final := if(nonSS <> Suppress.Constants.NonSubjectSuppression.doNothing, 
							 bk_nss,
							 bk_out);

EXPORT format_v1 := if (IsFCRA, bk_final);


// ====================================================
// =============== v3 data in v1 layout ===============
// ====================================================

// There's a choice: either use "format_v1" or use the data produced for a stand alone bk-report 
// as in BankruptcyV3_Services/BankruptcyReportServiceFCRA
// At this point it seems more appropriate to take more complete report results.

// NB: other compound person reports refer to this code (Prelit, for instance)
// NB: input flag file is ignored: it is calculated inside source_view

  bk_v3_pre := BankruptcyV3_Services.bankruptcy_raw (IsFCRA).source_view (dids, 
                                                                     in_ssn_mask := ssn_mask,
                                                                     in_party_type := party_type,
                                                                     include_dockets := false,
																																		 suppress_withdrawn_bankruptcy := suppress_withdrawn_bankruptcy);
																																		 
	bk_v3 := BankruptcyV3_Services.fn_fcra_ffd(bk_v3_pre, slim_pc_recs, inFFDOptionsMask);
	
// Non-subject suppression is not in use at the moment
/*
	//apply non-subject suppression	
	bk_v3 xformNonSubject(bk_v3 L) := transform
		debtors_supp := project(L.debtors((unsigned6)did = (unsigned6)rdid),
													 transform(BankruptcyV3_Services.layouts.layout_party,
																		 self.names := project(left.names, transform(BankruptcyV3_Services.layouts.layout_name,
																																								 self.orig_name := '', 
																																								 self := left)),
																		 self := left));
		debtors_restricted := debtors_supp + project(L.debtors(~((unsigned6)did = (unsigned6)rdid)), 
																								 transform(BankruptcyV3_Services.layouts.layout_party,
																													self.names := project(left.names, 
																																								transform(BankruptcyV3_Services.layouts.layout_name,
																																													self.lname := FCRA.Constants.FCRA_Restricted, 
																																													self := [])),
																													self := []));
		self.debtors := map(nonSS = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription => debtors_restricted, 
												nonSS = Suppress.Constants.NonSubjectSuppression.returnBlank => debtors_supp,
												L.debtors);
		self := L;
	end;
	bk_v3_nss := project(bk_v3, xformNonSubject(left));
										 
	bk_v3_final := if(nonSS <> Suppress.Constants.NonSubjectSuppression.doNothing, 
								 bk_v3_nss,
								 bk_v3);
*/

  // transform to V3 ESDL layout
  bk_v3_output := iesp.transform_bankruptcy_v3 (bk_v3);

  // ESP reads query output into V2 layout, where, among other things, some fields are defined 
  // at a {bankruptcy} record level instead of {debtor}.
  // In ESDL architecture we don't have a choice but to patch a query: create a duplicate fields in {bankruptcy}.
  // It has to be this way until ESP switches to proper V3 output.
  iesp.bankruptcy_fcra.t_FcraBankruptcy3BpsRecord patchV3 (iesp.bankruptcy_fcra.t_FcraBankruptcy3BpsRecord L) := TRANSFORM
    // populate record level fields with the subject's {debtor} data;
    // even if we have more than one debtor, on FCRA side we can suggest a plausible explanation
    // (FCRA is about "the subject", etc.)
    subj_debtor := L.debtors ((unsigned6) UniqueId = rdid)[1];

    // SELF.FilingType := subj_debtor.FilingType; // a translation of it is already returned
    SELF.Chapter := subj_debtor.Chapter;
    SELF.CorpFlag := subj_debtor.CorpFlag;
    SELF.Disposition := subj_debtor.Disposition;
    SELF.SelfRepresented := subj_debtor.SelfRepresented;
    SELF.DischargeDate := subj_debtor.DischargeDate;

    SELF := L;
  END;
  bk_v3_patch := PROJECT (bk_v3_output, patchV3 (LEFT));

  // only FCRA implementation
  EXPORT format_v3 := if (IsFCRA, bk_v3_patch);
END;