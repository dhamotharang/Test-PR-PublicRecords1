//****************Function to rollup records with the same Email_rec_key********************
import ut;
export Fn_Rollup_Email_Data(dataset(recordof(Layout_Email.Base)) email_in) := function
												 
email_in_s := sort(distribute(email_in, hash(clean_email,clean_address.prim_range, clean_address.prim_name, clean_address.sec_range, clean_address.zip, clean_name.lname, clean_name.fname)),
										clean_email, clean_address.prim_range, clean_address.prim_name, clean_address.sec_range, clean_address.zip, clean_name.lname , clean_name.fname, date_last_seen, date_vendor_last_reported,local);

recordof(email_in) t_rollup(email_in_s le, email_in ri) := transform
	self.rec_src_all 								:= le.rec_src_all | ri.rec_src_all;
	self.email_src 									:= Translation_Codes.fCheapest_Src(self.rec_src_all);
	self.email_src_all              := self.rec_src_all;																				
	self.email_src_num 							:= if(le.rec_src_all | ri.rec_src_all  = le.rec_src_all, le.email_src_num, le.email_src_num + ri.email_src_num);
	self.orig_pmghousehold_id 			:= if(ri.orig_pmghousehold_id  <> '', ri.orig_pmghousehold_id, le.orig_pmghousehold_id);
	self.orig_pmgindividual_id 			:= if(ri.orig_pmgindividual_id  <> '', ri.orig_pmgindividual_id, le.orig_pmgindividual_id);
	self.orig_first_name 						:= if(ri.orig_first_name  <> '', ri.orig_first_name, le.orig_first_name);
	self.orig_last_name 						:= if(ri.orig_last_name  <> '', ri.orig_last_name, le.orig_last_name);
	self.orig_address 							:= if(ri.orig_address  <> '', ri.orig_address, le.orig_address);
	self.orig_city 									:= if(ri.orig_city  <> '', ri.orig_city, le.orig_city);
	self.orig_state 								:= if(ri.orig_state  <> '', ri.orig_state, le.orig_state);
	self.orig_zip										:= if(ri.orig_zip  <> '', ri.orig_zip, le.orig_zip);
	self.orig_zip4 									:= if(ri.orig_zip4  <> '', ri.orig_zip4, le.orig_zip4);
	self.orig_ip 										:= if(ri.orig_ip  <> '', ri.orig_ip, le.orig_ip);
	self.orig_login_date 							:= MAX(ri.orig_login_date);
	self.orig_site									:= if(ri.orig_site  <> '', ri.orig_site, le.orig_site);
	self.orig_e360_id								:= if(ri.orig_e360_id  <> '', ri.orig_e360_id, le.orig_e360_id);
	self.orig_teramedia_id 					:= if(ri.orig_teramedia_id  <> '', ri.orig_teramedia_id, le.orig_teramedia_id);
	self.best_ssn 									:= if(ri.best_ssn <> '', ri.best_ssn, le.best_ssn);
	self.best_dob 									:= if(ri.best_dob > 0, ri.best_dob, le.best_dob);
	self.activecode 								:= if(ri.activecode <> '', ri.activecode, le.activecode);
	self.date_first_seen 						:= (string)ut.EarliestDate((unsigned)le.date_first_seen, (unsigned)ri.date_first_seen);
	self.date_last_seen  						:= MAX(ri.date_last_seen);
	self.date_vendor_first_reported := (string)ut.EarliestDate((unsigned)le.date_vendor_first_reported, (unsigned)ri.date_vendor_first_reported);
	self.date_vendor_last_reported	:= MAX(ri.date_vendor_last_reported);
	self.did												:= if(ri.did > 0, ri.did, le.did);
  self.did_type	                  := if(ri.did_type <> '', ri.did_type, le.did_type);
	self.hhid												:= if(ri.hhid > 0, ri.hhid, le.hhid);
	self := ri;
	end;

email_rollup := rollup(email_in_s,
											 left.clean_email = right.clean_email and
											 left.clean_address.prim_range  = right.clean_address.prim_range   and
											 left.clean_address.prim_name  = right.clean_address.prim_name   and
											 left.clean_address.sec_range  = right.clean_address.sec_range   and
											 left.clean_address.zip  = right.clean_address.zip   and
											 left.clean_name.lname  = right.clean_name.lname   and 
											 left.clean_name.fname   = right.clean_name.fname,  
											 t_rollup(left, right));
											 

//*****append num dids per email and num emails per did (including did = 0)
dids_email_dedp   := dedup(sort(distribute(email_rollup,hash(clean_email)), did, clean_email, did, local), did, clean_email, local);

num_emails_per_did := table(dids_email_dedp(did > 0), {did, cnt := count(group)}, did);
num_dids_per_email := table(dids_email_dedp, {clean_email, cnt := count(group)}, clean_email);

append_emails_per_did  := join(distribute(email_rollup(did > 0), hash(did)),
                               distribute(num_emails_per_did, hash(did)),
															 left.did = right.did,
															 transform(recordof(email_in),
																				 self.num_email_per_did := right.cnt,
																				 self := left),
															left outer,
															local);

append_dids_per_email  := join(distribute(email_rollup(did = 0) + append_emails_per_did, hash(clean_email)),
                               distribute(num_dids_per_email , hash(clean_email)),
															 left.clean_email = right.clean_email,
															 transform(recordof(email_in),
																				 self.num_did_per_email  := right.cnt,
																				 self := left),
															left outer,
															local);
															 		
return append_dids_per_email;
end;
