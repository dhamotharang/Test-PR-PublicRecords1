//****************Function to append flags/indicators when matching to Watchdog***************

import watchdog;
export Fn_Apppend_Best(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

Best_f := Watchdog.File_Best;

Best_d := distribute(Best_f, hash((unsigned)did));

phplus_in_d := distribute(phplus_in, hash((unsigned)did));

//------Matches to best file to determine if name and address are same as best
recordof(phplus_in) t_append_best(phplus_in_d le, Best_d ri):= transform
	self.append_best_addr_match_flag := if(ri.did > 0 and le.pdid = 0 and 
										    trim(le.prim_range,left, right) = trim((string)ri.prim_range,left, right) and 
										    trim(le.prim_name,left, right) = trim((string)ri.prim_name,left, right) and 
										    trim(le.zip5,left, right)	   = trim((string)ri.zip,left, right), 
										   true, 
										   false);
	self.append_best_nm_match_flag := if(ri.did > 0 and le.pdid = 0 and 
										    trim(le.lname,left, right) = trim((string)ri.lname,left, right) and 
										    trim(le.fname,left, right) = trim((string)ri.fname,left, right),										    
										   true, 
										   false);										   
										   
    self := le;
end;

append_best		 := join(phplus_in_d , 
				    Best_d,
					(unsigned)left.did = (unsigned)right.did and
					left.pdid = 0,
					t_append_best(left, right),
					left outer,
					local);
					
return append_best;
end;