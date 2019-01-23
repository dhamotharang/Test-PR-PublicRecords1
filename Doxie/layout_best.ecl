import watchdog;

export layout_best := record
  unsigned6    did := 0;
	qstring10    phone := '';
	string4			 timezone :='';
	qstring9     ssn := '';
	qstring9	   ssn_unmasked := '';
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
	qstring15	 DL_number := '';
	integer4     run_date := 0;
	integer4	 total_records := 0;
  unsigned1 age := 0;
  string1	  valid_ssn := '';
  STRING10     ADL_ind := '';
  end;
/*
// could be defined as a derivative of watchdog.layout_best_v2:
export layout_best := record
  watchdog.layout_best_v2 and not [main_count, search_count, bdid, RawAID, addr_dt_first_seen];
  string4 timezone := '';
  qstring9 ssn_unmasked := '';
  unsigned1 age;
end;
// ... but perhaps it's worth keeping it independent from possible changes in data build
*/
