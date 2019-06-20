EXPORT Layout_infutor_best_DID := RECORD

	unsigned6    did := 0;
	qstring10    phone := '';
	qstring9     ssn := '';
	integer4     dob := 0;
	qstring20    fname := '';
	qstring20    mname := '';
	qstring20    lname := '';
	qstring5	   name_suffix := '';
	qstring10    prim_range := '';
	string2      predir := '';
	qstring28    prim_name := '';
	qstring4     suffix := '';
	string2      postdir := '';
	qstring10    unit_desig := '';
	qstring8     sec_range := '';
	qstring25    city_name := '';
	string2      st := '';
	qstring5     zip := '';
	qstring4     zip4 := '';
	unsigned3    addr_dt_last_seen := 0;
	unsigned8			RawAID:=0;
	unsigned3    addr_dt_first_seen := 0;
	//CCPA-101 add 2 CCPA new fields
	UNSIGNED4			global_sid := 0;
	UNSIGNED8			record_sid := 0;

END;