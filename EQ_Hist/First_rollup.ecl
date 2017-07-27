import ut;

dist_file_eqfx := distribute(File.raw_rf,hash(first_name,last_name,current_address,current_state,current_zip,cid));

fn_pick_populated(string le_in,string ri_in):= if(le_in='',ri_in,le_in);

Layout.base t_set_ar(dist_file_eqfx le) := transform
	self.file_date_min := (unsigned)le.file_date;
	self.file_date_max := (unsigned)le.file_date;
	self.current_address_date_reported := le.current_address_date_reported[3..6] + le.current_address_date_reported[1..2];
	self.former1_address_date_reported := le.former1_address_date_reported[3..6] + le.former1_address_date_reported[1..2];
	self.former2_address_date_reported := le.former2_address_date_reported[3..6] + le.former2_address_date_reported[1..2];
	self.clean_dob     := (integer)(le.birthdate[3..6]+le.birthdate[1..2]+'00');
	self.clean_phone   := if((integer)le.phone=0,'',le.phone);
	self.clean_ssn     := if((integer)le.ssn=0,'',le.ssn);
	self               := le;
	self               := [];
end;

proj_set_ar := project(dist_file_eqfx,t_set_ar(left));

ut.MAC_Sequence_Records(proj_set_ar,uid,seq_set_ar);

Layout.base t_rollup(seq_set_ar le,seq_set_ar ri) := transform
	self.file_date_min                := min(le.file_date_min,ri.file_date_min);
	self.file_date_max                := max(le.file_date_max,ri.file_date_max);
	self.current_address_date_reported := (string)ut.Min2((integer)le.current_address_date_reported,(integer)le.current_address_date_reported);
	self.former1_address_date_reported := (string)ut.Min2((integer)le.former1_address_date_reported,(integer)ri.former1_address_date_reported);
	self.former2_address_date_reported := (string)ut.Min2((integer)le.former2_address_date_reported,(integer)ri.former2_address_date_reported);
	self.middle_initial               := fn_pick_populated(le.middle_initial,ri.middle_initial);
	self.suffix                       := fn_pick_populated(le.suffix,ri.suffix);
	self.current_city                 := fn_pick_populated(le.current_city,ri.current_city);
	self.former_first_name            :=fn_pick_populated(le.former_first_name, ri.former_first_name);
	self.former_middle_initial        :=fn_pick_populated(le.former_middle_initial, ri.former_middle_initial);
	self.former_last_name             :=fn_pick_populated(le.former_last_name, ri.former_last_name);
	self.former_suffix                :=fn_pick_populated(le.former_suffix, ri.former_suffix);
	self.former_first_name2           :=fn_pick_populated(le.former_first_name2, ri.former_first_name2);
	self.former_middle_initial2       :=fn_pick_populated(le.former_middle_initial2, ri.former_middle_initial2);
	self.former_last_name2            :=fn_pick_populated(le.former_last_name2, ri.former_last_name2);
	self.former_suffix2               :=fn_pick_populated(le.former_suffix2, ri.former_suffix2);
	self.aka_first_name               :=fn_pick_populated(le.aka_first_name, ri.aka_first_name);
	self.aka_middle_initial           :=fn_pick_populated(le.aka_middle_initial, ri.aka_middle_initial);
	self.aka_last_name                :=fn_pick_populated(le.aka_last_name, ri.aka_last_name);
	self.aka_suffix                   :=fn_pick_populated(le.aka_suffix, ri.aka_suffix);
	self.former1_address              :=fn_pick_populated(le.former1_address, ri.former1_address);
	self.former1_city                 :=fn_pick_populated(le.former1_city, ri.former1_city);
	self.former1_state                :=fn_pick_populated(le.former1_state, ri.former1_state);
	self.former1_zip                  :=fn_pick_populated(le.former1_zip, ri.former1_zip);
	self.former2_address              :=fn_pick_populated(le.former2_address, ri.former2_address);
	self.former2_city                 :=fn_pick_populated(le.former2_city, ri.former2_city);
	self.former2_state                :=fn_pick_populated(le.former2_state, ri.former2_state);
	self.former2_zip                  :=fn_pick_populated(le.former2_zip, ri.former2_zip);
	self.ssn                          :=fn_pick_populated(le.ssn, ri.ssn);
	self.ssn_confirmed                :=fn_pick_populated(le.ssn_confirmed, ri.ssn_confirmed);	
	self.clean_ssn                    :=fn_pick_populated(le.clean_ssn, ri.clean_ssn);
	self.clean_dob                    :=(integer)fn_pick_populated((string)le.clean_dob,(string)ri.clean_dob); 
	self.clean_phone                  :=fn_pick_populated(le.clean_phone,ri.clean_phone); 	
	self.current_occupation_employer  :=fn_pick_populated(le.current_occupation_employer,ri.current_occupation_employer);
	self.former_occupation_employer   :=fn_pick_populated(le.former_occupation_employer,ri.former_occupation_employer);
	self.former2_occupation_employer  :=fn_pick_populated(le.former2_occupation_employer,ri.former2_occupation_employer); 
	self.other_occupation_employer    :=fn_pick_populated(le.other_occupation_employer,ri.other_occupation_employer); 
	self.other_former_occupation_employer :=fn_pick_populated(le.other_former_occupation_employer,ri.other_former_occupation_employer);
	self:= le;
