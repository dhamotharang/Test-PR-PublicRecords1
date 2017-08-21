import driversv2, votersv2, daybatchpcnsr, marketing_best, lib_datalib, lib_stringlib, infutor,idl_header,ut, watchdog;

decimal6_2 fname_gender_score_for_DID := .60; 

slim := record
	string20 fname;
	string1 gender;
	unsigned6 DID := 0;
	integer male_count ;
	integer female_count ;
	integer fname_count;
	decimal6_2 confidence_score := 0;
	
end;
                                                         
fn_cleanup(string pIn) := function
 pOut1 := trim(regexreplace('[!$^*<>?]',pIn,' '),left,right);
 pOut2 :=  stringlib.StringToUpperCase(trim(regexreplace('[0-9]',pOut1,' '),left,right));
 pOut  :=  trim(stringlib.stringfindreplace(pOut2,'\'',''),left,right);
 return pOut;
end;

//
//leave out DL and remove Infutor and Pconsumer
//

//adding filter to drop invalid gender from dataset 

v := VotersV2.File_Voters_Base(length(trim(fname))>1 and (((title = 'MR' or title = '') and gender = 'M') or ((title = 'MS' or title = '') and gender = 'F')));

//Patch to filter bad DID
check_Dad_DID := risk_indicators.Bad_DID_ADL2(v.DID,v.fname);

v_prep := v(not check_Dad_DID);

v_f := project(v_prep, transform(slim,
                self.fname := fn_cleanup(left.fname);
								self.male_count := if(left.gender='M',1,0), 
								self.female_count := if(left.gender='F',1,0), 
								self.fname_count := 1,
								self := left));
								
//add insurance name file
idl:= IDL_Header.Name_Count_DS(fname_cnt >0 and placement_cnt>100);
idl_f := project(idl, transform(slim,
                self.fname := fn_cleanup(left.name);
				self.male_count := left.male_cnt, 
				self.female_count := left.female_cnt,
				self.fname_count := left.fname_cnt ,
				self := left, self := []));

//rollup 
dist_names := distribute(idl_f(length(trim(fname))>1), hash(fname));

deduped_names := sort(dist_names, fname, local);

grouped_names := group(deduped_names, fname,local);

//rollup by fname/gender and count male and female

names_rolled := group(rollup(grouped_names, true, transform(slim, 
									 self.male_count := left.male_count + right.male_count,
									 self.female_count := left.female_count + right.female_count,
									 self.fname_count := left.fname_count + right.fname_count,
                                     self := right))):persist('~thor_data400::persist::gender_names_rolled');	

//normalize gender
slim normalizedgender(names_rolled L, integer cnt) := transform

self.gender      := choose(cnt,'F', 'M');
self.female_count:= choose(cnt, l.female_count, 0);
self.male_count  := choose(cnt, 0, l.male_count);
self := L;

end;	

names_norm := normalize(names_rolled, 2, normalizedgender(left, counter));					

combined_fnames_gender := names_norm(~(male_count = 0 and female_count = 0));
combined_files_DEDUP := dedup(combined_fnames_gender, all,local);

//calculate confidence score

gender_rec := Risk_Indicators.Layout_gender_base;
fnames_confidence := project(combined_files_DEDUP,
					transform(gender_rec, self.confidence_score := if(left.gender = 'M', left.male_count/left.fname_count, left.female_count/left.fname_count), 
									self.mname := '';
									self.did := 0,
									self := left)); 	

//rollup to see if there are any DID that are both male and female, if so make them 'D'

dist_gender_did:= distribute(v_f(did > 0 and gender <> ''), hash(did));

deduped_gender_did := dedup(sort(dist_gender_did, did, gender, fname, local),did,gender,fname,local);

grouped_gender_did := group(deduped_gender_did, did, local);

gender_did_rolled := group(rollup(grouped_gender_did, true, transform(slim, 
									 self.gender := if(left.gender = right.gender, right.gender, 'D');
									 self := right)));	

gender_did_rolled_has_dual_gender := gender_did_rolled(gender = 'D');

grouped_gender_did tjoin(deduped_gender_did le, 	gender_did_rolled_has_dual_gender ri) := transform

self := le;
end;

v_did_has_no_dual_gender := join(deduped_gender_did, gender_did_rolled_has_dual_gender, 
left.did = right.did, tjoin(left, right), left only, local);

dist_v_DID_gender_fname := distribute(v_did_has_no_dual_gender, hash(fname));

//join with fname confidence
dist_v_DID_gender_fname tjoinfname(dist_v_DID_gender_fname le, fnames_confidence ri) := transform

self.confidence_score := if(le.fname = ri.fname and le.gender = ri.gender, ri.confidence_score, if(le.fname = ri.fname and le.gender <> ri.gender, 0, 999));
self.gender :=  if(le.fname = ri.fname and le.gender = ri.gender, ri.gender, if(le.fname = ri.fname and le.gender <> ri.gender, 'U', le.gender));
self := le;
end;

v_DID_fname_gender := join(dist_v_DID_gender_fname, fnames_confidence(confidence_score >fname_gender_score_for_DID),
left.fname = right.fname, tjoinfname(left,right), left outer, local):persist('~thor_data400::persist::v_did_gender_fname');

v_DID_fname_unknown_gender_dist := distribute(v_DID_fname_gender(gender = 'U'),hash(did));
v_DID_fname_unknown_gender_dedup := dedup(sort(v_DID_fname_unknown_gender_dist, did, local), did, local);

v_did_fname_gender tjoinDID(v_did_fname_gender le, v_DID_fname_unknown_gender_dedup ri) := transform

self := le;
end;

v_did_gender:= join(distribute(v_did_fname_gender,hash(did)), v_DID_fname_unknown_gender_dedup,
left.did = right.did, tjoinDID(left, right), left only, local);

v_did_gender_dedup := dedup(sort(v_did_gender, did, local), did, local);
								 
gender_did := project(v_did_gender_dedup,
					transform(gender_rec, self.mname := '', self.fname := '', self := left)); 
					
//add mname + gender					
rfields := record
unsigned6    did;
qstring20    mname;
integer4     mname_count := 0;
end;

mname_gender_rec := record

  unsigned6    did;
  string20    mname;
  integer4     mname_count := 0;
  string1 gender := '';
  integer female_count := 0;
  integer male_count := 0;
  decimal6_2 confidence_score := 0;
  
end;

//retrieve best mname from watchdog
best_mname_in := watchdog.file_best;
best_mname := project(best_mname_in(length(trim(mname,left,right)) >1), transform(mname_gender_rec, self := left));

best_mname_dedup := dedup(sort(distribute(best_mname, hash(mname)), mname,local),mname,local);

//get mname/gender from insurance file
gender_rec tjoinbestmname(fnames_confidence l, best_mname_dedup r) := transform

self.mname  := r.mname;
self.fname  := '';
self := l;

end;

mname_confidence_fname := join(distribute(fnames_confidence,hash(fname)),best_mname_dedup, 
left.fname =  right.mname , tjoinbestmname(left,right),local);

mnames_confidence :=  mname_confidence_fname;				
									
//combine fname/gender, did/gender and mname/gender
combine_gender := fnames_confidence + gender_did + mnames_confidence;

//build gender superfile
ut.MAC_SF_BuildProcess(combine_gender,
						'~thor_data400::base::gender',
						bld_gender_base, 2,,true);
				   
export gender_base := bld_gender_base;





	
	
	
