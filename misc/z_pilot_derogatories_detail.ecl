import faa, sexoffender,doxie_files;

pilot := sort(distribute(faa.file_airmen_data_out,hash((unsigned) did_out)),(unsigned) did_out,local);

certificate := sort(distribute(faa.file_airmen_certificate_out,hash(unique_id)),unique_id,local);

layout_pilot_did := record
 string unique_id := pilot.unique_id;
 string12 did := pilot.did_out;
end;
tpilot_did := dedup(sort(table(distribute(pilot,hash(unique_id)),layout_pilot_did,unique_id,did_out),unique_id,did,local),unique_id,did,local);

layout_pilot_did_cnt := record
 string unique_id := tpilot_did.unique_id;
 integer total_dids := count(group);
end;
tpilot_did_cnt := table(tpilot_did((integer) did<>0 ),layout_pilot_did_cnt,unique_id,local);

// output(choosen(tpilot_did((integer) did<>0),500));
// output(choosen(tpilot_did_cnt(total_dids>1),500));
// count(tpilot_did_cnt(total_dids>1));
// count(tpilot_did_cnt);


layout_pilot_with_flags := record 
recordof(pilot);
boolean has_sor := false;
boolean has_crim := false;
end;
pdd := misc._pilot_derogatories_dedup;

//output(pdd);

layout_pilot_with_details := record
string12 DID_out;
// string  p_city_name;
boolean has_crim := false;
boolean has_sor := false;
string	unique_id;
string8 date_last_seen;
string1 current_flag;
string10 record_type;
string1 letter_code;
string6 med_exp_date;
string20 	 		fname			;
string20  			mname			;
string20 			lname			;
string5  		 	name_suffix 		;
string10  			prim_range		;
string2  			predir			;
string28 			prim_name		;
string4   			addr_suffix	    ;
string2  			postdir			;
string10  			unit_desig		;
string8   			sec_range		;
string25 			p_city_name	    ;
string2  			st				;
string5  			zip			    ;
string offender_key;
string offender_lname;
string offender_fname;
string offender_p_city_name;
string seisint_primary_key;
string sor_lname;
string sor_fname;
string sor_p_city_name;
string crim_offense_description;
string sor_offense_description;
end;

pddf_bad := sort(distribute(pdd(has_crim or has_sor),hash(unique_id)),unique_id,local);
recordof(pddf_bad) to_eliminate_bad_dids(pddf_bad l, tpilot_did_cnt r) := transform
self := l;
end;
pddf_good_did := join(pddf_bad,sort(distribute(tpilot_did_cnt(total_dids>1),hash(unique_id)),unique_id,local),left.unique_id=right.unique_id,to_eliminate_bad_dids(left,right), local, left only);

// count(pdd);
// count(pddf_bad);
// count(pddf_good_did);


pddf := sort(distribute(pddf_good_did,hash((unsigned6) did_out)),did_out,local);
crims:= sort(distribute(pull(doxie_files.key_offenders(data_type='1')),hash((unsigned6) sdid)),sdid,local);
layout_pilot_with_details to_add_crim(pddf l,crims r) := transform
 self.offender_key:=if((unsigned6)  l.did_out<>0,r.offender_key,'');
 self.offender_lname:=if((unsigned6)  l.did_out<>0,r.lname,'');
 self.offender_fname:=if((unsigned6)  l.did_out<>0,r.fname,'');
 self.offender_p_city_name := if((unsigned6)  l.did_out<>0,r.p_city_name,'');
 self.seisint_primary_key := '';
 self.sor_lname := '';
 self.sor_fname := '';
 self.sor_p_city_name := '';
 self.sor_offense_description := '';
 self.crim_offense_description := '';
 self.addr_suffix:=l.suffix;
 self := l;
end;
pddfc := join(pddf,crims,
		((unsigned6)  left.did_out= (unsigned6)  right.sdid) and
		(left.lname<>'') and 
		(left.lname=right.lname) and 
		((unsigned6) left.did_out<>0),to_add_crim(left,right),local, left outer);

sors := sort(distribute(pull(sexoffender.Key_SexOffender_Payload),hash((unsigned6) did)),did,local);
layout_pilot_with_details to_add_sor(pddfc l,sors r) := transform
 self.seisint_primary_key:=if( (unsigned6)  l.did_out<>0,r.seisint_primary_key,'');
 self.sor_lname:=if((unsigned6)  l.did_out<>0,r.lname,'');
 self.sor_fname:=if((unsigned6)  l.did_out<>0,r.fname,'');
 self.sor_p_city_name := if((unsigned6)  l.did_out<>0,r.city_name,'');
 self := l;
