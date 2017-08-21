//****************Function to append flags/indicators for 
//								Phones seen once associated to household and houseld has not other phone
//								Number of phones associated to individual
//								Individual has an Active EDA phone?
//								The latest owner of the phone		
export Fn_Append_Phone_Ownership(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

//-----------Flag recs with phones associated to only one household ever

tbl_hhid_ph := table(phplus_in, {hhid, phone := npa+phone7},hhid, npa+phone7);

tbl_ph		:= table(tbl_hhid_ph, {phone, cnt := count(group)}, phone);

tbl_hhid	:= table(tbl_hhid_ph(hhid > 0), {hhid, cnt := count(group)}, hhid);


hhid_with_one_ph 	:= tbl_ph(cnt = 1);
phone_for_one_hhid  := tbl_hhid(cnt = 1); 


find_hhid_with_one_ph := join(distribute(tbl_hhid_ph, hash(phone)),
							  distribute(hhid_with_one_ph, hash(phone)),
							  left.phone = right.phone,
							  transform(recordof(tbl_hhid_ph),
							  self := left),
							  local);


same_ph_one_hhid := join(distribute(find_hhid_with_one_ph, hash(hhid)),
							  distribute(phone_for_one_hhid, hash(hhid)),
							  left.hhid = right.hhid,
							  transform(recordof(tbl_hhid_ph),
							  self := left),
							  local);


flag_same_ph_one_hhid := join(distribute(phplus_in, hash(npa+phone7)),
							  distribute(same_ph_one_hhid, hash(phone)),
							  left.npa+left.phone7 = right.phone,
							  transform(recordof(phplus_in),
							  self.append_seen_once_ind := if(right.phone <> '', true, left.append_seen_once_ind),
							  self := left),
							  left outer,
							  local);
							  
//-------------Determine number of phones associated with individual

tbl_indiv_ph 		:= table(phplus_in, {did, phone := npa+phone7},did, npa+phone7);

tbl_indiv	 		:= table(tbl_indiv_ph, {did, cnt := count(group)}, did);


indiv_ph_cnt := join(distribute(flag_same_ph_one_hhid, hash(did)),
				    distribute(tbl_indiv, hash(did)),
					left.did = right.did,
					transform(recordof(phplus_in),
					self.append_indiv_phone_cnt := right.cnt,
					self := left),
					local,
					left outer);
					
//-------------Flag recs where individual has an Active EDA number
recs_with_active_eda := dedup(sort(distribute(indiv_ph_cnt(eda_active_flag and did > 0), hash(did)), did, local), did, local);

indiv_with_eda := join(distribute(indiv_ph_cnt, hash(did)),
				    recs_with_active_eda,
					left.did = right.did,
					transform(recordof(phplus_in),
					self.append_indiv_has_active_eda_phone_flag := right.eda_active_flag,
					self:= left),
					local,
					left outer);

//-------------Flag the records for individual with the most recent phone, but include infutor tracker 

most_recent_rec := dedup(sort(distribute(indiv_with_eda, hash(npa+phone7)),npa+phone7, -dt_last_seen, -dt_first_seen, -dt_vendor_last_reported, -dt_vendor_first_reported, local),npa+phone7, local);

most_recent := join(distribute(indiv_with_eda, hash(phone7_did_key)),
				    distribute(most_recent_rec, hash(phone7_did_key)),
					left.phone7_did_key = right.phone7_did_key,
					transform(recordof(phplus_in),
					self.append_latest_phone_owner_flag := if(left.phone7_did_key = right.phone7_did_key, true, false),
					self:= left),
					local,
					left outer);

return most_recent;
end;

