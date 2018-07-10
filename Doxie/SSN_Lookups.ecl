import doxie, doxie_crs, suppress, ut;

doxie.MAC_Header_Field_Declare()

ssns := dedup(doxie.comp_ssns((unsigned)ssn_unmasked > 0),ssn_unmasked,all);

isCNSMR := ut.IndustryClass.is_Knowx;
// Fetch the SSN information for all extent ssns
ssn_info := doxie_crs.layout_SSN_Lookups;

ssn_temp_rec := record
  recordof (ssns);
  boolean legacy_ssn := false; //for potentially randomized SSNs defines if SSN-DID pair was seen before
end;

// check if SSN was seen before randomization:

// this is still an issue -- DID is not preserved into the lookups,
// since the notion of 'legacy' is for the DID/SSN pair.
ssn_w_legacy_info := join (ssns, doxie.key_legacy_ssn,
                           keyed (Left.ssn_unmasked = Right.ssn) AND
                           (Left.did = Right.did),
                           transform (ssn_temp_rec, Self.legacy_ssn := Right.ssn != '', Self := Left),
                           LEFT OUTER, KEEP (1), limit (0)); //at most 1 : 1 relation

// get SSN validation data:
ssn_info ssnm(ssn_temp_rec frm,doxie.Key_SSN_Map R) := transform
  // new ssn-issue data have '20990101' for the current date intervals
  r_end := IF (R.end_date='20990101', 0, (unsigned4) R.end_date);

  m_validation := ut.GetSSNValidation (frm.ssn_unmasked);
	boolean is_valid := m_validation.is_valid;
	boolean is_legacy := m_validation.is_valid AND R.ssn5 = '' AND frm.legacy_ssn;

  self.ssn5 := frm.ssn_unmasked[1..5];
  self.ssn_issue_early	:= Suppress.dateCorrect.sdate_u4(frm.ssn_unmasked, (unsigned4)R.start_date);
  self.ssn_issue_last		:= Suppress.dateCorrect.edate_u4(frm.ssn_unmasked, r_end);
  self.ssn_issue_place	:= Suppress.dateCorrect.state(frm.ssn_unmasked, R.state);
  valid := (is_valid and not is_legacy and ((integer)frm.ssn_unmasked not in doxie.bad_ssn_list)); 
	self.valid := Suppress.dateCorrect.valid(frm.ssn_unmasked, valid);
	self.ssn := frm.ssn9;
	self.ssn_unmasked := frm.ssn_unmasked;
 end;

result_SSN_info := join(ssn_w_legacy_info,doxie.Key_SSN_Map,
               keyed (left.ssn_unmasked[1..5] = Right.ssn5) AND
               keyed (left.ssn_unmasked[6..9] between Right.start_serial AND Right.end_serial), //between is inclusive
               ssnm(left,right),
               left outer, KEEP (1), limit (0)); //1:1 relation


result_SSN_supressed := Project(ssn_w_legacy_info, transform(ssn_info, self := left, self := []));

result := if(isCNSMR, result_SSN_supressed, result_SSN_info);

result mask_ssn5(result l) := transform
	self.ssn5_unmasked := l.ssn5;
	self.ssn5 := if(ssn_mask_value='ALL' or ssn_mask_value='FIRST5', 'xxxxx', l.ssn5);
	self := l;
end;

out_mskd := project(result, mask_ssn5(left));

export SSN_Lookups := out_mskd;