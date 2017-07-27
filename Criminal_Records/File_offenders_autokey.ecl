import doxie_build,ut;

indataset:=doxie_build.file_offenders_keybuilding;


dist_dataset := distribute(indataset,hash(offender_key));

Autokey_layout:= Layouts.autokey_layout;

autokey_layout_w_extra_city_field:=record
	Autokey_layout;
	qstring25 p_city_name;
end;



autokey_layout_w_extra_city_field get_ssn_and_states(dist_dataset l,unsigned1 C):=transform
self.ssn := if(l.ssn_appended<>'',l.ssn_appended,l.ssn);
self.dob := if(l.pty_typ='2',l.dob_alias,l.dob);
self.did := (unsigned6) l.did;
self.state := map(C=1=>l.st,
									C=2 => ut.st2abbrev(stringlib.stringtouppercase(l.orig_state)),
									ut.st2abbrev(stringlib.stringtouppercase(l.place_of_birth)));									
self := l;				
end;


norm_file_states := normalize(dist_dataset,
map((left.orig_state=left.st and left.orig_state=  ut.st2abbrev(stringlib.stringtouppercase(left.place_of_birth)))
		or (left.orig_state='' and left.place_of_birth='')	
	=>1,
		left.st=ut.st2abbrev(stringlib.stringtouppercase(left.place_of_birth)) or
		left.orig_state =ut.st2abbrev(stringlib.stringtouppercase(left.place_of_birth)) or
		left.place_of_birth=''=>2,
		3),
 get_ssn_and_states(left,counter));
 

dup_file_states := dedup(sort(norm_file_states,offender_key,record,local),record,local); 


Autokey_layout get_cities(dup_file_states l,unsigned1 C):=transform
self.v_city_name := if(C=1,l.p_city_name,l.v_city_name);
self:= l;
end;

norm_file_cities := normalize(dup_file_states,if(left.p_city_name=left.v_city_name or left.v_city_name='',1,2),
get_cities(left,counter));

dup_file_cities := dedup(sort(norm_file_cities,offender_key,record,local),record,local); 



export File_offenders_autokey := dup_file_cities;