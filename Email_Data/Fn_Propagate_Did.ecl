//Function to propagate did to records without did where the names are simmilar to a rec with did
import header, ut;
export Fn_Propagate_Did(dataset(recordof(Layout_Email.Base)) email_in) := function

with_did :=    email_in(did > 0);
without_did := email_in(did = 0);

recordof(email_in) t_propagate_did (without_did le, with_did ri) := transform
	self.did := if(ri.clean_email <> '' , ri.did, le.did);
	self.is_did_prop := if(ri.clean_email <> '' , true, le.is_did_prop);
	self := le;
end;

propagate_did := join(distribute(without_did, hash(clean_email)), 
											distribute(with_did, hash(clean_email)),
											left.clean_email = right.clean_email and
											ut.stringsimilar(left.clean_name.lname,right.clean_name.lname) < 3 and
											ut.stringsimilar(left.clean_name.fname,right.clean_name.fname) < 3,
											t_propagate_did (left, right),
											left outer,
											keep (1),
											local);


return propagate_did + with_did;
end;