import doxie, ut, doxie_crs, suppress, header;

export fn_SSN_Records(
	dataset(doxie.layout_best) best_info_mult,
	boolean checkRNA = false
	) :=
FUNCTION

isCNSMR := ut.IndustryClass.is_Knowx;

doxie.MAC_Header_Field_Declare() //did_value, ssn_value, ssn_mask_value
doxie.MAC_Selection_Declare() //Include_AKAs_val, Include_Imposters_val


them_all := doxie.ssn_persons(checkRNA);
big_num := 999999999;
p_sum := record
  string1 Input := IF(them_all.did=(integer)did_value or them_all.ssn=ssn_value,'*','');
  them_all.ssn;
  cnt := count(group);
  them_all.fname;
  them_all.mname;
  them_all.lname;
  them_all.name_suffix;
  unsigned4 first_seen := MIN(group,them_all.dt_first_seen);
  unsigned4 last_seen := MAX(group,them_all.dt_last_seen);
  string4 dead := MAX(group,IF(them_all.dead,'DEAD',''));
  integer4 youngest_age := min(group,if(them_all.date_ob=0,big_num,ut.mob(them_all.date_ob)));
  integer4 oldest_age := max(group,ut.mob(them_all.date_ob));
  them_all.did;
  string30 comment := '';
	boolean likely_fragment := false;
	unsigned4 dob := max(group, them_all.date_ob);
	unsigned1 age := ut.age(max(group, them_all.date_ob));
  boolean legacy_ssn := false; //for potentially randomized SSNs defines if SSN-DID pair was seen before
  end;

best_info := best_info_mult[1];

best_info_ssn := best_info.ssn;
best_info_did := best_info.did;

add_aggr := table(them_all (ssn<>''),p_sum,fname,mname,lname,name_suffix,ssn,did);
p_sum_t := group(sort(add_aggr,did,-cnt,-length(trim(fname))),did)
					 ((Include_AKAs_val or did <> best_info_did) and
					  (Include_Imposters_val or not(ssn = best_info_ssn and did <> best_info_did))); 
						
Best_SSN := 'Possible fragment';
p_sum add_prefer(p_sum_t le, p_sum_t ri) := transform
  self.comment := IF(le.did=0,Best_SSN,'');
  self := ri;
  end;

with_pre := iterate(p_sum_t,add_prefer(left,right));

swp := sort(with_pre,ssn,-cnt,-comment);
AKA := 'AKA';
p_sum add_akas(p_sum_t le, p_sum_t ri) := transform
  self.comment := IF(le.did<>0 and le.ssn=ri.ssn,AKA,ri.comment);
  self := ri;
  end;

do_akas := iterate(swp,add_akas(left,right));

resorted := group(sort(group(do_akas),ssn,-cnt,-comment),ssn);
p_correct := 'Probably correct';
p_sum add_pcorrect(p_sum_t le, p_sum_t ri) := transform
  self.comment := IF(le.ssn='' and ri.comment = Best_SSN,p_correct,ri.comment);
  self := ri;
  end;

do_pcorrect := iterate(resorted,add_pcorrect(left,right));


matchables := do_pcorrect(comment = p_correct);

//output(do_pcorrect);

boolean intNNEQ(unsigned4 l, unsigned4 r) := l = 0 or r = 0 or l = r;

Typo := 'Probable Typo';
Rela := 'Relative ssn';

p_sum note_typo(p_sum_t le, p_sum_t ri,string val) := transform
  self.comment := 
                    MAP( ri.ssn = '' or le.comment IN [Aka,Typo,p_correct] => le.comment,
                         le.comment = Best_SSN => val + ' causing fragment',
                         val );
	self.likely_fragment := val = rela and
											 metaphonelib.DMetaPhone1(le.fname) = metaphonelib.DMetaPhone1(ri.fname) and
											 intNNEQ(le.dob,ri.dob) and
											 ut.NNEQ(le.mname,ri.mname);
  self := le;
  end;
//output(matchables);
//output(do_pcorrect);

find_morphs := join(do_pcorrect,matchables,left.did=right.did and 
                                       ut.StringSimilar(left.ssn,right.ssn)<3,
                    note_typo(left,right,Typo),left outer);
//output(find_morphs);
find_rels := join(find_morphs,dedup(matchables,ssn,lname,all),
                                                     left.ssn=right.ssn and
                                                     left.lname=right.lname and
                                                     left.did<>right.did,
                    note_typo(left,right,rela),left outer);

// Fetch the SSN information for all extant ssns
ssn_info := doxie_crs.layout_ssn_records;

// check if SSN was seen before randomization:
// TODO: making it after validation may be more efficient
ssn_w_legacy_info := join (find_rels, doxie.key_legacy_ssn,
                           keyed (Left.ssn = Right.ssn) AND
                           (Left.did = Right.did),
                           transform (p_sum, Self.legacy_ssn := Right.ssn != '', Self := Left),
                           LEFT OUTER, KEEP (1), limit (0)); //at most 1 : 1 relation

