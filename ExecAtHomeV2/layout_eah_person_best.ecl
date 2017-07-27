export layout_eah_person_best := record
     layout_eah_title;
	string20  person_best_fname := '';
	string20  person_best_mname := '';
	string20  person_best_lname := '';
	string5   person_best_name_suffix := '';
	string10  person_prim_range := '';
     string2   person_predir := '';
     string28  person_prim_name := '';
     string4   person_suffix := '';
     string2   person_postdir := '';
     string10  person_unit_desig := '';
     string8   person_sec_range := '';
	string25  person_best_city := '';
	string2   person_best_state := '';
	string5   person_best_zip := '';
	string4   person_best_zip4 := '';
	string6   person_addr_dt_last_seen := '';
	string10  person_best_phone := ''; 
	string1   person_best_phone_active := '';
	string1   do_not_call_flag := '';
	string1   do_not_mail_flag := '';
end;
  