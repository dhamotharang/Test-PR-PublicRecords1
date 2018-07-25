import doxie_ln, fcra, suppress, ffd, LN_PropertyV2, ut, codes, D2C;

export asses_records(
    DATASET (doxie_ln.layout_property_ids) ids,
    unsigned3 dateVal = 0,
    boolean ln_branded_value = false, // not used, just to be symmetrical with deeds
    unsigned choosen_value = 0,
    boolean IsFCRA = false,
    dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
    nonSS = suppress.constants.NonSubjectSuppression.doNothing,
    dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
    integer8 inFFDOptionsMask = 0
) := FUNCTION
  isCNSMR := ut.IndustryClass.is_Knowx;
  kaf := LN_PropertyV2.key_assessor_fid(isFCRA);

  kdaddlfares := LN_PropertyV2.key_addl_fares_tax_fid;

  boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
	boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
  string stripz(string s) := (string)((integer8)s);

  //get all IDs together
  more_ids := rollup(sort(ids (fid[2]='A'), fid, source_code[1]), 
                     left.fid = right.fid and
                     left.source_code[1] = right.source_code[1],
                     transform(doxie_ln.layout_property_ids,
                               self.current := left.current or right.current,
                               self.address_seq_no := MAX(left.address_seq_no,right.address_seq_no),
                               self := right));

  final_ids := IF (choosen_value=0,
                   more_ids,
                   choosen(more_ids(current),choosen_value DIV 2) + 
                   choosen(more_ids(~current),choosen_value DIV 2));

  rec := doxie_ln.layout_assessor_records;

  rec take_right (final_ids l, kaf r) := transform
    self.current := l.current;
    SELF.address_seq_no := l.address_seq_no;
    self.source_code := l.source_code[1];
    self.land_square_footage := doxie_ln.functions.GetSquareFootage (r.land_acres, r.land_square_footage);
    self.did := L.did;
    self.bdid := L.bdid;
    self.vendor_source_flag := doxie_LN.Translate_Vendor_Source_Flag(r.vendor_source_flag);
    self.process_date := (string)R.proc_date;
    self.land_use_decoded := '';
    self.assessee_name := if (nonSS = suppress.constants.NonSubjectSuppression.doNothing,r.assessee_name,'');
    self.second_assessee_name := if (nonSS = suppress.constants.NonSubjectSuppression.doNothing,r.second_assessee_name,'');
    self.mailing_care_of_name:= if (nonSS = suppress.constants.NonSubjectSuppression.doNothing,r.mailing_care_of_name,'');
    self.mailing_full_street_address:= if (nonSS = suppress.constants.NonSubjectSuppression.doNothing,r.mailing_full_street_address,'');
    self.mailing_unit_number:= if (nonSS = suppress.constants.NonSubjectSuppression.doNothing,r.mailing_unit_number,'');
    self.mailing_city_state_zip:= if (nonSS = suppress.constants.NonSubjectSuppression.doNothing,r.mailing_city_state_zip,'');

    // TODO: determine if these fields are being used... if not, remove them from the layout and the transform