end;
pddfcs := join(pddfc,sors,
		((unsigned6) left.did_out= (unsigned6)  right.did) and
		(left.lname<>'') and 
		(left.lname=right.lname) and 
		((unsigned6) left.did_out<>0),to_add_sor(left,right),local,left outer);

// output(pddfcs);

sors_offenses := sort(distribute(pull(sexoffender.key_sexoffender_offenses),hash(seisint_primary_key)),seisint_primary_key,local);
pddfcs_s := sort(distribute(pddfcs,hash(seisint_primary_key)),seisint_primary_key,local);
layout_pilot_with_details to_add_sor_off(pddfcs l, sors_offenses r) := transform
self.sor_offense_description := r.offense_description;
self := l;
end;
pddfcs_so := join(pddfcs_s, sors_offenses, left.seisint_primary_key=right.seisint_primary_key,to_add_sor_off(left,right),local,left outer);

crims_offenses := sort(distribute(pull(doxie_files.Key_Offenses),hash(offender_key)),offender_key,local);
pddfcs_so_c := sort(distribute(pddfcs_so,hash(offender_key)),offender_key,local);
layout_pilot_with_details to_add_crim_off(pddfcs_so_c l, crims_offenses r) := transform
self.crim_offense_description := r.off_desc_1;
self := l;
end;
pddfcs_so_co := join(pddfcs_so_c, crims_offenses, left.offender_key=right.offender_key,to_add_crim_off(left,right),local,left outer);

// layout_pilot_with_details to_rollup_filetyp(pddfcs_so_co l, pddfcs_so_co r) := transform
// self.filetyp := if(l.filetyp='AH',r.filetyp,l.filetyp);
// self.mname := if(l.mname<>'',l.mname,r.mname);
// self := l;
// end;

// ds_readied := sort(distribute(pddfcs_so_co,hash(unique_id))
				// ,unique_id,st,p_city_name,did,crim_offense_description,sor_offense_description,filetyp,local);
				
// res := rollup(ds_readied,to_rollup_filetyp(left,right)
				// ,unique_id,st,p_city_name,did,crim_offense_description,sor_offense_description,local);


res := pddfcs_so_co;

// output(res,named('res'));

layout_pilot_prettied := record
string12 did;
string	ID;
string8 date_last_seen;
string1 current_flag;
string10 record_type;
string1 letter_code;
string6 med_exp_date;

string  p_city_name;
string  offender_p_city_name;
string  sor_p_city_name;
string1 Crim := '';
string1 SOR := '';
string offender_lname;
string sor_lname;
string pilot_lname;
string offender_fname;
string sor_fname;
string pilot_fname;
// string	DOB;
// string  Typ;
string  Name;   
string Address;
string City_ST_Zip;
// string offender_key; //x
// string seisint_primary_key; //x
string crim_offense;
string sor_offense;
string offenses := '';
end;
layout_pilot_prettied  to_pretty(res l) := transform
self.offender_lname := l.offender_lname;
self.sor_lname := l.sor_lname;
self.pilot_lname := l.lname;
self.offender_fname := l.offender_fname;
self.sor_fname := l.sor_fname;
self.pilot_fname := l.fname;
self.did := l.did_out;
self.ID := l.unique_id;
self.Crim := if(l.has_crim,'Y','');
self.SOR := if(l.has_sor,'Y','');
self.Name :=  	
				trim(l.fname)+' '+ 
				trim(l.mname)+' '+
				trim(l.lname)+' '+
				trim(l.name_suffix);
self.Address := 
				trim(l.prim_range)+' '+
				trim(l.predir)+' '+
				trim(l.prim_name)+' '+
				trim(l.addr_suffix)+' '+
				trim(l.postdir)+' '+
				trim(l.unit_desig)+' '+
				trim(l.sec_range);

self.City_ST_Zip := 
				trim(l.p_city_name)+' '+
				trim(l.st)+' '+
				trim(l.zip);
self.crim_offense := trim(l.crim_offense_description);
self.sor_offense  := trim(l.sor_offense_description);
self := l; //x
end;
res_prettied := project(res,to_pretty(left));

// output(res_prettied,named('res_prettied'));

layout_slim_offense := record	
	string	ID;
	string pilot_lname;
	string sor_lname;
	string offender_lname;
	string offenses;
	end;
