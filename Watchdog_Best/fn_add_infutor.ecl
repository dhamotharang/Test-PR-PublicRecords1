IMPORT header, infutor, ut;

consumer := infutor.pconsumer_header;		// src = 'PN'
voters := infutor.Voters_Header;				// src = 'VO'

ds1 := infutor.File_Infutor_DID;

header.layout_header_V2 reformat(infutor.infutor_layout_main.layout_base_tracker l, integer c) := transform
	cversion_dev := infutor._config.get_cversion_dev; 
/* //check date validity by length, number values, and between 1901 and today */

	Valid_Date_Range(string in_date) := in_date[1..6] between '190101' and ut.GetDate[1..6];
	self.did := l.did;
	self.rid := 0;
	self.src := 'IF';
	self.dt_last_seen := map(l.addr_type='O' => max((unsigned)l.last_activity_dt[1..6],(unsigned)l.effective_dt[1..6]), 
							 stringlib.stringtouppercase(l.addr_type) = 'P1' => (unsigned)l.prev1_addr_effective_dt[1..6],
							 stringlib.stringtouppercase(l.addr_type) = 'P2' => (unsigned)l.prev2_addr_effective_dt[1..6],
							 stringlib.stringtouppercase(l.addr_type) = 'P3' => (unsigned)l.prev3_addr_effective_dt[1..6],
							 stringlib.stringtouppercase(l.addr_type) = 'P4' => (unsigned)l.prev4_addr_effective_dt[1..6],
							 stringlib.stringtouppercase(l.addr_type) = 'P5' => (unsigned)l.prev5_addr_effective_dt[1..6],
							 0);
	self.dt_first_seen := map(l.addr_type='O' => (unsigned)l.effective_dt[1..6], self.dt_last_seen);
	self.dt_vendor_last_reported := (unsigned)cversion_dev[1..6];
	self.dt_vendor_first_reported := (unsigned)cversion_dev[1..6];
	self.dt_nonglb_last_seen := 0;
	self.vendor_id := '';
	self.dob := (integer4)l.orig_dob_dd_appended;
	self.suffix := l.addr_suffix;
	self.city_name := l.v_city_name; // changed from p to v as v is used in other examples and is completely spelled out
	self.rec_type := '';
	self.county := l.county[3..];
	self.ssn		:= '';
	self := l;
end;

ds2 := project(ds1(did != 0), reformat(left, counter));

inf := DEDUP(ds2, RECORD);	// src = 'IF'



EXPORT fn_add_infutor := inf + consumer + voters;
