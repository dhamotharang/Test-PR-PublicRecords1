//****************Function to rollup records with the same Email_rec_key********************
import ut, mdr;
export Fn_Rollup_Email_Data(dataset(recordof(Layout_Email.Base)) email_in) := function

fix_dates := project(email_in, transform(Layout_Email.Base,
															 self.date_first_seen := if(left.date_first_seen[..8] not between '197001' and ut.GetDate[..8], '', left.date_first_seen),
															 self.date_last_seen := if(left.date_last_seen[..8] not between '197001' and ut.GetDate[..8], '', left.date_last_seen),
															 self.date_vendor_first_reported := if(left.date_vendor_first_reported[..8] not between '197001' and ut.GetDate[..8], '', left.date_vendor_first_reported),
															 self.date_vendor_last_reported := if(left.date_vendor_last_reported[..8] not between '197001' and ut.GetDate[..8], '', left.date_vendor_last_reported),
															 self := left));
															 
															 
email_in_s := sort(distribute(fix_dates, hash(email_rec_key)),email_rec_key,local);

recordof(email_in) t_rollup(email_in_s le, email_in ri) := transform
	self.rec_src_all 								:= le.rec_src_all | ri.rec_src_all;
	self.email_src 									:= Translation_Codes.fCheapest_Src(self.rec_src_all);
	self.email_src_all              := self.rec_src_all;																				
	self.email_src_num 							:= if(le.rec_src_all | ri.rec_src_all  = le.rec_src_all, le.email_src_num, le.email_src_num + ri.email_src_num);
	self.orig_pmghousehold_id 			:= if(le.orig_pmghousehold_id  <> '', le.orig_pmghousehold_id, ri.orig_pmghousehold_id);
	self.orig_pmgindividual_id 			:= if(le.orig_pmgindividual_id  <> '', le.orig_pmgindividual_id, ri.orig_pmgindividual_id);
	self.orig_first_name 						:= if(le.orig_first_name  <> '', le.orig_first_name, ri.orig_first_name);
	self.orig_last_name 						:= if(le.orig_last_name  <> '', le.orig_last_name, ri.orig_last_name);
	self.orig_address 							:= if(le.orig_address  <> '', le.orig_address, ri.orig_address);
	self.orig_city 									:= if(le.orig_city  <> '', le.orig_city, ri.orig_city);
	self.orig_state 								:= if(le.orig_state  <> '', le.orig_state, ri.orig_state);
	self.orig_zip										:= if(le.orig_zip  <> '', le.orig_zip, ri.orig_zip);
	self.orig_zip4 									:= if(le.orig_zip4  <> '', le.orig_zip4, ri.orig_zip4);
	self.orig_ip 										:= if(le.orig_ip  <> '', le.orig_ip, ri.orig_ip);
	self.orig_login_date 							:= (string)ut.LatestDate((unsigned)le.orig_login_date, (unsigned)ri.orig_login_date);
	self.orig_site									:= if(le.orig_site  <> '', le.orig_site, ri.orig_site);
	self.orig_e360_id								:= if(le.orig_e360_id  <> '', le.orig_e360_id, ri.orig_e360_id);
	self.orig_teramedia_id 					:= if(le.orig_teramedia_id  <> '', le.orig_teramedia_id, ri.orig_teramedia_id);
	self.clean_name.title  					:= if(le.clean_name.title  <> '', le.clean_name.title, ri.clean_name.title);
	self.clean_name.mname  					:= if(le.clean_name.mname  <> '', le.clean_name.mname, ri.clean_name.mname);
	self.clean_name.name_suffix 		:= if(le.clean_name.name_suffix  <> '', le.clean_name.name_suffix , ri.clean_name.name_suffix);
	self.clean_name.name_score 			:= if(le.clean_name.name_score  <> '', le.clean_name.name_score , ri.clean_name.name_score );
	self.clean_address.p_city_name 	:= if(le.clean_address.p_city_name <> '', le.clean_address.p_city_name, ri.clean_address.p_city_name);
	self.clean_address.v_city_name 	:= if(le.clean_address.v_city_name <> '', le.clean_address.v_city_name, ri.clean_address.v_city_name);
	self.clean_address.st 					:= if(le.clean_address.st <> '', le.clean_address.st, ri.clean_address.st);
	self.clean_address.zip4 				:= if(le.clean_address.zip4 <> '', le.clean_address.zip4, ri.clean_address.zip4);
	self.clean_address.cart 				:= if(le.clean_address.cart <> '', le.clean_address.cart, ri.clean_address.cart);
	self.clean_address.cr_sort_sz 	:= if(le.clean_address.cr_sort_sz <> '', le.clean_address.cr_sort_sz, ri.clean_address.cr_sort_sz);
	self.clean_address.lot 					:= if(le.clean_address.lot <> '', le.clean_address.lot, ri.clean_address.lot);
	self.clean_address.lot_order 		:= if(le.clean_address.lot_order <> '', le.clean_address.lot_order, ri.clean_address.lot_order);
	self.clean_address.dbpc 				:= if(le.clean_address.dbpc <> '', le.clean_address.dbpc, ri.clean_address.dbpc);
	self.clean_address.chk_digit		:= if(le.clean_address.chk_digit <> '', le.clean_address.chk_digit, ri.clean_address.chk_digit);
	self.clean_address.rec_type 		:= if(le.clean_address.rec_type <> '', le.clean_address.rec_type, ri.clean_address.rec_type);
	self.clean_address.county 			:= if(le.clean_address.county <> '', le.clean_address.county, ri.clean_address.county);
	self.clean_address.geo_lat 			:= if(le.clean_address.geo_lat <> '', le.clean_address.geo_lat, ri.clean_address.geo_lat);
	self.clean_address.geo_long 		:= if(le.clean_address.geo_long <> '', le.clean_address.geo_long, ri.clean_address.geo_long);
	self.clean_address.msa 					:= if(le.clean_address.msa <> '', le.clean_address.msa, ri.clean_address.msa);
	self.clean_address.geo_blk 			:= if(le.clean_address.geo_blk <> '', le.clean_address.geo_blk, ri.clean_address.geo_blk);
	self.clean_address.geo_match 		:= if(le.clean_address.geo_match <> '', le.clean_address.geo_match, ri.clean_address.geo_match);
	self.clean_address.err_stat 		:= if(le.clean_address.err_stat <> '', le.clean_address.err_stat, ri.clean_address.err_stat);
	self.append_rawaid 							:= if(le.append_rawaid > 0, le.append_rawaid, ri.append_rawaid);
	self.best_ssn 									:= if(le.best_ssn <> '', le.best_ssn, ri.best_ssn);
	self.best_dob 									:= if(le.best_dob > 0, le.best_dob, ri.best_dob);
	self.activecode 								:= if(le.activecode <> '', le.activecode, ri.activecode);
	self.date_first_seen 						:= (string)ut.EarliestDate((unsigned)le.date_first_seen, (unsigned)ri.date_first_seen);
	self.date_last_seen  						:= (string)ut.LatestDate((unsigned)le.date_last_seen, (unsigned)ri.date_last_seen);
	self.date_vendor_first_reported := (string)ut.EarliestDate((unsigned)le.date_vendor_first_reported, (unsigned)ri.date_vendor_first_reported);
	self.date_vendor_last_reported	:= (string)ut.LatestDate((unsigned)le.date_vendor_last_reported, (unsigned)ri.date_vendor_last_reported);
	self.did												:= if(le.did > 0, le.did, ri.did);
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