layout_slim_offense to_slim_sor_offense(res_prettied l) := transform	
	self.offenses := if(l.pilot_lname=l.sor_lname and l.sor_offense<>'','{','') +trim(l.sor_offense) +if(l.pilot_lname=l.sor_lname and l.sor_offense<>'','}','');
	self := l;
	end;
layout_slim_offense to_slim_crim_offense(res_prettied l) := transform
	self.offenses := if(l.pilot_lname=l.offender_lname and l.crim_offense<>'','{','') +trim(l.crim_offense) +if(l.pilot_lname=l.offender_lname and l.crim_offense<>'','}','');
	self := l;
	end;
normalized_offense := 
	dedup(
		sort(
		distribute(	project(res_prettied(sor_offense<>''),to_slim_sor_offense(left)) +
					project(res_prettied(crim_offense<>''),to_slim_crim_offense(left)),hash(ID))
		,record,local)
	,all,local);
layout_slim_offense to_roll_offenses(normalized_offense l,normalized_offense r) := transform
	self.offenses := trim(l.offenses)+ trim(r.offenses);
	self := l;
	end;
rolled_offenses := rollup(normalized_offense,to_roll_offenses(left,right),ID,local);

// output(rolled_offenses,named('rolled_offenses'));

layout_pilot_prettied to_finish(res_prettied l,rolled_offenses r) := transform
self.offenses := r.offenses;
self.crim_offense := '';
self.sor_offense := '';
self := l;
end;
res_with_offensex := dedup(sort(join(distribute(res_prettied,hash(id)), rolled_offenses, left.id=right.id, to_finish(left,right),local,left outer),record,local),all,local);


res_with_offense := sort(distribute(res_with_offensex,hash(id)),id,local); 

layout_res_with_certificate := record
recordof(res_with_offense);
	string8 cer_date_first_seen;
	string8 cer_date_last_seen;
	string1 cer_current_flag;
	string1 cer_letter;
	string7 cer_unique_id;
	string2 cer_rec_type;
	string1 cer_type;
	string20	cer_type_mapped;
	string1 cer_level;
	string45	cer_level_mapped;
	string8 cer_exp_date;
	string99 ratings;
	end;
layout_res_with_certificate to_append_certificate(res_with_offense l, certificate r) := transform
self.cer_date_first_seen := r.date_first_seen;
self.cer_date_last_seen	:= r.date_last_seen;
self.cer_current_flag	:= r.current_flag;
self.cer_letter		:= r.letter;;
self.cer_unique_id	:= r.unique_id;
self.cer_rec_type	:= r.rec_type;
self := l;
self := r;
end;
res_with_certificate := join(res_with_offense,certificate,left.id=right.unique_id, to_append_certificate(left,right),local);


layout_pilot_prettied_slim := record
string12 did;
string	ID;
string8 date_last_seen;
string1 current_flag;
string10 record_type;
string1 letter_code;
string6 med_exp_date;
// string  p_city_name;//
// string  offender_p_city_name;//
// string  sor_p_city_name;//
string1 Crim := '';
string1 SOR := '';
// string offender_lname; //
// string sor_lname; //
// string pilot_lname;//
// string offender_fname;//
// string sor_fname;//
// string pilot_fname;//
// string	DOB;
// string  Typ;
string  Name;   
string Address;
string City_ST_Zip;
// string offender_key; //x
// string seisint_primary_key; //x
// string crim_offense;
// string sor_offense;
string offenses := '';
	string8 cer_date_first_seen;
	string8 cer_date_last_seen;
	string1 cer_current_flag;
	string1 cer_letter;
	string7 cer_unique_id;
	string2 cer_rec_type;
	string1 cer_type;
	string20	cer_type_mapped;
	string1 cer_level;
	string45	cer_level_mapped;
	string8 cer_exp_date;
	string99 ratings;
end;
layout_pilot_prettied_slim to_slim(res_with_certificate l) := transform
self := l;
end;

keepers := res_with_certificate(pilot_lname=offender_lname or pilot_lname=sor_lname);

strong_keepers := keepers( 
	           (pilot_fname=offender_fname or pilot_fname=sor_fname) and 
			   (p_city_name<>'' and (p_city_name=sor_p_city_name or p_city_name=offender_p_city_name)));

strong_keepersx := dedup(sort(distribute(project(strong_keepers,to_slim(left)),hash(id)),record,local),all,local);

output(strong_keepersx,,'~thor::temp::pilot_derogatories_detail_strong_keepers',overwrite);
