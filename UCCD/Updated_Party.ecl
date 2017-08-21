import ut,Business_Header_SS;

//***** PICK A STARTING POINT AND DEDUP
party_in := uccd.File_UCC_Party_In;
party_in_ddpd := dedup(party_in(ucc_key[1] <= '5'), all) + 	dedup(party_in(ucc_key[1] > '5'), all);		 



prec := uccd.Layout_Updated_Party;


//****** NORMALIZE THE INCOMING FILE FOR EXTRA ADDRESSES AND FILL IN DATES
prec tra_init(party_in_ddpd l) := transform
	self.bdid := 0;
	self.dt_first_seen := ut.EarliestDate(ut.EarliestDate((integer)l.ucc_process_date,(integer)l.trans_date),
																			  ut.EarliestDate((integer)l.inc_date,(integer)l.eff_date));
	self.dt_last_seen  := ut.LatestDate(ut.LatestDate((integer)l.ucc_process_date,(integer)l.trans_date),
																			ut.LatestDate((integer)l.inc_date,(integer)l.eff_date));

	self.dt_vendor_first_reported := self.dt_first_seen;
	self.dt_vendor_last_reported := (integer4)l.ucc_process_date;
	self.phone10 := l.phone_number;
	/*self.party_key := if(l.party_key <> '',
											 l.party_key,
											 'HSH-' + (string16)hash(l.type_desc, ut.cleanCompany(l.name), l.address1_line1));*/
	self := l;
end;

party_good :=project(party_in_ddpd, tra_init(left));

//****** ROLLUP AND PROPOGATE DATES
party_dist := distribute(party_good, hash(ucc_key));
party_srtd := sort(party_dist, except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, ucc_process_date, type_desc, local);


prec RollupUpdate(prec l, prec r) := transform
	SELF.dt_first_seen := 
							ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
					ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
	SELF.dt_last_seen := ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
	SELF.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
	SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
	SELF.ucc_process_date := if(l.ucc_process_date > r.ucc_process_date, l.ucc_process_date, r.ucc_process_date);
	self := l;
end;

party_rllp := rollup(party_srtd, RollupUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, ucc_process_date, type_desc, local);

// INITIALIZE CURRENT BASE FILE
prec InitCurrentBase(prec l) := transform
self.bdid := 0;
self.record_type := 'H';
self := l;
end;


// COMBINE CURRENT BASE WITH UPDATE
party_update_combined := party_rllp;
														

// PROPAGATE INFORMATION FORWARD TO BLANK FIELDS
combined_sort := sort(party_update_combined,  
ucc_key,/*trans_type,std_type,type_cd,type_desc,*/role_cd,role_desc,name,std_name_type,fein,inc_date,/*ssn,dob,*///status_cd,status_desc,
address1_type_cd,address1_type_desc,address1_line1,address1_line2,address1_line3,address1_line4,address1_line5,address1_line6,address1_eff_date,
address2_type_cd,address2_type_desc,address2_line1,address2_line2,address2_line3,address2_line4,address2_line5,address2_line6,address2_eff_date,
/*phone_number,phone_number_type_cd,phone_number_type_desc,email_address,web_address, */local);
combined_grpd := group(combined_sort,  
ucc_key,/*trans_type,std_type,type_cd,type_desc,*/role_cd,role_desc,name,std_name_type,fein,inc_date,/*ssn,dob,*///status_cd,status_desc,
address1_type_cd,address1_type_desc,address1_line1,address1_line2,address1_line3,address1_line4,address1_line5,address1_line6,address1_eff_date,
address2_type_cd,address2_type_desc,address2_line1,address2_line2,address2_line3,address2_line4,address2_line5,address2_line6,address2_eff_date,
/*phone_number,phone_number_type_cd,phone_number_type_desc,email_address,web_address, */local);
combined_grpd_sort := sort(combined_grpd, ucc_process_date);

combined_propagate := group(iterate(combined_grpd_sort, uccd.TRA_Party_Propagate_Fields(left, right)));

// ROLLUP DATES FOR IDENTICAL RECORDS
propagate_sort := sort(combined_propagate, except bdid, dt_first_seen, dt_last_seen,
                                            dt_vendor_first_reported, dt_vendor_last_reported, ucc_process_date, record_type, local);

propagate_rollup := rollup(propagate_sort, RollupUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, ucc_process_date, record_type, local);

// SET CURRENT - HISTORICAL INDICATOR
party_update_combined_propagate_rollup_sort := sort(propagate_rollup,  
ucc_key,/*trans_type,std_type,type_cd,type_desc,*/role_cd,role_desc,name,std_name_type,fein,inc_date,/*ssn,dob,*///status_cd,status_desc,
address1_type_cd,address1_type_desc,address1_line1,address1_line2,address1_line3,address1_line4,address1_line5,address1_line6,address1_eff_date,
address2_type_cd,address2_type_desc,address2_line1,address2_line2,address2_line3,address2_line4,address2_line5,address2_line6,address2_eff_date,
/*phone_number,phone_number_type_cd,phone_number_type_desc,email_address,web_address, */local);
party_update_combined_propagate_rollup_grpd := group(party_update_combined_propagate_rollup_sort, 
ucc_key,/*trans_type,std_type,type_cd,type_desc,*/role_cd,role_desc,name,std_name_type,fein,inc_date,/*ssn,dob,*///status_cd,status_desc,
address1_type_cd,address1_type_desc,address1_line1,address1_line2,address1_line3,address1_line4,address1_line5,address1_line6,address1_eff_date,
address2_type_cd,address2_type_desc,address2_line1,address2_line2,address2_line3,address2_line4,address2_line5,address2_line6,address2_eff_date,
/*phone_number,phone_number_type_cd,phone_number_type_desc,email_address,web_address, */local);
party_update_combined_propagate_rollup_grpd_sort := sort(party_update_combined_propagate_rollup_grpd,-dt_vendor_last_reported, -dt_last_seen);

prec SetRecordType(prec L, prec R) := transform
self.record_type := if(l.record_type = '', 'C', r.record_type);
self := r;
end;

party_update := group(iterate(party_update_combined_propagate_rollup_grpd_sort, SetRecordType(left, right)));

// JOIN WITH CORP EVENTS TO UPDATE DATE LAST SEEN


events := uccd.Updated_Event;

layout_event_slim := record
	events.ucc_key;
	events.event_key;
	events.dt_vendor_last_reported;
	events.dt_last_seen;
end;

layout_event_slim SlimEvents(events l) := transform
self := l;
end;

events_slim := project(events(record_type = 'C'/*, event_key <> ''*/), SlimEvents(left));
events_slim_dist := distribute(events_slim, hash(ucc_key));
events_slim_sort := sort(events_slim_dist, ucc_key,  -dt_vendor_last_reported, -dt_last_seen, local); 
events_slim_dedup := dedup(events_slim_sort, ucc_key, local);

prec UpdateDates(prec l, layout_event_slim r) := transform
self.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
self.dt_last_seen := ut.LatestDate(l.dt_last_seen, r.dt_last_seen);
self := l;
end;

party_update_event := join(party_update,
                    events_slim_dedup,
					left.ucc_key = right.ucc_key and	
					//left.event_key = right.event_key and
					left.record_type = 'C',
					UpdateDates(left, right),
					left outer,
					local);
					

export Updated_Party := party_update_event : persist('TEMP::UCCD_Updated_Party');
					
//export Updated_Party := party_update;