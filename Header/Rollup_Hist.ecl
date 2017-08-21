import ut;
rec := RECORD
unsigned8 uid;
Layout_Eq_Rollup;
end;

file_equifax := dataset('~thor_data400::in::quickhdr_raw_history_rf',Layout_Eq_Rollup,THOR);
dist_file_eqfx := distribute(file_equifax,hash(first_name,last_name,current_address,current_state,current_zip,cid));

string fn_pick_populated(string le_in,string ri_in):= if(le_in='',ri_in,le_in);

rec t_set_ar(dist_file_eqfx le) := transform
self.uid := 0;
self.current_address_date_reported := le.current_address_date_reported[3..6]+le.current_address_date_reported[1..2];
self.former1_address_date_reported := le.former1_address_date_reported[3..6]+le.former1_address_date_reported[1..2];
self.former2_address_date_reported := le.former2_address_date_reported[3..6]+le.former2_address_date_reported[1..2];
self.min_ar1 := self.current_address_date_reported;
self.max_ar1 := self.current_address_date_reported;
self.min_ar2 := self.former1_address_date_reported;
self.max_ar2 := self.former1_address_date_reported;
self.min_ar3 := self.former2_address_date_reported;
self.max_ar3 := self.former2_address_date_reported;
self.file_date_min := le.file_date;
self.file_date_max := le.file_date;
self.birthdate := le.birthdate[3..6]+le.birthdate[1..2];
self := le;
end;

proj_set_ar := project(dist_file_eqfx,t_set_ar(left));

ut.MAC_Sequence_Records(proj_set_ar,uid,seq_set_ar);

rec t_rollup(seq_set_ar le,seq_set_ar ri) := transform
self.min_ar1 := if(le.current_address_date_reported='' or ri.current_address_date_reported='',
					max(le.current_address_date_reported,ri.current_address_date_reported),
					min(le.current_address_date_reported,ri.current_address_date_reported));
self.max_ar1 := max(le.current_address_date_reported,ri.current_address_date_reported);
self.min_ar2 := if(le.former1_address_date_reported='' or ri.former1_address_date_reported='',
					max(le.former1_address_date_reported,ri.former1_address_date_reported),
					min(le.former1_address_date_reported,ri.former1_address_date_reported));
self.max_ar2 := max(le.former1_address_date_reported,ri.former1_address_date_reported);
self.min_ar3 := if(le.former2_address_date_reported='' or ri.former2_address_date_reported='',
					max(le.former2_address_date_reported,ri.former2_address_date_reported),
					min(le.former2_address_date_reported,ri.former2_address_date_reported));
self.max_ar3 := max(le.former2_address_date_reported,ri.former2_address_date_reported);
self.file_date_min := min(le.file_date,ri.file_date);
self.file_date_max := max(le.file_date,ri.file_date);
self.middle_initial := fn_pick_populated(le.middle_initial,ri.middle_initial);
self.suffix := fn_pick_populated(le.suffix,ri.suffix);
self.current_city := fn_pick_populated(le.current_city,ri.current_city);
self.former_first_name:=fn_pick_populated(le.former_first_name, ri.former_first_name);
self.former_middle_initial:=fn_pick_populated(le.former_middle_initial, ri.former_middle_initial);
self.former_last_name:=fn_pick_populated(le.former_last_name, ri.former_last_name);
self.former_suffix:=fn_pick_populated(le.former_suffix, ri.former_suffix);
self.former_first_name2:=fn_pick_populated(le.former_first_name2, ri.former_first_name2);
self.former_middle_initial2:=fn_pick_populated(le.former_middle_initial2, ri.former_middle_initial2);
self.former_last_name2:=fn_pick_populated(le.former_last_name2, ri.former_last_name2);
self.former_suffix2:=fn_pick_populated(le.former_suffix2, ri.former_suffix2);
self.aka_first_name:=fn_pick_populated(le.aka_first_name, ri.aka_first_name);
self.aka_middle_initial:=fn_pick_populated(le.aka_middle_initial, ri.aka_middle_initial);
self.aka_last_name:=fn_pick_populated(le.aka_last_name, ri.aka_last_name);
self.aka_suffix:=fn_pick_populated(le.aka_suffix, ri.aka_suffix);
self.former1_address:=fn_pick_populated(le.former1_address, ri.former1_address);
self.former1_city:=fn_pick_populated(le.former1_city, ri.former1_city);
self.former1_state:=fn_pick_populated(le.former1_state, ri.former1_state);
self.former1_zip:=fn_pick_populated(le.former1_zip, ri.former1_zip);
self.former2_address:=fn_pick_populated(le.former2_address, ri.former2_address);
self.former2_city:=fn_pick_populated(le.former2_city, ri.former2_city);
self.former2_state:=fn_pick_populated(le.former2_state, ri.former2_state);
self.former2_zip:=fn_pick_populated(le.former2_zip, ri.former2_zip);
self.ssn:=fn_pick_populated(le.ssn, ri.ssn);
self.ssn_confirmed:=fn_pick_populated(le.ssn_confirmed, ri.ssn_confirmed);	
self.birthdate:=fn_pick_populated(le.birthdate,ri.birthdate); 
self.phone:=fn_pick_populated(le.phone,ri.phone); 	
self.current_occupation_employer:=fn_pick_populated(le.current_occupation_employer,ri.current_occupation_employer);
self.former_occupation_employer:=fn_pick_populated(le.former_occupation_employer,ri.former_occupation_employer);
self.former2_occupation_employer:=fn_pick_populated(le.former2_occupation_employer,ri.former2_occupation_employer); 
self.other_occupation_employer:=fn_pick_populated(le.other_occupation_employer,ri.other_occupation_employer); 
self.other_former_occupation_employer:=fn_pick_populated(le.other_former_occupation_employer,ri.other_former_occupation_employer);

