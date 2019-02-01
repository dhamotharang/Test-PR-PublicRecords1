//****************Function to append flags/indicators when matching to Watchdog***************

import watchdog;
export Fn_Append_Best(dataset(recordof(Layouts.base_BIP)) email_in) := function

Best_f := Watchdog.File_Best;

Best_d := distribute(Best_f, hash(did));

email_in_d := distribute(email_in(did > 0), hash(did));

//------Matches to best file to determine if name and address are same as best
recordof(email_in) t_append_best(email_in_d le, Best_d ri):= transform
	self.best_ssn        := if(ri.ssn <> '', ri.ssn, le.best_ssn);
	self.best_dob        := if(ri.dob > 0, ri.dob, le.best_dob);
	self.did_type 			 := ri.adl_ind;
	self := le;
end;

append_best		 := join(email_in_d , 
											 Best_d,
											 left.did = right.did,
											 t_append_best(left, right),
										   left outer,
											 local);
					
return append_best + email_in(did = 0);
end;