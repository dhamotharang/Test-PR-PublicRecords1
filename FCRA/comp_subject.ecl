import fcra, doxie, riskwisefcra, doxie_crs, suppress, Gong, risk_Indicators, ut, NID, header, FFD;

doxie.MAC_Selection_Declare() //Include_AKAs_val, Include_Imposters_val

rec_header := RECORD
	recordof(doxie.Key_fcra_Header);
	FFD.Layouts.CommonRawRecordElements;
END;
MAX_OVERRIDE_LIMIT := 1000;		

// Returns a CRS-style information for the subject; FCRA-side only.
export comp_subject(dataset(doxie.layout_references) dids,
                    // unsigned3 dateVal = 0,
                    unsigned1 dppa_purpose = 0,
                    unsigned1 glb_purpose = 0,
                    // boolean ln_branded_value = false,
                    boolean include_gong = true,
                    // boolean probation_override_value,
                    string5 industry_class_value='UTILI',
                    // boolean no_scrub=false,
                    unsigned1 dial_contactprecision_value = 4,
                    unsigned2 address_limit = 1000,
                    dataset (fcra.Layout_override_flag) flagfile,
										dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = dataset([], FFD.Layouts.PersonContextBatchSlim), 
										integer8 inFFDOptionsMask = 0) :=
MODULE

shared mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule(true));
shared glb_ok := mod_access.isValidGLB(); //to use in a header cleaing macro
shared dppa_ok := mod_access.isValidDPPA(); // ...


head_all := riskwisefcra._header_data (dids, flagfile);

shared head_all_slim := project (head_all, rec_header);
// FFD
shared boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);	
shared boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);

// Certain header search scenarios utilize only subset of input criteria;
// the purpose of this function is to verify LexID by comparing header file against desired input.
// Note: we may want to choose permission-cleaned version of header file later
EXPORT boolean is_verified (doxie.IVerifyLexID subject_input) := function

  // slim down header dataset, introduce the match code
  rec_slim := record
    rec_header.did;
    rec_header.ssn;
    rec_header.fname;
    rec_header.lname;
      //    other fields of potential interest for verification purposes:
      // unsigned3 dt_first_seen;// unsigned3 dt_last_seen;// qstring10 phone;// integer4 dob;// qstring20 mname;
      // qstring5 name_suffix;// qstring10 prim_range;// string2 predir;// qstring28 prim_name;// qstring4 suffix;
      // string2 postdir;// qstring10 unit_desig;// qstring8 sec_range;// qstring25 city_name;// string2 st;
      // qstring5 zip;// string1 valid_SSN := '';
  end;
  ds_slim := project (head_all_slim, rec_slim);

  // At this point requirements are pretty straightforward: if SSN is in the input, 
  // then we must match SSN and non-blank names anywhere in the header (not necessarily in one record)
  fname_checked := exists (ds_slim (NID.mod_PFirstTools.PFLeqPFR (fname, subject_input.fname)));
  lname_checked := exists (ds_slim (lname = subject_input.lname)) or exists (ds_slim (ut.IsNamePart (subject_input.lname, lname, false)));
  ssn_checked := exists (ds_slim (ssn = subject_input.ssn));
  return (subject_input.ssn = '') or ((subject_input.fname != '') and 
                                      (subject_input.lname != '') and
                                      ssn_checked and fname_checked and lname_checked);


end;

// boolean is passed to avoid a call to minors_hash index, which is absent on FCRA side
header.MAC_GlbClean_Header (head_all_slim, head_all_clean, ,true, mod_access);

head_all_clean_fat := project (head_all_clean, rec_header);


rec_header xformHDR( rec_header l, FFD.Layouts.PersonContextBatchSlim r ) := 
	TRANSFORM, SKIP(~showDisputedRecords AND r.isDisputed)																				 
		SELF.StatementIDs := FFD.Constants.BlankStatements,  // no record level statements for header data  
		SELF.IsDisputed   := r.IsDisputed,
		SELF := l
	END;			

shared Mainfat := JOIN(head_all_clean_fat, slim_pc_recs(datagroup = FFD.Constants.DATAGROUPS.HDR),
				((UNSIGNED) LEFT.did = (UNSIGNED) RIGHT.lexid OR RIGHT.Acctno = FFD.Constants.SingleSearchAcctno) 
				AND	LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
				xformHDR(LEFT, RIGHT),
				LEFT OUTER, KEEP(1), LIMIT(0));

