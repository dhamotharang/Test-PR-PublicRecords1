
import ut;

export Mod_DodgyDids(dataset(header.Layout_Header) h0) :=
MODULE

//DodgyDids relies on the DID distribution in Fn_CleanFnameTranspose
shared h := Header.Fn_CleanFnameTranspose(h0);

r := record
  h.fname;
  h.did;
  h.dob;
  h.ssn;
  h.valid_ssn;
  h.st;
  string18 vid := header.make_new_vendor(h.vendor_id);
  end;

shared rt_init := distribute(table(h,r),hash(did));
shared rt := rt_init(dob>18000000);

shared highvid := 'ZZZZZZZZZZZZZZZZZZ';

rroll := record
  rt.did;
  dob_max := max(group,rt.dob);
  dob_min := min(group,rt.dob);
  vid_max := max(group, IF(rt.dob=0,'',rt.vid));
  vid_min := min(group, IF(rt.dob=0,highvid,rt.vid));
  end;

export did_tab := table(rt,rroll,did,local);

shared too_wide := did_tab(dob_max < (integer4)ut.GetDate - 40000, 
                    abs(ut.MOB(dob_max)-ut.MoB(dob_min))>=1300,
				~header.dob_similar(dob_max, dob_min),
				Header.Vendor_Id_Null(vid_max) or vid_max <> vid_min);	


//rroll_days := record
//  rt.did;
//  day_dob_max := max(group,rt.dob % 100);
//  day_dob_min := min(group,rt.dob % 100);
//  end;

//days_tab := table(rt(dob%100>1),rroll_days,did,local);

shared did_rec := header.layout_DodgyDids;
//b_dob := h(jflag1='B');

did_rec bad_one(too_wide l) := transform 
 self.rule_number := '1';
 self := l;
end;

shared bad_dob := project(too_wide,bad_one(left));

//did_rec sli_day(days_tab le) := transform
//  self.rule_number := '2';
//  self := le;
//  end;

//days_wrong := project(days_tab(day_dob_max<>day_dob_min),sli_day(left));

export rts := rt((unsigned8)ssn<>0);

ssns := record
  rts.did;
  rts.ssn;
  male := count(group,datalib.gender(trim(rts.fname))='M');
  female := count(group,datalib.gender(trim(rts.fname))='F');
  dob_max := max(group,rts.dob div 100);
  dob_min := min(group,rts.dob div 100);
  mob_max := max(group,(rts.dob div 100) % 100);
  day_max := max(group,rts.dob % 100);
  end;

mac_ssn_overlap(h,wbna_j30);

wbna_j3 := distribute(wbna_j30,hash(did));

//export did_ssn := table(rts,ssns,did,ssn,local); //Don't export this one
did_ssn0 := table(rts,ssns,did,ssn,local);

ssns t_join(did_ssn0 le, wbna_j3 ri) := transform
 self := le;
end;

export did_ssn := join(did_ssn0,wbna_j3,left.did=right.did and left.ssn=right.ssn,t_join(left,right),left only,local);

did_rec sli_s(did_ssn le) := transform
  self.rule_number := '3';
  self := le;
  end;

gender_bias(unsigned2 m,unsigned2 f) :=
  MAP( m > f => 'M',
       f > m => 'F', 'U' );

j1 := join(did_ssn,did_ssn,left.did=right.did and
                           ( left.ssn<> right.ssn 
                             and left.day_max<>right.day_max 
                             and ( left.day_max>1 and right.day_max>1 
                                   or left.day_max>0 and right.day_max>0 and
							   left.mob_max>1 and right.mob_max>1 and 
                                      left.mob_max<>right.mob_max)  
                             or
                             //ut.stringsimilar(left.ssn,right.ssn)>1 
							 header.ssn_value(left.ssn, right.ssn) <= 0 
                           ) and
                           (
							 gender_bias(left.male,left.female)<>
                             gender_bias(right.male,right.female) and 
                             gender_bias(left.male,left.female)<>'U' and 
                             gender_bias(right.male,right.female)<>'U' or 
                             ut.date_overlap(left.dob_min,left.dob_max,right.dob_min,right.dob_max) = 0
                           ),
                           sli_s(left),local);

export split_by_ssn := dedup(sort(j1,did,local),did,local);
shared high := 99999999;
shared gender := record
  rts.did;
  male_dob_max := max(group,if(datalib.gender(trim(rts.fname))='M',rts.dob div 100,0));
  male_dob_min := min(group,if(datalib.gender(trim(rts.fname))='M',rts.dob div 100,high));
  female_dob_max := max(group,if(datalib.gender(trim(rts.fname))='F',rts.dob div 100,0));
  female_dob_min := min(group,if(datalib.gender(trim(rts.fname))='F',rts.dob div 100,high));
  
  male_vid_max := max(group,if(datalib.gender(trim(rts.fname))='M',rts.vid ,''));
  male_vid_min := min(group,if(datalib.gender(trim(rts.fname))='M',rts.vid ,highvid));
  female_vid_max := max(group,if(datalib.gender(trim(rts.fname))='F',rts.vid ,(typeof(rts.vid))''));
  female_vid_min := min(group,if(datalib.gender(trim(rts.fname))='F',rts.vid ,(typeof(rts.vid))highvid));
  end;

export did_gender := table(rts,gender,did,local);

did_rec sli_g(gender le) := transform
  self.rule_number := '4';
  self := le;
  end;

did_question := did_gender(male_dob_min<>high,female_dob_min<>high);