end;


srt_eq_monthly := sort(seq_set_ar,record, except file_date_max, file_date_min, local);

roll_eq_uid_monthly := rollup(srt_eq_monthly,
										left.first_name      = right.first_name
								and left.last_name       = right.last_name
								and left.current_address = right.current_address
								and left.current_state   = right.current_state
								and left.current_zip     = right.current_zip
								and left.cid             = right.cid
								and
								(
									(
											left.middle_initial                   =right.middle_initial
									and left.suffix                           =right.suffix
									and left.current_city                     =right.current_city
									and left.former_first_name                =right.former_first_name
									and left.former_middle_initial            =right.former_middle_initial
									and left.former_last_name                 =right.former_last_name
									and left.former_suffix                    =right.former_suffix
									and left.former_first_name2               =right.former_first_name2
									and left.former_middle_initial2           =right.former_middle_initial2
									and left.former_last_name2                =right.former_last_name2
									and left.former_suffix2                   =right.former_suffix2
									and left.aka_first_name                   =right.aka_first_name
									and left.aka_middle_initial               =right.aka_middle_initial
									and left.aka_last_name                    =right.aka_last_name
									and left.aka_suffix                       =right.aka_suffix
									and left.former1_address                  =right.former1_address
									and left.former1_city                     =right.former1_city
									and left.former1_state                    =right.former1_state
									and left.former1_zip                      =right.former1_zip
									and left.former2_address                  =right.former2_address
									and left.former2_city                     =right.former2_city
									and left.former2_state                    =right.former2_state
									and left.former2_zip                      =right.former2_zip
									and left.clean_ssn                        =right.clean_ssn
									and left.ssn_confirmed                    =right.ssn_confirmed
									and left.clean_dob                        =right.clean_dob
									and left.clean_phone                      =right.clean_phone
									and left.current_occupation_employer      =right.current_occupation_employer
									and left.former_occupation_employer       =right.former_occupation_employer
									and left.former2_occupation_employer      =right.former2_occupation_employer
									and left.other_occupation_employer        =right.other_occupation_employer
									and left.other_former_occupation_employer =right.other_former_occupation_employer
									)		
								or 
									(
											left.current_address_date_reported            =right.current_address_date_reported
									and left.former1_address_date_reported            =right.former1_address_date_reported
									and left.former2_address_date_reported            =right.former2_address_date_reported
									and ut.nneq(left.middle_initial,                   right.middle_initial)
									and ut.nneq(left.suffix,                           right.suffix)
									and ut.nneq(left.current_city,                     right.current_city)
									and ut.nneq(left.former_first_name,                right.former_first_name)
									and ut.nneq(left.former_middle_initial,            right.former_middle_initial)
									and ut.nneq(left.former_last_name,                 right.former_last_name)
									and ut.nneq(left.former_suffix,                    right.former_suffix)
									and ut.nneq(left.former_first_name2,               right.former_first_name2)
									and ut.nneq(left.former_middle_initial2,           right.former_middle_initial2)
									and ut.nneq(left.former_last_name2,                right.former_last_name2)
									and ut.nneq(left.former_suffix2,                   right.former_suffix2)
									and ut.nneq(left.aka_first_name,                   right.aka_first_name)
									and ut.nneq(left.aka_middle_initial,               right.aka_middle_initial)
									and ut.nneq(left.aka_last_name,                    right.aka_last_name)
									and ut.nneq(left.aka_suffix,                       right.aka_suffix)
									and ut.nneq(left.former1_address,                  right.former1_address)
									and ut.nneq(left.former1_city,                     right.former1_city)
									and ut.nneq(left.former1_state,                    right.former1_state)
									and ut.nneq(left.former1_zip,                      right.former1_zip)
									and ut.nneq(left.former2_address,                  right.former2_address)
									and ut.nneq(left.former2_city,                     right.former2_city)
									and ut.nneq(left.former2_state,                    right.former2_state)
									and ut.nneq(left.former2_zip,                      right.former2_zip)
									and ut.nneq(left.clean_ssn,                        right.clean_ssn)
									and ut.nneq(left.ssn_confirmed,                    right.ssn_confirmed)
									and ut.NNEQ_Date(left.clean_dob,                   right.clean_dob)
									and ut.nneq(left.clean_phone,                      right.clean_phone)
									and ut.nneq(left.current_occupation_employer,      right.current_occupation_employer)
									and ut.nneq(left.former_occupation_employer,       right.former_occupation_employer)
									and ut.nneq(left.former2_occupation_employer,      right.former2_occupation_employer)
									and ut.nneq(left.other_occupation_employer,        right.other_occupation_employer)
									and ut.nneq(left.other_former_occupation_employer, right.other_former_occupation_employer)
									)
								)			
						,t_rollup(left,right)
						,local);

export First_rollup := dataset('~thor_data400::persist::eq_hist::First_rollup',Layout.base-[rec_tp],flat);