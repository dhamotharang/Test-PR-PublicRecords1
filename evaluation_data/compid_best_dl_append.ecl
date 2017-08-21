import evaluation_data,risk_indicators, ut, DriversV2;
comp_id := DATASET('~thor_data400::out::choicepoint::compid_patch', evaluation_data.layout_compid_clean, THOR);

evaluation_data.Layout_compid_best.compid_best t_reformat (comp_id le):= TRANSFORM
	
	self.lname := le.watchdog.lname;
	self.fname := le.watchdog.fname;
	self.mname := le.watchdog.mname;
	self.suffix := le.watchdog.name_suffix;
	self.ssn := le.watchdog.ssn;
	self.zip := le.watchdog.zip;
	self.city_name := le.watchdog.city_name;
	self.st := le.watchdog.st;
	self.zip4 := le.watchdog.zip4;
	self.dl_number:= le.watchdog.dl_number;
	self.dob := le.watchdog.dob[3..];
	self.gender:= '';
	self.address1 := StringLib.StringCleanSpaces(le.watchdog.prim_range + ' ' + le.watchdog.predir + ' ' + le.watchdog.prim_name + ' ' + le.watchdog.suffix + ' ' + le.watchdog.postdir) ;
	self.address2 := StringLib.StringCleanSpaces(le.watchdog.unit_desig + le.watchdog.sec_range);
	self.dod_ind := if ((integer)le.watchdog.dod > 0 ,'Y', '' );
	self.dod := (string)le.watchdog.dod[3..6];
	self := le.compid;
	self := le.watchdog;
	self := le;
end;
comp_id_r := project(comp_id, t_reformat(left));

//Append Gender using DID
//gender_f := risk_indicators.Gender_Base(did>0);
gender_rec  := record

  string20 fname;
  string1 gender;
  unsigned6 DID;
  decimal6_2 confidence_score ;
	
end;
gender_f := dataset(ut.foreign_prod+ '~thor_data400::persist::gender_base',gender_rec , thor);
gender_did_d  := distribute(gender_f(did>0),hash(did));
gender_did_s  := sort(gender_did_d, did, local);






gender_did_dedp  := dedup(gender_did_s, did, local);

comp_id_did_d := distribute(comp_id_r(did>0),hash(did));
comp_id_did_s := sort(comp_id_did_d,did, local);

evaluation_data.Layout_compid_best.compid_best t_gender1 (comp_id_did_s le, gender_did_dedp ri):= TRANSFORM
	self.gender := ri.gender;
	self := le;
end;

get_gender1 :=  join(comp_id_did_s, gender_did_dedp , left.did = right.did, t_gender1(left, right), left outer, local)
			    + comp_id_r(did=0); 

//Append Gender using First Name
gender_name_d := distribute(gender_f(did=0 and confidence_score>.74 and length(trim(fname))>1),hash(fname));
gender_name_s := sort(gender_name_d, fname, local);
gender_name_dedp := dedup(gender_name_s , fname, local);

comp_id_name_d := distribute(get_gender1(length(trim(fname))>1 and gender = ''),hash(fname));
comp_id_name_s := sort(comp_id_name_d,fname, local);

evaluation_data.Layout_compid_best.compid_best t_gender2 (comp_id_name_s le, gender_name_dedp ri):= TRANSFORM
	self.gender := ri.gender;
	self := le;
end;


get_gender2 :=  join(comp_id_name_s, gender_name_dedp, left.fname = right.fname, t_gender2(left, right), left outer, local)
			    + get_gender1(length(trim(fname))<=1 or gender <> ''); 


//Append DL data
//dl_f := Driversv2.File_DL;

dl_f := dataset(ut.foreign_prod + '~thor_200::BASE::DL2::Drvlic',DriversV2.layout_dl,thor);
dl_f_dl_d := distribute(dl_f(dl_number <> ''), hash(dl_number, expiration_date));
dl_f_dl_s := sort(dl_f_dl_d, dl_number,-expiration_date ,local);
dl_f_dl_dedp := dedup(dl_f_dl_s, dl_number, local);


comp_id_dl_d := distribute(get_gender2(dl_number <> ''), hash(dl_number));
comp_id_dl_s := sort(comp_id_dl_d, dl_number, local);

comp_id_without_dl := project(get_gender2(dl_number = ''), TRANSFORM(evaluation_data.Layout_compid_best.compid_best_with_dl  , self := left));

evaluation_data.Layout_compid_best.compid_best_with_dl t_append_dl (comp_id_dl_s le, dl_f_dl_dedp ri) := TRANSFORM
	self.cdl_indicator := evaluation_data.CDL_License_Type(trim(ri.orig_state), trim(ri.moxie_license_type));
	self.lic_issue_date := ri.lic_issue_date[3..];
	self.expiration_date := ri.expiration_date[3..];
	self := le;
	self := ri;
end;

get_dl := join(comp_id_dl_s, dl_f_dl_dedp, left.dl_number = right.dl_number,  t_append_dl(left, right), left outer, local)
		  + comp_id_without_dl;

//comp_id_diff_addr := get_dl(neq_best_addr = 'Y' AND rec_tp = '1');

export compid_best_dl_append := get_dl : persist('aherzberg_compid_sample');
//project(comp_id_diff_addr, TRANSFORM(evaluation_data.Layout_compid_best.compid_best_final, self := left)) : persist('aherzberg_compid_sample');