shared gender_sbad := 
	project(did_question
		(male_dob_min<>female_dob_min and female_dob_max<>male_dob_max,
		 not (header.sig_near_dob(male_dob_min,female_dob_min) and header.sig_near_dob(female_dob_max,male_dob_max)),
		 Header.Vendor_Id_Null(male_vid_min) 	or male_vid_min	<>female_vid_min, 
		 Header.Vendor_Id_Null(female_vid_max) 	or female_vid_max <> male_vid_max),
		sli_g(left));
// gender_bad := project(did_question(ut.date_overlap(male_dob_min,male_dob_max,female_dob_min,female_dob_max)=0),sli_g(left));


//=================== rule 5 ===================================
//Rule 5: if a did has 2 or more ssn, without sharing address st, no overlapping birthday either.
shared w_ssn := rt((unsigned8)ssn<>0, valid_ssn not in ['R', 'F']); // Don't filter out valid_ssn 'B': did 812696229 has 'B'.
shared ssn_st := w_ssn(st != '');
  
//j2_counter: dids with 2 or more ssn, shared address state between each ssn.
recSsnSt := record
  ssn_st.did;
  ssn_st.ssn;
  ssn_st.st;
end;

did_ssn_st_group := table(ssn_st,recSsnSt,did,ssn,st, local);

did_rec sli_s10(did_ssn_st_group le, did_ssn_st_group ri) := transform
  self.rule_number := 'F';
  self := le;
  end;
shared j2_counter := join(did_ssn_st_group,did_ssn_st_group,
    left.did=right.did 
    and left.ssn<> right.ssn and header.ssn_value(left.ssn, right.ssn) <= 0//ut.stringsimilar(left.ssn,right.ssn)>1 
    and left.st = right.st
  , sli_s10(left, right),local);
//j2_counter_dedup :=  dedup(sort(j2_counter,did,local),did,local);

//j2_pre: dids with 2 or more ssn, with non-overlapping dob. dob: day>0, but can be 01.
// rt also has h.dob>18000000.
recSsnStDob := record
  ssn_st.did;
  ssn_st.ssn;
  cnt := count(group);
  dob8_max := max(group, ssn_st.dob);
  dob8_min := min(group, ssn_st.dob);
end;
export did_ssn_group := table(w_ssn(dob%100 > 0),recSsnStDob,did,ssn, local);

did_rec sli_s2(did_ssn_group le, did_ssn_group ri) := transform
  self.rule_number := '5';
  self := le;
  end;

j2_pre := join(did_ssn_group,did_ssn_group,
	left.cnt > 1 and right.cnt > 1 //make sure it is not due to a single record.
    and left.did=right.did 
    and left.ssn<> right.ssn and header.ssn_value(left.ssn, right.ssn) <= 0//ut.stringsimilar(left.ssn,right.ssn)>1 
    and (left.dob8_max < right.dob8_min or right.dob8_max < left.dob8_min) //if year and month are the same
  , sli_s2(left, right),local);  //local: rt is distributed by did.
//j2_pre_dedup := dedup(sort(j2_pre,did,local),did,local);

//start of getting within a did, all SSNs share the same ST(DOB not considered)
w_all_st := join(rt_init, j2_pre, left.did=right.did, 
                 transform({rt_init}, self:=left), local)((unsigned8)ssn<>0);

DS_slim := table(w_all_st, {w_all_st.did, w_all_st.ssn}, did, ssn, local);
DS_cnt_grp := table(DS_slim, {DS_slim.did, ssn_cnt := count(group)}, did, local);

DSS_slim := table(w_all_st(st != ''),{w_all_st.did, w_all_st.st, w_all_st.ssn}, did, st, ssn, local);
DSS_cnt_grp := table(DSS_slim, {DSS_slim.did, DSS_slim.st, st_ssn_cnt := count(group)}, did, st, local);
DSS_max_cnt := dedup(sort(DSS_cnt_grp, did, -st_ssn_cnt, local),did, local);

w_shr_st := join(DS_cnt_grp, DSS_max_cnt, 
                 left.did=right.did and left.ssn_cnt = right.st_ssn_cnt, 
			  transform({did_rec}, self.rule_number := 'F', self := left), local);
//end of catching 


//j2: dids with 2 or more ssn, with non-overlapping dob, no shared address state between ssn.
did_rec sli_s3(did_rec le, did_rec ri) := transform
  self := le;
  end;
j2 := join(j2_pre, j2_counter+w_shr_st, left.did=right.did, 
    sli_s3(left, right), left only);
shared st_dob := dedup(sort(j2, did), did);

//==================== END rule5 ====================================



///////////////////////Find DIDs with too many name combinations//////////////////// 

prep := project(h, transform(header.layout_NonIDs, self.ID := (string)left.DID, self := left));
nonid := header.fn_FindNonIDs(prep, 16);
shared namedodgy := project(nonid, 
														transform(did_rec,
																			self.rule_number := '7',
																			self.did := (unsigned6)left.id));

/////////////////////////////////////////////////////////////////////////////////////////////////


np := dedup(sort(gender_sbad + 
								 split_by_ssn + 
								 bad_dob + 
								 st_dob + 
								 namedodgy, did, rule_number), did, local);

// output(did_tab, named('did_tab'));
// output(too_wide, named('too_wide'));

// output(rts, named('rts'));
// output(did_ssn, named('did_ssn_3'));

// output(did_gender, named('did_gender4'));
// output(did_question, named('did_question4'));
// output(gender_sbad, named('gender_sbad4'));

export result := np;

END;
