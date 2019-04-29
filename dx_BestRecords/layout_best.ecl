IMPORT $;

EXPORT layout_best := RECORD

	unsigned6    did := 0;
  UNSIGNED8		 permissions;
	DATASET($.Layout_records)	counts;
	qstring10    phone := '';
	qstring9     ssn := '';
	integer4     dob := 0;
	qstring5     title := '';
	qstring20    fname := '';
	qstring20    mname := '';
	qstring20    lname := '';
	qstring5     name_suffix := '';
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
	qstring8	 DOD := '';
	qstring17    Prpty_deed_id := '';
	qstring22    Vehicle_vehnum := '';
	qstring22  	 Bkrupt_CrtCode_CaseNo := '';
	integer4     main_count := 0;
	integer4     search_count := 0;
	qstring15	 DL_number := '';
	qstring12     bdid := '';
	integer4     run_date := 0;
	integer4	 total_records := 0;
	unsigned8		RawAID:=0;
	unsigned3    addr_dt_first_seen := 0;
	STRING10     ADL_ind := '';
	string1	     valid_SSN := '';
  $.Layout_best_flags;

END;