//=================================================================================================
//=================================================================================================
//            Subject's best; see FCRA part of Doxie/best_records
//=================================================================================================
//=================================================================================================
//TODO: append Gong
// head_for_append := head_all(doxie.needAppends(src, listed_name));
// head_skip       := head_all(~doxie.needAppends(src, listed_name));
// head_gd1 := doxie.Append_Gong(head_for_append, DATASET([], doxie.layout_relative_dids), dial_contactprecision_value);
// head_gd := 
  // project(head_gd1, doxie.layout_presentation) +
  // project(head_skip, doxie.layout_presentation);
// shared Mainfat := IF(include_gong, head_gd, head_all);

integer getBestDate (integer date1, integer date2) := function
  rem_date_1 := date1 % 100;
  rem_date_2 := date2 % 100;
  return map (
    date1 = 0 => date2,
    date2 = 0 => date1,
    // both are non-zero
    (rem_date_1 != 0) and (rem_date_2 = 0) => date1,
    (rem_date_1 = 0) and (rem_date_2 != 0) => date2,
    date1 >= date2 => date1,
    date2); 
end;

// try to choose a best record from a header:
header_sort := sort (Mainfat, -dt_last_seen, -ssn);

rec_header AssignBest (rec_header L, rec_header R) := transform
  boolean prefer_left_ssn := (L.valid_ssn = 'G') or (R.ssn = '') or ((L.valid_ssn = 'M') and (R.valid_ssn != 'G'));
  Self.ssn := if (prefer_left_ssn, L.ssn, R.ssn);
  Self.valid_ssn := if (prefer_left_ssn, L.valid_ssn, R.valid_ssn);
  Self.dob := getBestDate (L.dob, R.dob); 
	Self.isDisputed := L.isDisputed OR (~prefer_left_ssn AND R.isDisputed);
	Self.StatementIds := FFD.Constants.BlankStatements;   // no record level statements for header data
  Self := L; // take everything else from the latest record
end;
best_header := rollup (header_sort, TRUE, AssignBest (Left, Right));

// arguably, we've choosen "best" SSN, now fetch best deceased information
// TODO: check what SSN should take a preference if search was done by SSN and it doesn't
//       match "best" or neither of header's SSNs

// SSN records for the subject; it contains "deceased" info among other things
// this code is similar to what is in RiskWiseFCRA/FCRAData_Service
Layout_SSN := recordof(Risk_Indicators.Key_SSN_Table_v4_filtered_FCRA);

ssn_ffids := SET(flagfile(file_id = FCRA.FILE_ID.ssn), flag_file_id );
ssn_ids  := SET(flagfile(file_id = FCRA.FILE_ID.ssn), trim(record_id) );
ssn_corr  := CHOOSEN(FCRA.Key_Override_SSN_Table_FFID( keyed( flag_file_id in ssn_ffids ) ), MAX_OVERRIDE_LIMIT );

ssn_main := join(best_header, Risk_Indicators.Key_SSN_Table_v4_filtered_FCRA,	
						left.ssn<>'' and keyed(left.ssn=right.ssn) and (right.ssn not in ssn_ids),
						transform( layout_ssn, self := right ),
						KEEP(1), LIMIT(0));		// what should we keep here
ssn_corrected := ssn_main + PROJECT( ssn_corr, Layout_SSN);
dear := ssn_corrected[1]; // at most one record by definition


// finally, use ssn records just fetched to append deceased info
// on FCRA side best record is taken from header, rather than from best file
doxie_crs.layout_best_information AppendBest (rec_header L) := transform
  // TODO: self.phones := doxie_crs.verifiedPhones(Legacy_Verified_Value).records, 
  Self.phones := [];

  // Deceased: ssn-table may have inaccurate deceased dates, see DID=5925576391,
  // but I still prefer to give it a preference; later header date can be taken into account
  _deceased := dear.isdeceased; // ssn source takes the priority
  _dod := dear.dt_first_deceased;
  Self.dod := if (_deceased, (qstring) _dod, '');
	Self.deceased := if (_deceased, 'Y', 'N');
	self.age := if ( l.dob = 0, 0, ut.Age(l.dob) );
  Self := L;
end;
best_append := project (best_header, AppendBest (Left));

