export fn_rollup(dataset(recordof(marriage_divorce_v2.layout_mar_div_intermediate)) int0)
	:=
function
 
int0_dist := distribute(int0,hash(vendor,state_origin,filing_type,party1_name,party2_name));

int0_sort := sort(int0_dist,
                  record,
                  except dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,
							      record_id,process_date,pname_party1,pname_party2,pname_party1_alias,pname_party2_alias,
							      ca_party1,ca_party2,touched,
						   local
						  );

recordof(int0)  rollup_repeating_records(recordof(int0) le, recordof(int0) ri) := transform

 
 self.process_date  := if(le.process_date    > ri.process_date,    le.process_date, ri.process_date);
 
 self.dt_first_seen := if(le.dt_first_seen > ri.dt_first_seen, ri.dt_first_seen, le.dt_first_seen);
 self.dt_last_seen  := if(le.dt_last_seen  < ri.dt_last_seen,  ri.dt_last_seen,  le.dt_last_seen);
 
 self.dt_vendor_first_reported := if(le.dt_vendor_first_reported > ri.dt_vendor_first_reported, ri.dt_vendor_first_reported, le.dt_vendor_first_reported);
 self.dt_vendor_last_reported  := if(le.dt_vendor_last_reported  < ri.dt_vendor_last_reported,  ri.dt_vendor_last_reported,  le.dt_vendor_last_reported);
 
 //If the names and addresses have already been cleaned, keep them
 self.pname_party1       := if(le.pname_party1<>'',le.pname_party1,ri.pname_party1);
 self.pname_party2       := if(le.pname_party2<>'',le.pname_party2,ri.pname_party2);
 self.pname_party1_alias := if(le.pname_party1_alias<>'',le.pname_party1_alias,ri.pname_party1_alias);
 self.pname_party2_alias := if(le.pname_party2_alias<>'',le.pname_party2_alias,ri.pname_party2_alias);
 
 self.ca_party1 := if(le.ca_party1<>'',le.ca_party1,ri.ca_party1);
 self.ca_party2 := if(le.ca_party2<>'',le.ca_party2,ri.ca_party2);
 
 self.touched   := if(le.touched<>'',le.touched,ri.touched);
  
 self := le;
end;

roll_em := rollup(int0_sort,rollup_repeating_records(left,right),
                  record,
				  except dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,
				         record_id,process_date,pname_party1,pname_party2,pname_party1_alias,pname_party2_alias,
						 ca_party1,ca_party2,touched,
						 local
				  );

return roll_em;

end;								