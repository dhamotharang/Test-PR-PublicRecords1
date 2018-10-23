import doxie_ln, fcra, suppress, ffd, LN_PropertyV2, ut, D2C;

export deed_records (
    DATASET (doxie_ln.layout_property_ids) ids,
    unsigned3 dateVal = 0,
    boolean ln_branded_value = false,
    unsigned choosen_value = 0,
    boolean IsFCRA = false,
    dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
    nonSS = suppress.constants.NonSubjectSuppression.doNothing,
    dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = ffd.Constants.BlankPersonContextBatchSlim,
    integer8 inFFDOptionsMask = 0
) := FUNCTION
  isCNSMR := ut.IndustryClass.is_Knowx;
  kdf := ln_propertyv2.key_deed_fid(isFCRA);
  kdaddlfares := LN_PropertyV2.key_addl_fares_deed_fid;
  
  boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
	boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);

  //get all IDs together
  more_ids := rollup(sort(ids (fid[2]<>'A'), fid, source_code[1]), 
                     left.fid = right.fid and
                     left.source_code[1] = right.source_code[1],
                     transform(doxie_ln.layout_property_ids,
                               self.current := left.current or right.current,
                               self.address_seq_no := MAX (left.address_seq_no,right.address_seq_no),
                               self := right));
                               
  //join em to prop
  string stripz(string s) := (string)((integer8)s);

  rec := doxie_ln.layout_deed_records;

  final_ids := IF (choosen_value=0,
                   more_ids,
                   choosen(more_ids(current),choosen_value) +
                   choosen(more_ids(~current),choosen_value));

  rec take_right2 (more_ids l, kdf r) := transform
    self.current := l.current;
    self.address_seq_no := l.address_seq_no;
    self.source_code := l.source_code[1];
    self.sales_price := stripz(r.sales_price);
    self.first_td_loan_amount := stripz(r.first_td_loan_amount);
    self.title_company_name := ut.fn_KeepPrintableChars(r.title_company_name);
    self.did := L.did;
    self.bdid := L.bdid;
    self.vendor_source_flag := doxie_LN.Translate_Vendor_Source_Flag(r.vendor_source_flag);
  
    // add mapping from name1 and name2 based on buyer_or_borrower flag to populated buyer1, borrower1 etc
    buyer := r.buyer_or_borrower_ind='O';
    borrower := r.buyer_or_borrower_ind='B';
    self.buyer1 := if(buyer and nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.name1, '');
    self.buyer1_id_code := if(buyer and nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.name1_id_code , '');
    self.buyer2 := if(buyer and nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.name2 , '');
    self.buyer2_id_code := if(buyer and nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.name2_id_code , '');
    self.buyer_vesting_code := if(buyer and nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.vesting_code , '');
    self.buyer_addendum_flag := if(buyer and nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.addendum_flag , '');
    self.buyer_mailing_address_care_of_name := if(buyer and nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.mailing_care_of , '');
    self.buyer_mailing_full_street_address := if(buyer and nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.mailing_street , '');
    self.buyer_mailing_address_unit_number := if(buyer and nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.mailing_unit_number , '');
    self.buyer_mailing_address_citystatezip := if(buyer and nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.mailing_csz , '');
    self.borrower1 := if(borrower and nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.name1 , '');
    self.borrower1_id_code := if(borrower and nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.name1_id_code , '');
    self.borrower2 := if(borrower and nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.name2 , '');
    self.borrower2_id_code := if(borrower and nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.name2_id_code , '');
    self.borrower_vesting_code := if(borrower and nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.vesting_code , '');
    self.borrower_mailing_full_street_address := if(borrower and nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.mailing_street , '');
    self.borrower_mailing_unit_number := if(borrower and nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.mailing_unit_number , '');
    self.borrower_mailing_citystatezip := if(borrower and nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.mailing_csz , '');
    self.borrower_address_code := if(borrower and nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.mailing_address_cd , '');
    self.seller1 := if(nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.seller1 , '');
    self.seller2 := if(nonSS = suppress.constants.NonSubjectSuppression.doNothing , r.seller2 , '');
  
    // fares fields will come from addl_fares_key
    self.fares_corporate_indicator := ''; 
    self.fares_transaction_type := ''; 
    self.fares_lender_address := ''; 
    self.fares_mortgage_date := ''; 
    self.fares_mortgage_deed_type := ''; 
    self.fares_mortgage_term_code := ''; 
    self.fares_mortgage_term := '';
    self.fares_building_square_feet := ''; 
    self.fares_foreclosure := ''; 
    self.fares_refi_flag := ''; 
    self.fares_equity_flag := ''; 
    self.fares_iris_apn := ''; 
    
    // TODO: determine if these fields are being used... if not, remove them from the layout and the transform
    self.visf_buyer_address := '';
    self.visf_seller_address := '';
    self.visf_property_address := '';
    self.hawaii_property_address_unit_number := '';
    self.hawaii_legal := '';
    self.dummy_seg := '';
    self.lexis_number := '';
    self.page_number := '';
    self.township := '';
    self.land_use_code := '';
    self.audit_trail := '';
    self.audit1 := '';
    self.audit2 := '';
    self.audit3 := '';
    self.file_code := '';
    self.fs_profile := '';
    self.on_lexis := '';
    self.report_number := '';
    self.source := '';
    self.content := '';
    self.lxdseg := '';
    self.OKCTY_DEED_filler := '';
    self.OKCTY_DEED_reserved := '';
    self.OKCTY_DEED_reserved2 := '';
    self.OKCTY_MORT_filler := '';
    self.OKCTY_MORT_filler2 := '';
  
    self := r;
  end;


  rec get_addl_fares (rec l, kdaddlfares r) := transform  
    self.fares_corporate_indicator := r.fares_corporate_indicator; 
    self.fares_transaction_type := r.fares_transaction_type; 
    self.fares_lender_address := r.fares_lender_address; 
    self.fares_mortgage_date := r.fares_mortgage_date; 
    self.fares_mortgage_deed_type := r.fares_mortgage_deed_type; 
    self.fares_mortgage_term_code := r.fares_mortgage_term_code; 
    self.fares_mortgage_term := stripz(r.fares_mortgage_term); 
    self.fares_building_square_feet := r.fares_building_square_feet; 
    self.fares_foreclosure := r.fares_foreclosure; 
    self.fares_refi_flag := r.fares_refi_flag; 
    self.fares_equity_flag := r.fares_equity_flag; 
    self.fares_iris_apn := r.fares_iris_apn; 
    self := l;
  end;

  flags := flagfile (file_id=FCRA.FILE_ID.DEED); // prefilter in advance

  outf_reg_base := JOIN (final_ids, kdf,
                         left.fid <> '' and keyed (left.fid=right.ln_fares_id)
                         and ~((string)right.ln_fares_id in set( flags((unsigned6)did=left.did ),record_id) and isFCRA)
												             and (~isCNSMR or right.vendor_source_flag not in D2C.Constants.LNPropertyV2RestrictedSources ),
                         take_right2 (left, right), keep (1), limit (0)); //should be atmost one record at right anyway

  // adding join to addl_fares key to populate fares fields for non-fcra comp report        
  outf_reg := JOIN (outf_reg_base, kdaddlfares,
                    left.ln_fares_id <> '' and keyed (left.ln_fares_id=right.ln_fares_id),
                    get_addl_fares (left, right), keep (1), limit (0), left outer); //should be atmost one record at right anyway
    
  // use_finalids to connect to the overrides  
  deed_over := join( flags, FCRA.key_override_property.deed,
                    keyed(left.flag_file_id = right.flag_file_id) and isFCRA,
                    transform(recordof(kdf),self:=right,self:=[]),
                    keep(ut.limits.OVERRIDE_LIMIT), limit(0));

  deed_fcra:= outf_reg_base + join(final_ids, deed_over,
                                   left.fid = right.ln_fares_id and isFCRA,  
                                   take_right2 (left, right),keep(1),limit(0));

  rec add_statement_ids ( rec l, FFD.Layouts.PersonContextBatchSlim r ) := transform,
  skip((~showDisputedRecords and r.isdisputed) or (~ShowConsumerStatements and exists(R.StatementIDs))) 
    self.statementids := r.StatementIDs;
    self.isdisputed :=  r.isdisputed;
    self := L;
  end;

  deed_ffd := join(deed_fcra, slim_pc_recs(datagroup=FFD.Constants.DataGroups.DEED),
                   left.ln_fares_id = right.recid1
                   and left.did = (unsigned) right.lexid,
                   add_statement_ids(left, right),
                   left outer, keep(1), limit(0));
    
  outf := IF (IsFCRA, deed_ffd, outf_reg);

  rec iter(rec le, rec ri) := TRANSFORM
    SELF.address_seq_no := IF(ri.address_seq_no=99999,le.address_seq_no+1,ri.address_seq_no);
    SELF := ri;
  END;
  out := UNGROUP (ITERATE(group(SORT(outf, did, bdid, address_seq_no),did,bdid), iter(LEFT,RIGHT)));
  RETURN out((source_code <> 'B' or ln_branded_value) AND
             (dateVal = 0 OR (unsigned3)(contract_date[1..6]) <= dateVal));

END;