dl_mask_value := mod_access.dl_mask = 1;
suppress.mac_mask(best_append, best_masked, ssn, dl_number, true, true, false, true, maskVal := mod_access.ssn_mask);

EXPORT best_record := best_masked;



//=================================================================================================
//=================================================================================================
//            Subject's addresses and names; loosily based on doxie/Comp_Subject_Addresses
//=================================================================================================
//=================================================================================================

Main := project (Mainfat, transform (doxie.layout_comp_addresses, 
					self.statementids := FFD.Constants.BlankStatements, // no record level statements for header data
					self := left, self.hri_address := []));
doxie.MAC_Address_Rollup(Main,address_limit,Main_Dn, ut.IndustryClass.is_knowx);

doxie.layout_comp_addresses tra(Main_Dn lef,Main_Dn ref) := transform
  self.address_seq_no := if(lef.address_seq_no <=0,1,lef.address_seq_no +1);    
	self.isSubject := true;
  self := ref;    
  end;

// transform to switch the dates in case the search is knowx.  
doxie.layout_comp_addresses traConsumer(Main_Dn lef,Main_Dn ref) := transform
  self.address_seq_no := if(lef.address_seq_no <=0,1,lef.address_seq_no +1);  
  self.dt_last_seen := ref.dt_vendor_last_reported;
  self.dt_first_seen := ref.dt_vendor_first_reported;
  self.dt_vendor_first_reported := ref.dt_first_seen;
  self.dt_vendor_last_reported := ref.dt_last_seen;
	self.isSubject := true;
  self := ref;    
  end;
  
//****** Push infile through transform above
Main_Dn_U := iterate(Main_Dn, tra(left, right));
Main_Dn_C := iterate(Main_Dn, traConsumer(left, right));
Mainseq := if(ut.IndustryClass.is_Knowx, Main_Dn_C, Main_Dn_U);
export Addresses := Mainseq;

mainfat_for_name := project(Mainfat,
	transform(doxie.layout_NameDID,
		self.statementids := FFD.Constants.BlankStatements, // no record level statements for header data
		self := left));

doxie.layout_NameDID name_tra (doxie.layout_NameDID l, doxie.layout_NameDID r) := transform
  self.name_occurences := 
    if(l.did = r.did and l.name_suffix = r.name_suffix and l.fname = r.fname and l.lname = r.lname,
      1+l.name_occurences, 1);
  self := r;
end;
	
export Names := 
  rollup(
    sort(iterate(sort(mainfat_for_name, did, name_suffix, fname, lname), name_tra(left, right)),
			did, name_suffix, fname, lname,-name_occurences),
    left.did = right.did and left.name_suffix = right.name_suffix and left.fname = right.fname and left.lname = right.lname, 
			transform(doxie.layout_NameDID,
				self.statementids := FFD.Constants.BlankStatements,  // no record level statements for header data
				self.isdisputed := left.isdisputed or right.isdisputed,
				self := left));
				




//==========================================================================
//==========================================================================
//            SSN children (loosily based on doxie/fn_ssn_records)
//==========================================================================
//==========================================================================

// this part roughly equals to the call to doxie/ssn_persons
ssn_people := record
  string20 fname;
  string30 mname;
  string20 lname;
  qstring5  title;
  string5  name_suffix;
  string9  ssn;
  unsigned6 did;
  integer4  date_ob;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  boolean dead;
	FFD.Layouts.CommonRawRecordElements;
  end;

ssn_people get_people (Mainfat le) := transform
  self.dead := le.tnt='D';
  self.name_suffix := IF(ut.is_unk(le.name_suffix),'',le.name_suffix);
  self.date_ob := le.dob;
  self.dt_first_seen := MAP(le.dt_first_seen<>0 => le.dt_first_seen,le.dt_last_seen<>0 => le.dt_last_seen, 99999999);
  self.dt_last_seen := MAP(le.dt_last_seen<>0 => le.dt_last_seen,le.dt_first_seen);	
	self.statementids := FFD.Constants.BlankStatements; // no record level statements for header data
	self.isdisputed := le.isdisputed;
  self := le;
end;

them_all := project (Mainfat, get_people (Left));

// starting from here: similar to doxie/fn_ssn_records

