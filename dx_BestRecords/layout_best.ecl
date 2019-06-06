IMPORT dx_BestRecords, AID;

EXPORT layout_best := RECORD
	unsigned6 did := 0;
	qstring10 phone := '';
	string4 timezone :='';
	qstring9 ssn := '';
	qstring9 ssn_unmasked := '';
	integer4 dob := 0;
	qstring5 title := '';
	qstring20 fname := '';
	qstring20 mname := '';
	qstring20 lname := '';
	qstring5 name_suffix := '';
	qstring10 prim_range := '';
	string2 predir := '';
	qstring28 prim_name := '';
	qstring4 suffix := '';
	string2 postdir := '';
	qstring10 unit_desig := '';
	qstring8 sec_range := '';
	qstring25 city_name := '';
	string2 st := '';
	qstring5 zip := '';
	qstring4 zip4 := '';
	unsigned3 addr_dt_last_seen := 0;
	qstring8 DOD := '';
	qstring17 Prpty_deed_id := '';
	qstring22 Vehicle_vehnum := '';
	qstring22 Bkrupt_CrtCode_CaseNo := '';
	qstring15 DL_number := '';
	integer4 run_date := 0;
	integer4 total_records := 0;
	unsigned1 age := 0;
	string1 valid_ssn := '';
	string10 ADL_ind := '';
	unsigned3 addr_dt_first_seen := 0;
	AID.Common.xAID	RawAID := 0;
  dx_BestRecords.Layout_best_flags;
END;