// get SSN validation data:
ssn_info ssnm(p_sum frm,doxie.Key_SSN_Map R) := transform

  // new ssn-issue data have '20990101' for the current date intervals
  r_end := IF (R.end_date='20990101', 0, (unsigned4) R.end_date);

  m_validation := ut.GetSSNValidation (frm.ssn);
	boolean is_valid := m_validation.is_valid;
	boolean is_legacy := m_validation.is_valid AND R.ssn5 = '' AND frm.legacy_ssn;

  self.youngest_age := if(frm.youngest_age=big_num,0,frm.youngest_age);
  self := frm;
  self.ssn_issue_early	:= Suppress.dateCorrect.sdate_u4(frm.ssn, (unsigned4)R.start_date);
  self.ssn_issue_last		:= Suppress.dateCorrect.edate_u4(frm.ssn, r_end);
  self.ssn_issue_place	:= Suppress.dateCorrect.state(frm.ssn, R.state);
  valid := (is_valid and not is_legacy and ((integer)frm.ssn not in doxie.bad_ssn_list));
	self.valid := Suppress.dateCorrect.valid(frm.ssn, valid);
  end;

result_SSN_info := join (ssn_w_legacy_info, doxie.Key_SSN_Map,
                keyed (left.ssn[1..5] = Right.ssn5) AND
                keyed (left.ssn[6..9] between Right.start_serial AND Right.end_serial),
                ssnm (Left, Right),
                LEFT OUTER, KEEP (1), limit (0)); //1 : 1 relation

result_SSN_supressed := Project(ssn_w_legacy_info, transform(ssn_info, self := left, self:= []));

result := if(isCNSMR, result_SSN_supressed, result_SSN_info);

out_f := sort(result,did,-cnt,ssn,-length(trim(fname)));

suppress.MAC_Mask(out_f, out_mskd, ssn, blank, true, false,,true);

//***** COMPARE RECORDS TO THE BEST INFO FOR THE SUBJECT
str_yes 	:= 'YES';
str_no  	:= 'NO';
str_close := 'CLOSE';
ssn_info check_and_skip(out_mskd l, best_info_mult r) := transform,
	skip(		//this skip is designed to mimic the behavior of the left outer join that was here before, preventing dups in front end
		 l.fname = r.fname and 
		 l.mname = r.mname and 
		 l.lname = r.lname and
		 l.dob = r.dob and
		 l.ssn = r.ssn and
		 l.did = r.did)
	
	cn := 
		if(l.fname = r.fname and 
			 l.lname = r.lname and 
			 (l.mname = r.mname or (l.mname[1] = r.mname[1] and 
															(length(trim(l.mname)) = 1 or length(trim(r.mname)) = 1))),
			 str_yes,
			 str_no);
	ssi :=
		map(l.ssn = r.ssn 											=> str_yes,
				header.ssn_value(l.ssn, r.ssn) > 0  => str_close,	//moxie returns CLOSE
				str_no);
	cb := 
		if(l.dob = r.dob, str_yes, str_no);
	
	self.current_name := 						if(Include_AKAs_val, cn,  '');
	self.subject_ssn_indicator := 	if(Include_AKAs_val, ssi, '');
	self.correct_dob :=							if(Include_AKAs_val, cb,  '');
	
	self := l;
end;

ds_checked :=
	join(out_mskd(not likely_fragment), 
			 best_info_mult,
			 true,
			 check_and_skip(left, right),
			 all);

//***** SORT RECS SIMILAR TO "BEST" TO THE TOP
ssn_extra := record(ssn_info)
	unsigned1 best_score;
end;
ssn_extra addScore(ds_checked L) := transform
	B := best_info_mult[1];
	
	fn_match	:= L.fname=B.fname;
	mn_match	:= L.mname=B.mname or (L.mname[1]=B.mname[1] and (length(trim(L.mname))=1 or length(trim(B.mname))=1));
	ln_match	:= L.lname=B.lname;
	dob_match	:= L.dob=B.dob;
	ssn_match	:= L.ssn=B.ssn;
	ssn_close	:= header.ssn_value(L.ssn,B.ssn) > 0;
	
	self.best_score :=
		if(fn_match and ln_match, 1, 0) +								// 1 point for a fname+lname match
		if(fn_match and mn_match and ln_match, 1, 0) +	// 1 point for a mname match (only if fname+lname also match)
		if(dob_match, 1, 0) +														// 1 point for a dob match
		map(ssn_match=>3, ssn_close=>1, 0);							// 3 points for a perfect ssn match, 1 for a near match
	
	self := L;
end;
_ds_scored := project(ds_checked, addScore(left));
doxie.MAC_Add_UtilityConnection(_ds_scored, ssn_extra, ds_scored, FALSE,, glb_ok); // Appends Utility recs - Connect_date and util_type to AKAs (ssn_chidren).
ds_sorted := project(sort(ds_scored, -best_score, did, -cnt, ssn, -length(trim(fname))), ssn_info);

return ds_sorted;

end;