/*   self.visf_mailing_address := '';
     self.visf_prop_address := '';
     self.dummy_seg := '';
     self.lexis_no := '';
     self.page_no := '';
     self.owner_2 := '';
     self.message_1 := '';
     self.message_2 := '';
     self.vdi := '';
     self.audit_trail := '';
     self.audit_1 := '';
     self.audit_2 := '';
     self.audit_3 := '';
     self.file_code := '';
     self.on_lexis := '';
     self.source := '';
     self.content := '';
     self.copy_2 := '';
     self.lxdseg := '';
     self.filler2 := '';
*/
  
    self := r;
    self := [];
  end;


  // only need to use this on non-fcra.  FCRA query can't use Fares data
  rec get_addl_fares_tax (rec l, kdaddlfares r) := transform  
  
    self.fares_iris_apn := r.fares_iris_apn;
    self.fares_non_parsed_assessee_name := r.fares_non_parsed_assessee_name;
    self.fares_non_parsed_second_assessee_name := r.fares_non_parsed_second_assessee_name;  
    self.fares_legal2 := '';  // field not in addl fares tax layout
    self.fares_legal3 := '';  // field not in addl fares tax layout  
    self.fares_land_use := r.fares_land_use;  
    self.fares_seller_name := r.fares_seller_name;
    self.fares_calculated_land_value := stripz(r.fares_calculated_land_value);
    self.fares_calculated_improvement_value := stripz(r.fares_calculated_improvement_value);
    self.fares_calculated_total_value := stripz(r.fares_calculated_total_value);
    self.fares_living_square_feet := r.fares_living_square_feet;
    self.fares_adjusted_gross_square_feet := stripz(r.fares_adjusted_gross_square_feet);
    self.fares_no_of_full_baths := r.fares_no_of_full_baths;
    self.fares_no_of_half_baths := r.fares_no_of_half_baths;
    self.fares_pool_indicator := r.fares_pool_indicator;  
    self.fares_frame := r.fares_frame;
    self.fares_electric_energy := r.fares_electric_energy;
    self.fares_sewer := r.fares_sewer;
    self.fares_water := r.fares_water;
    self.fares_condition := r.fares_condition; 
                      
    self.land_use_decoded := codes.FARES_2580.land_use(l.vendor_source_flag, r.fares_land_use);
  
    self := l;
  end;

  flags := flagfile (file_id=FCRA.FILE_ID.ASSESSMENT); // prefilter in advance


  outf_reg_base := JOIN (final_ids, kaf,
                         left.fid <> '' and keyed (left.fid=right.ln_fares_id)
                         and ~((string)right.ln_fares_id in set(flags((unsigned6)did=left.did ),record_id) and isFCRA)
												             and (~isCNSMR or right.vendor_source_flag not in D2C.Constants.LNPropertyV2RestrictedSources ),
                         take_right (left, right), KEEP (1), LIMIT (0)); 

  outf_reg := JOIN (outf_reg_base, kdaddlfares,
                    left.ln_fares_id <> '' and keyed (left.ln_fares_id=right.ln_fares_id),
                    get_addl_fares_tax (left, right), KEEP (1), LIMIT (0), left outer); 

  assess_over := join(flags, FCRA.key_override_property.assessment,
                      keyed(left.flag_file_id = right.flag_file_id) and isFCRA,
                      transform(recordof(kaf),self:=right,self:=[]),
                      keep(ut.limits.OVERRIDE_LIMIT), limit(0)); 

  assess_fcra := outf_reg_base + join(final_ids,assess_over,left.fid = right.ln_fares_id,take_right (left, right),keep(1));                    


  rec add_statement_ids ( rec l, FFD.Layouts.PersonContextBatchSlim r ) := transform,
    skip((~showDisputedRecords and r.isdisputed) or (~ShowConsumerStatements and exists(R.StatementIDs))) 
      self.statementids := r.StatementIDs;
      self.isdisputed :=  r.isdisputed;
      self := L;
  end;

  assess_ffd := join(assess_fcra, slim_pc_recs(datagroup=FFD.Constants.DataGroups.ASSESSMENT),
                     left.ln_fares_id = right.recid1
                     and left.did = (unsigned) right.lexid,
                     add_statement_ids(left, right),
                     left outer, keep(1), limit(0));

  outf := IF (IsFCRA, assess_ffd, outf_reg);

  rec iter(rec le, rec ri) := TRANSFORM
    SELF.address_seq_no := IF(ri.address_seq_no=99999,le.address_seq_no+1,ri.address_seq_no);
    SELF := ri;
  END;

  outfile := group(ITERATE(group(SORT(outf,did,bdid,address_seq_no),did,bdid),iter(LEFT,RIGHT)));
  RETURN outfile(dateVal = 0 OR (unsigned3)(sale_date[1..6]) <= dateVal);

END;