self:= le;
end;


srt_eq_monthly := sort(seq_set_ar,
						first_name,						
						last_name,						
						current_address,						
						current_state,
						current_zip,
						cid,
						middle_initial,
						suffix,
						current_city,
						former_first_name,
						former_middle_initial,
						former_last_name,
						former_suffix,
						former_first_name2,
						former_middle_initial2,
						former_last_name2,
						former_suffix2,
						aka_first_name,
						aka_middle_initial,
						aka_last_name,
						aka_suffix,
						former1_address,
						former1_city,
						former1_state,
						former1_zip,
						former2_address,
						former2_city,
						former2_state,
						former2_zip,
						ssn,
						ssn_confirmed,
						birthdate,
						phone,
						current_occupation_employer,
						former_occupation_employer,
						former2_occupation_employer,
						other_occupation_employer,
						other_former_occupation_employer,
						current_address_date_reported,
						former1_address_date_reported,
						former2_address_date_reported,
						file_date,local);

roll_eq_uid_monthly := rollup(srt_eq_monthly,
	(left.first_name= right.first_name and	
	left.last_name= right.last_name and	
	left.current_address= right.current_address and	
	left.current_state= right.current_state and
	left.current_zip= right.current_zip and
	left.cid = right.cid) 
	and
		((left.middle_initial= right.middle_initial and
		left.suffix= right.suffix and
		left.current_city= right.current_city and
		left.former_first_name= right.former_first_name and
		left.former_middle_initial= right.former_middle_initial and
		left.former_last_name= right.former_last_name and
		left.former_suffix= right.former_suffix and
		left.former_first_name2= right.former_first_name2 and
		left.former_middle_initial2= right.former_middle_initial2 and
		left.former_last_name2= right.former_last_name2 and
		left.former_suffix2= right.former_suffix2 and
		left.aka_first_name= right.aka_first_name and
		left.aka_middle_initial= right.aka_middle_initial and
		left.aka_last_name= right.aka_last_name and
		left.aka_suffix= right.aka_suffix and
		left.former1_address= right.former1_address and
		left.former1_city= right.former1_city and
		left.former1_state= right.former1_state and
		left.former1_zip= right.former1_zip and
		left.former2_address= right.former2_address and
		left.former2_city= right.former2_city and
		left.former2_state= right.former2_state and
		left.former2_zip= right.former2_zip and
		left.ssn= right.ssn and
		left.ssn_confirmed= right.ssn_confirmed and	
		left.birthdate=right.birthdate and 
		left.phone=right.phone and 	
		left.current_occupation_employer=right.current_occupation_employer and
		left.former_occupation_employer=right.former_occupation_employer and
		left.former2_occupation_employer=right.former2_occupation_employer and 
		left.other_occupation_employer=right.other_occupation_employer and 
		left.other_former_occupation_employer=right.other_former_occupation_employer)		
		or 
			(left.current_address_date_reported=right.current_address_date_reported and
			 left.file_date=right.file_date and
			 ut.nneq(left.middle_initial,right.middle_initial) and
			 ut.nneq(left.suffix,right.suffix) and
			 ut.nneq(left.current_city,right.current_city) and
			 ut.nneq(left.former_first_name, right.former_first_name) and
			 ut.nneq(left.former_middle_initial, right.former_middle_initial) and
			 ut.nneq(left.former_last_name, right.former_last_name) and
			 ut.nneq(left.former_suffix, right.former_suffix) and
			 ut.nneq(left.former_first_name2, right.former_first_name2) and
			 ut.nneq(left.former_middle_initial2, right.former_middle_initial2) and
			 ut.nneq(left.former_last_name2, right.former_last_name2) and
			 ut.nneq(left.former_suffix2, right.former_suffix2) and
			 ut.nneq(left.aka_first_name, right.aka_first_name) and
			 ut.nneq(left.aka_middle_initial, right.aka_middle_initial) and
			 ut.nneq(left.aka_last_name, right.aka_last_name) and
			 ut.nneq(left.aka_suffix, right.aka_suffix) and
			 ut.nneq(left.former1_address, right.former1_address) and
			 ut.nneq(left.former1_city, right.former1_city) and
			 ut.nneq(left.former1_state, right.former1_state) and
			 ut.nneq(left.former1_zip, right.former1_zip) and
			 ut.nneq(left.former2_address, right.former2_address) and
			 ut.nneq(left.former2_city, right.former2_city) and
			 ut.nneq(left.former2_state, right.former2_state) and
			 ut.nneq(left.former2_zip, right.former2_zip) and
			 ut.nneq(left.ssn, right.ssn) and
			 ut.nneq(left.ssn_confirmed, right.ssn_confirmed) and	
			 ut.nneq(left.birthdate,right.birthdate) and 
			 ut.nneq(left.phone,right.phone) and 	
			 ut.nneq(left.current_occupation_employer,right.current_occupation_employer) and
			 ut.nneq(left.former_occupation_employer,right.former_occupation_employer) and
			 ut.nneq(left.former2_occupation_employer,right.former2_occupation_employer) and 
			 ut.nneq(left.other_occupation_employer,right.other_occupation_employer) and 
			 ut.nneq(left.other_former_occupation_employer,right.other_former_occupation_employer)))			
,t_rollup(left,right),local):persist('~thor_data400::temp::chk_eqfx_rollup_v2');

export Rollup_Hist := roll_eq_uid_monthly;