big_num := 999999999;
p_sum := record
	string1 Input;
  them_all.ssn;
  unsigned cnt;
  them_all.fname;
  them_all.mname;
  them_all.lname;
  them_all.name_suffix;
  unsigned4 first_seen;
  unsigned4 last_seen;
  string4 dead;
  integer4 youngest_age;
  integer4 oldest_age;
  them_all.did;
  string30 comment;
  boolean likely_fragment;
  unsigned4 dob;
  unsigned1 age;
  boolean legacy_ssn;
	FFD.Layouts.CommonRawRecordElements;
end;

p_sum ssn_aggr_tra(ssn_people l, dataset(ssn_people) name_recs) := transform
	self.Input := '*';//IF(them_all.did=(integer)did_value or them_all.ssn=ssn_value,'*','');
  self.ssn := l.ssn,
  self.cnt := count(name_recs);
  self.fname := l.fname,
  self.mname := l.mname,
  self.lname := l.lname,
  self.name_suffix := l.name_suffix,
  self.first_seen := min(name_recs, dt_first_seen);
  self.last_seen := max(name_recs, dt_last_seen);
  self.dead := max(name_recs, IF(dead,'DEAD',''));
  self.youngest_age := min(name_recs, if(date_ob=0, big_num, ut.mob(date_ob)));
  self.oldest_age := max(name_recs, ut.mob(date_ob));
  self.did := l.did,
  self.comment := '';
  self.likely_fragment := false;
  self.dob := max(name_recs, date_ob);
  self.age := ut.Age(max(name_recs, date_ob));
  self.legacy_ssn := false; //for potentially randomized SSNs defines if SSN-DID pair was seen before	
	self.statementids := normalize(name_recs, left.statementids, transform(FFD.Layouts.StatementIdRec, self := right)),
	self.isdisputed := exists(name_recs(isdisputed))
end;

add_aggr_grp := group(sort(them_all (ssn<>''), did, fname, mname, lname, name_suffix, ssn), did, fname, mname, lname, name_suffix, ssn);

add_aggr := rollup(add_aggr_grp, group, ssn_aggr_tra(left, rows(left)));

p_sum_t := group(sort(add_aggr,did,-cnt,-length(trim(fname))),did);
            
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
ssn_w_legacy_info := join (find_rels, doxie.Key_FCRA_legacy_ssn,
                           keyed (Left.ssn = Right.ssn) AND
                           (Left.did = Right.did),
                           transform (p_sum, Self.legacy_ssn := Right.ssn != '', Self := Left),
                           LEFT OUTER, KEEP (1), limit (0)); //at most 1 : 1 relation

// get SSN validation data:
ssn_info ssnm(p_sum frm, doxie.key_SSN_FCRA_map R) := transform

  // new ssn-issue data have '20990101' for the current date intervals
  r_end := IF (R.end_date='20990101', 0, (unsigned4) R.end_date);

  m_validation := ut.GetSSNValidation (frm.ssn);
  boolean is_valid := m_validation.is_valid;
  boolean is_legacy := m_validation.is_valid AND R.ssn5 = '' AND frm.legacy_ssn;

  self.youngest_age := if(frm.youngest_age=big_num,0,frm.youngest_age);
  self := frm;
  self.ssn_issue_early  := Suppress.dateCorrect.sdate_u4(frm.ssn, (unsigned4)R.start_date);
  self.ssn_issue_last    := Suppress.dateCorrect.edate_u4(frm.ssn, r_end);
  self.ssn_issue_place  := Suppress.dateCorrect.state(frm.ssn, R.state);
  valid := (is_valid and not is_legacy and ((integer)frm.ssn not in doxie.bad_ssn_list));
  self.valid := Suppress.dateCorrect.valid(frm.ssn, valid);
  end;

result := join (ssn_w_legacy_info, doxie.key_SSN_FCRA_map,
                keyed (left.ssn[1..5] = Right.ssn5) AND
                keyed (left.ssn[6..9] between Right.start_serial AND Right.end_serial),
                ssnm (Left, Right),
                LEFT OUTER, KEEP (1), limit (0)); //1 : 1 relation

// TODO: apply corrections from FCRA.Key_Override_SSN_Table_FFID

// ssn_corr  := CHOOSEN(FCRA.Key_Override_SSN_Table_FFID( keyed( flag_file_id in ssn_ffids ) ), MAX_OVERRIDE_LIMIT );
// ssn_main := join(best_header, Risk_Indicators.Key_SSN_Table_v4_filtered_FCRA,	
						// left.ssn<>'' and keyed(left.ssn=right.ssn) and (right.ssn in ssn_ids),


