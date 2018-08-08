export fn_rollup(dataset(recordof(marriage_divorce_v2.layout_mar_div_intermediate)) int0)
	:=
function
 
int0_dist := distribute(int0,hash(state_origin,filing_type,party1_name,party2_name));

int0_sort := sort(int0_dist,
                  record,
                  except dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,
							      record_id,process_date,pname_party1,pname_party2,pname_party1_alias,pname_party2_alias,
							      ca_party1,ca_party2,touched,source_file,party1_race,party2_race,marriage_city,divorce_city,
								  party1_type,party2_type,
						   local
						  );

recordof(int0)  rollup_repeating_records(recordof(int0) le, recordof(int0) ri) := transform
 
 self.process_date  := if(le.process_date    > ri.process_date,    le.process_date, ri.process_date);
 
 self.dt_first_seen := if(le.dt_first_seen > ri.dt_first_seen, ri.dt_first_seen, le.dt_first_seen);
 self.dt_last_seen  := if(le.dt_last_seen  < ri.dt_last_seen,  ri.dt_last_seen,  le.dt_last_seen);
 
 self.dt_vendor_first_reported := if(le.dt_vendor_first_reported > ri.dt_vendor_first_reported, ri.dt_vendor_first_reported, le.dt_vendor_first_reported);
 self.dt_vendor_last_reported  := if(le.dt_vendor_last_reported  < ri.dt_vendor_last_reported,  ri.dt_vendor_last_reported,  le.dt_vendor_last_reported);
 
 //preserve the Direct source_file if a record is found in both Direct and XML
 self.source_file := if(~(stringlib.stringfind(le.source_file,'XML',1)!=0),le.source_file,ri.source_file);
 
 self.party1_type := if(le.party1_type<>'',le.party1_type,ri.party1_type);
 self.party2_type := if(le.party2_type<>'',le.party2_type,ri.party2_type);
 
 //If the names and addresses have already been cleaned, keep them
 self.pname_party1       := if(le.pname_party1<>'',le.pname_party1,ri.pname_party1);
 self.pname_party2       := if(le.pname_party2<>'',le.pname_party2,ri.pname_party2);
 self.pname_party1_alias := if(le.pname_party1_alias<>'',le.pname_party1_alias,ri.pname_party1_alias);
 self.pname_party2_alias := if(le.pname_party2_alias<>'',le.pname_party2_alias,ri.pname_party2_alias);
 
 self.ca_party1 := if(le.ca_party1<>'',le.ca_party1,ri.ca_party1);
 self.ca_party2 := if(le.ca_party2<>'',le.ca_party2,ri.ca_party2);
 
 self.party1_race := if(le.party1_race<>'',le.party1_race,ri.party1_race);
 self.party2_race := if(le.party2_race<>'',le.party2_race,ri.party2_race);
 
 self.marriage_city := if(le.marriage_city<>'',le.marriage_city,ri.marriage_city);
 self.divorce_city  := if(le.divorce_city<>'',le.divorce_city,ri.divorce_city);

 //DF-21262 use persistent_record_id from earlier vendor_first_seen_date
 self.persistent_record_id := if(le.dt_vendor_first_reported > ri.dt_vendor_first_reported, ri.persistent_record_id, le.persistent_record_id);
								 
 self.touched   := if(le.touched<>'',le.touched,ri.touched);
  
 self := le;
end;

//added race and marriage/divorce_city to exclusions
//direct and xml data is not consistent with these fields
roll_em := rollup(int0_sort,rollup_repeating_records(left,right),
                  record,
				  except dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,
				         record_id,process_date,pname_party1,pname_party2,pname_party1_alias,pname_party2_alias,
						 ca_party1,ca_party2,touched,source_file,party1_race,party2_race,marriage_city,divorce_city,
						 party1_type,party2_type,
						 local
				  );

return roll_em;

end;								