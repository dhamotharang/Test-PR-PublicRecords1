import doxie_files,sexoffender;
import header;

headerx:= header.File_Headers;

flagged_in := sort(distribute(misc._hps_201002_phase1_flagged(did<>0),hash((unsigned6) did)),did,local);
recordof(flagged_in) to_confirm_lname(flagged_in l, headerx r) := transform
	self.did := if(l.lname=r.lname,l.did,0);
	self := l;
	end;
flagged_with_lname_confirmed  := join(flagged_in,headerx,left.did=right.did and left.lname=right.lname,to_confirm_lname(left,right),local,keep(1));
flagged_without_lname		  := join(flagged_in,headerx,left.did=right.did and left.lname=right.lname,to_confirm_lname(left,right),local,left only);

flagged := flagged_with_lname_confirmed+flagged_without_lname;

layout_result_with_details := record
	recordof(flagged);
	string offender_key;
	string offender_keys;
	string crim_offense_description;
	string court_offense_description;
	string seisint_primary_key;
	string seisint_primary_keys;
	string sor_offense_description;
	string offenses;
	end;

my_offenders := pull(doxie_files.key_offenders) (data_type in ['1','2']);

crims:= sort(distribute(my_offenders,hash((unsigned6) sdid)),sdid,local)();
layout_result_with_details to_add_crim(flagged l,crims r) := transform
	self.offender_key:=
		if((l.did<>0 
			// and l.lname=r.lname 
			and stringlib.StringToUpperCase(r.orig_state)='TEXAS'
			and l.clean_dob[1..6]=r.dob[1..6])
		,r.offender_key,'');
	self.seisint_primary_key := '';
	self.seisint_primary_keys := '';
	self.offender_keys:= '';
	self.sor_offense_description := '';
	self.crim_offense_description := '';
	self.court_offense_description := '';
	self.offenses:='';
	self := l;
end;
flagged_with_crim := 
	join(flagged,crims,
		left.did=right.sdid,
		to_add_crim(left,right),local, left outer );
// output(flagged_with_crim(has_doc<>'' or has_court<>'' or offender_key<>''),named('flagged_with_crim'));

sors := sort(distribute(pull(sexoffender.Key_SexOffender_Payload),hash((unsigned6) did)),did,local);
layout_result_with_details to_add_sor(flagged_with_crim l,sors r) := transform
	self.seisint_primary_key:=
		if((l.did<>0
			// and l.lname=r.lname
			and r.orig_state_code='TX'
			and l.clean_dob[1..6]= r.dob[1..6])
		,r.seisint_primary_key,'');
	self := l;
end;
flagged_with_sor := 
	join(flagged_with_crim,sors,
		left.did=right.did,
		to_add_sor(left,right),local,left outer);
// output(flagged_with_sor(has_sor<>'' or seisint_primary_key<>''),named('flagged_with_sor'));


sors_offenses := sort(distribute(pull(sexoffender.key_sexoffender_offenses),hash(seisint_primary_key)),seisint_primary_key,local);
flagged_with_sor_s := sort(distribute(flagged_with_sor,hash(seisint_primary_key)),seisint_primary_key,local);
layout_result_with_details to_add_sor_off(flagged_with_sor_s l, sors_offenses r) := transform
	self.sor_offense_description := r.offense_description;
	self := l;
	end;
flagged_with_sor_off := join(flagged_with_sor_s, sors_offenses, left.seisint_primary_key=right.seisint_primary_key,to_add_sor_off(left,right),local,left outer);
// output(flagged_with_sor_off(has_sor<>'' or seisint_primary_key<>''),named('flagged_with_sor_off'));

crim_offenses := sort(distribute(pull(doxie_files.Key_Offenses),hash(offender_key)),offender_key,local);
flagged_with_sor_off_s := sort(distribute(flagged_with_sor_off,hash(offender_key)),offender_key,local);
layout_result_with_details to_add_crim_off(flagged_with_sor_off_s l, crim_offenses r) := transform
	self.crim_offense_description := if(r.off_desc_1<>'', r.off_desc_1, r.ct_off_desc_1);
	self := l;
	end;
flagged_with_crim_off := join(flagged_with_sor_off_s, crim_offenses, left.offender_key=right.offender_key,to_add_crim_off(left,right),local,left outer);
// output(flagged_with_crim_off(has_doc<>'' or has_court<>'' or offender_key<>''),named('flagged_with_crim_off'));

court_offenses := sort(distribute(pull(doxie_files.Key_court_Offenses),hash(offender_key)),offender_key,local);
flagged_with_crim_off_s := sort(distribute(flagged_with_crim_off,hash(offender_key)),offender_key,local);
layout_result_with_details to_add_court_off(flagged_with_crim_off_s l, court_offenses r) := transform
	self.court_offense_description := r.court_off_desc_1;
	self := l;
	end;
flagged_with_court_off := join(flagged_with_crim_off_s, court_offenses, left.offender_key=right.offender_key,to_add_court_off(left,right),local,left outer);
// output(flagged_with_court_off(has_doc<>'' or has_court<>'' or offender_key<>''),named('flagged_with_court_off'));

ds_readied := sort(distribute(flagged_with_court_off,hash(did)),did,local);

export _hps_201002_phase2_details :=ds_readied  : persist('~thor::temp::misc._hps_201002_phase2_details');

