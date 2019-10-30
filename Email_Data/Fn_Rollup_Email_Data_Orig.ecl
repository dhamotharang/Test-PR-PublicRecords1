import ut, STD;
export Fn_Rollup_Email_Data_Orig(dataset(recordof(Layout_Email.Base)) email_in) := function


email_rec_and_fix_dates := project(email_in, transform(Layout_Email.Base,
															self.email_rec_key := hash64((data)trim(left.orig_pmghousehold_id, left, right) + 																																																									 
																											(data)trim(left.orig_pmgindividual_id, left, right) +
																											(data)trim(left.orig_first_name, left, right) +
																											(data)trim(left.orig_last_name, left, right) +
																											(data)trim(left.orig_address, left, right) +
																											(data)trim(left.orig_city, left, right) +
																											(data)trim(left.orig_state, left, right) +
																											(data)trim(left.orig_zip, left, right) +
																											(data)trim(left.orig_zip4, left, right) +
																											(data)trim(left.orig_email, left, right) +
																											(data)trim(left.orig_ip, left, right) +
																											(data)trim(left.orig_site, left, right) +
																											(data)trim(left.orig_e360_id, left, right) +
																											(data)trim(left.orig_teramedia_id, left, right) +
																											(data)trim(left.activecode, left, right) +
																											(data)trim(left.email_src, left, right)),
																											
															 self.date_first_seen := if(left.date_first_seen[..8] not between '197001' and (string8)STD.Date.Today(), '', left.date_first_seen),
															 self.date_last_seen := if(left.date_last_seen[..8] not between '197001' and (string8)STD.Date.Today(), '', left.date_last_seen),
															 self.date_vendor_first_reported := if(left.date_vendor_first_reported[..8] not between '197001' and (string8)STD.Date.Today(), '', left.date_vendor_first_reported),
															 self.date_vendor_last_reported := if(left.date_vendor_last_reported[..8] not between '197001' and (string8)STD.Date.Today(), '', left.date_vendor_last_reported),
															 //DF-16472
															 self.orig_email := REGEXREPLACE('[\n|\r]',left.orig_email,'');
															 //EMAIL-152 - remove special characters
															 SELF.orig_site := ut.fn_RemoveSpecialChars(left.orig_site);
															 self := left));
															 
															 
email_in_s := sort(distribute(email_rec_and_fix_dates, hash(email_rec_key)),email_rec_key,date_last_seen, date_vendor_last_reported, local);

recordof(email_in) t_rollup(email_in_s le, email_in ri) := transform
	self.rec_src_all 								:= le.rec_src_all | ri.rec_src_all;
	self.email_src 									:= Translation_Codes.fCheapest_Src(self.rec_src_all);
	self.email_src_all              := self.rec_src_all;																				
	self.email_src_num 							:= if(le.rec_src_all | ri.rec_src_all  = le.rec_src_all, le.email_src_num, le.email_src_num + ri.email_src_num);
	self.date_first_seen 						:= (string)ut.EarliestDate((unsigned)le.date_first_seen, (unsigned)ri.date_first_seen);
	self.date_last_seen  						:= MAX(ri.date_last_seen);
	self.date_vendor_first_reported := (string)ut.EarliestDate((unsigned)le.date_vendor_first_reported, (unsigned)ri.date_vendor_first_reported);
	self.date_vendor_last_reported	:= MAX(ri.date_vendor_last_reported);
	self := ri;
end;

email_rollup := rollup(email_in_s,
											 left.email_rec_key = right.email_rec_key,
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