out_f := sort(result,did,-cnt,ssn,-length(trim(fname)));

suppress.MAC_Mask(out_f, out_mskd, ssn, blank, true, false,,true, maskVal := mod_access.ssn_mask);

// best record used below was obtained from FCRA header-file

//***** COMPARE RECORDS TO THE BEST INFO FOR THE SUBJECT
str_yes   := 'YES';
str_no    := 'NO';
str_close := 'CLOSE';
ssn_info check_and_skip(out_mskd l, doxie_crs.layout_best_information r) := transform,
  skip(    //this skip is designed to mimic the behavior of the left outer join that was here before, preventing dups in front end
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
    map(l.ssn = r.ssn                       => str_yes,
        header.ssn_value(l.ssn, r.ssn) > 0  => str_close,  //moxie returns CLOSE
        str_no);
  cb := 
    if(l.dob = r.dob, str_yes, str_no);
  
  self.current_name :=             if(Include_AKAs_val, cn,  '');
  self.subject_ssn_indicator :=   if(Include_AKAs_val, ssi, '');
  self.correct_dob :=              if(Include_AKAs_val, cb,  '');
  self := l;
end;

ds_checked :=
  join(out_mskd(not likely_fragment), 
       best_record,
       true,
       check_and_skip(left, right),
       all);
			 		 

//***** SORT RECS SIMILAR TO "BEST" TO THE TOP
ssn_extra := record(ssn_info)
  unsigned1 best_score;
end;
ssn_extra addScore(ds_checked L) := transform
  B := best_record[1];
  
  fn_match  := L.fname=B.fname;
  mn_match  := L.mname=B.mname or (L.mname[1]=B.mname[1] and (length(trim(L.mname))=1 or length(trim(B.mname))=1));
  ln_match  := L.lname=B.lname;
  dob_match  := L.dob=B.dob;
  ssn_match  := L.ssn=B.ssn;
  ssn_close  := header.ssn_value(L.ssn,B.ssn) > 0;
  
  self.best_score :=
    if(fn_match and ln_match, 1, 0) +                // 1 point for a fname+lname match
    if(fn_match and mn_match and ln_match, 1, 0) +  // 1 point for a mname match (only if fname+lname also match)
    if(dob_match, 1, 0) +                            // 1 point for a dob match
    map(ssn_match=>3, ssn_close=>1, 0);              // 3 points for a perfect ssn match, 1 for a near match
  
  self := L;
end;
ds_scored := project(ds_checked, addScore(left));
ds_sorted := project(sort(ds_scored, -best_score, did, -cnt, ssn, -length(trim(fname))), ssn_info);

export ssn_recs := ds_sorted;//dataset ([], doxie_crs.layout_ssn_records);




//==========================================================================
//==========================================================================
//            Names (roughly based on doxie/comp_names)
//==========================================================================
//==========================================================================

// "residents" -- actually, just the subject. 
// take recent addresses (See doxie_raw/residents_raw)
recent_residents := Addresses (doxie.isrecent((string6)dt_last_seen, 3,, true));
export residents := project (recent_residents, doxie_crs.layout_Resident_Links); // should be no dupes

// recent header names
recent_header := Mainfat (doxie.isrecent((string6)dt_last_seen, 3,, true));

rt := record
	doxie_crs.layout_comp_names;
	unsigned1 var_cnt := 1; // the idea here is to use this counter to move records with multiple name variations to the top
end;

ta := sort (project (recent_header, transform (rt, Self.ssn_unmasked := Left.ssn, Self := Left)),
            did, fname, lname, mname, ssn, dob);


rt roll_into(rt le,rt ri) := transform
	pick_dob_left := ut.date_quality(le.dob)>ut.date_quality(ri.dob);
	pick_ssn_left := length(trim(le.ssn)) > length(trim(ri.ssn));
	pick_ssn_unmasked_left := length(trim(le.ssn_unmasked)) > length(trim(ri.ssn_unmasked));
	pick_name_left := length(trim(le.mname)) > length(trim(ri.mname));
  self.dob := if ( pick_dob_left,le.dob,ri.dob );
  self.ssn := if ( pick_ssn_left, le.ssn, ri.ssn );
	self.ssn_unmasked := if ( pick_ssn_unmasked_left, le.ssn_unmasked, ri.ssn_unmasked );
  self.mname := if ( pick_name_left, le.mname, ri.mname );
	self.var_cnt := le.var_cnt + ri.var_cnt;	
	self.statementids := FFD.Constants.BlankStatements;  // no record level statements for header data
  self.isdisputed := (le.isdisputed and (pick_dob_left or pick_ssn_left or pick_ssn_unmasked_left or pick_name_left))
		or (ri.isdisputed and (~pick_dob_left or ~pick_ssn_left or ~pick_ssn_unmasked_left or ~pick_name_left));
  self := le;
  end;

r := rollup( ta, left.did = right.did and left.fname=right.fname and ut.lead_contains(left.mname,right.mname) and
                 left.lname=right.lname and ut.NNEQ(left.ssn,right.ssn) and 
                 ut.NNEQ_Date(left.dob,right.dob),roll_into(left,right) );

//add the age
doxie_crs.layout_comp_names addage(rt l) := transform
	self.age := if ( l.dob = 0, 0, ut.Age(l.dob) );
	self := l;
end;

// need to sort it again, now with var_cnt populated
wage := project(sort(r, did,-var_cnt,fname,lname,mname,ssn,dob), addage(left));

export comp_names := wage;
// export comp_names := dataset ([], doxie_crs.layout_comp_names);




//==========================================================================
//==========================================================================
//            SSN Lookups (based on doxie/ssn_lookups)
//==========================================================================
//==========================================================================
header_ddp := dedup (sort (Mainfat (ssn != ''), ssn), ssn);

ssns_rec := record
  string9 ssn9;
  unsigned6 did;
  string9 ssn_unmasked;
end;
header_ssns := project (header_ddp, transform (ssns_rec, Self.ssn9 := Left.ssn,
                                                         Self.did := Left.did, 
                                                         Self.ssn_unmasked := Left.ssn)); 

// Fetch the SSN information for all extent ssns
ssn_temp_rec := record (ssns_rec)
  boolean legacy_ssn := false; //for potentially randomized SSNs defines if SSN-DID pair was seen before
end;

// check if SSN was seen before randomization:

// this is still an issue -- DID is not preserved into the lookups,
// since the notion of 'legacy' is for the DID/SSN pair.
ssn_w_legacy_info := join (header_ssns, doxie.Key_FCRA_legacy_ssn,
                           keyed (Left.ssn_unmasked = Right.ssn) AND
                           (Left.did = Right.did),
                           transform (ssn_temp_rec, Self.legacy_ssn := Right.ssn != '', Self := Left),
                           LEFT OUTER, KEEP (1), limit (0)); //at most 1 : 1 relation

// get SSN validation data:
doxie_crs.layout_SSN_Lookups ssnm(ssn_temp_rec frm, doxie.key_SSN_FCRA_map R) := transform
  // new ssn-issue data have '20990101' for the current date intervals
  r_end := IF (R.end_date='20990101', 0, (unsigned4) R.end_date);

  m_validation := ut.GetSSNValidation (frm.ssn_unmasked);
  boolean is_valid := m_validation.is_valid;
  boolean is_legacy := m_validation.is_valid AND R.ssn5 = '' AND frm.legacy_ssn;

  self.ssn5 := frm.ssn_unmasked[1..5];
  self.ssn_issue_early  := Suppress.dateCorrect.sdate_u4(frm.ssn_unmasked, (unsigned4)R.start_date);
  self.ssn_issue_last    := Suppress.dateCorrect.edate_u4(frm.ssn_unmasked, r_end);
  self.ssn_issue_place  := Suppress.dateCorrect.state(frm.ssn_unmasked, R.state);
  valid := (is_valid and not is_legacy and ((integer)frm.ssn_unmasked not in doxie.bad_ssn_list)); 
  self.valid := Suppress.dateCorrect.valid(frm.ssn_unmasked, valid);
  self.ssn := frm.ssn9;
  self.ssn_unmasked := frm.ssn_unmasked;
 end;

result := join(ssn_w_legacy_info,doxie.key_SSN_FCRA_map,
               keyed (left.ssn_unmasked[1..5] = Right.ssn5) AND
               keyed (left.ssn_unmasked[6..9] between Right.start_serial AND Right.end_serial), //between is inclusive
               ssnm(left,right),
               left outer, KEEP (1), limit (0)); //1:1 relation
// TODO: apply corrections from FCRA.Key_Override_SSN_Table_FFID

result mask_ssn5(result l) := transform
  self.ssn5_unmasked := l.ssn5;
  self.ssn5 := if(mod_access.ssn_mask IN ['ALL', 'FIRST5'], 'xxxxx', l.ssn5);
  self := l;
end;

EXPORT ssn_lookups := project(result, mask_ssn5(left));



//==========================================================================
//==========================================================================
//            Phone data (loosily based on former doxie/phone_records)
//==========================================================================
//==========================================================================

// Comp report matches Gong by Address, among other things,
// but some keys (current address, for instance) are missing on FCRA side

// Take current, published Gong records
gong_data := RiskWiseFCRA._Gong_data (dids, flagfile) (current_flag, publish_code != 'N' and omit_phone != 'Y');

doxie_crs.layout_phone_records xformGong( RECORDOF(gong_data) l, FFD.Layouts.PersonContextBatchSlim r ) := 
		TRANSFORM, SKIP((~showDisputedRecords AND r.isDisputed) OR (~ShowConsumerStatements AND EXISTS(r.StatementIDs)))																				 
			SELF.zip := l.z5,
			SELF.listing_name := l.listed_name,
			SELF.phone := l.phone10,
			SELF.timezone := '',			
			SELF.StatementIDs := r.StatementIds,
			SELF.IsDisputed   := r.IsDisputed,
			SELF.hri_Phone := []; // Risk_Indicators.Layout_Desc
			SELF.Feedback := []; //PhonesFeedback_Services.Layouts.feedback_report
			SELF := l
		END;	
		
gong_records := JOIN(gong_data, slim_pc_recs(datagroup = FFD.Constants.DATAGROUPS.GONG),
									((UNSIGNED) LEFT.did = (UNSIGNED) RIGHT.lexid OR RIGHT.Acctno = FFD.Constants.SingleSearchAcctno) 
									 AND	
								LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
								xformGong(LEFT, RIGHT),
								LEFT OUTER, KEEP(1), LIMIT(0));

// doxie_crs.layout_phone_records
doxie_crs.layout_phone_records GetCompPhones (doxie_crs.layout_phone_records L, risk_indicators.Key_Telcordia_tds R) := transform
	self.timezone:= if(R.npa='' and R.nxx = '',
				'', ut.timeZone_Convert((unsigned1) R.timezone,R.state)),
  Self := L;
end;
// project to CRS layout
gong_crs := join (gong_records, risk_indicators.Key_Telcordia_tds, 
				(unsigned)left.phone>10000000 and
				keyed(left.phone[1..3] = right.npa) and 
				keyed(left.phone[4..6] = right.nxx)  and 
				left.phone[7] = right.tb, 
				GetCompPhones(LEFT,RIGHT), left outer, limit(0), keep(1));

str_unlisted := Gong.Constants.STR_UNLISTED;

gong_ddp := dedup (sort (gong_crs, phone, prim_range, prim_name, zip, if (phone=str_unlisted, listing_name, phone)),
                                   phone, prim_range,prim_name,zip, if (phone=str_unlisted, listing_name, phone));

// current phones as in CRS:
EXPORT phones := gong_ddp;


// Old phones: based on doxie/phones_old:
// whatever phones are in the header, except "current" Gong.
myp := Mainfat (((integer)phone != 0) and (phone not in set(phones, phone)));
    
// HRIs can be added here, if needed
phoneout := project (myp, transform (doxie_crs.layout_phones_old, 
	self.timezone := '',
	self.hri_phone := [],
	self.StatementIDs := FFD.Constants.BlankStatements,  // no record level statements for header data
	self.IsDisputed   := left.IsDisputed,
	self := left)); 

phone_srt := sort(phoneout, did, phone, -dt_last_seen, -dt_first_seen);

doxie_crs.layout_phones_old roll_them (phone_srt l, phone_srt r) := transform
  self.dt_first_seen := if((r.dt_first_seen <> 0) and 
                          ((l.dt_first_seen = 0) or (r.dt_first_seen < l.dt_first_seen)),
                          r.dt_first_seen, l.dt_first_seen);  														
  self := l;
end;
    
phone_roll := rollup (phone_srt, roll_them(left, right), did,phone);

ut.getTimeZone (phone_roll,phone,timezone,phone_roll_w_tzone);

EXPORT phones_old := phone_roll_w_tzone : global;

END;