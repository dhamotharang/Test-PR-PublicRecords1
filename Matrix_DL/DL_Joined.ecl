import ut;

pre_inp 
	:= PA_as_DL
	;

//****** Check each rec to make sure it did not expire b4 that states initial load
//		 If it did, then zero out its dates

rec := record
	pre_inp.orig_state;
	integer init_load := 100 * (integer)min(group, (integer)pre_inp.dt_first_seen);
end;

dt := table(pre_inp(dt_first_Seen > 190000), rec, orig_state) : persist('Persist::Matrix_DL_Initial_Dates');


Matrix_DL.Layout_Common checkexp(Matrix_DL.Layout_Common l, dt r) := transform
  self.dt_first_seen := if(l.orig_expiration_date > 19000000 and l.orig_expiration_date < r.init_load,
						   0, l.dt_first_seen);
  self.dt_last_seen := if(l.orig_expiration_date > 19000000 and l.orig_expiration_date < r.init_load,
						   0, l.dt_last_seen);
  self.dt_vendor_first_reported := if(l.orig_expiration_date > 19000000 and l.orig_expiration_date < r.init_load,
								   0, l.dt_vendor_first_reported);
  self.dt_vendor_last_reported := if(l.orig_expiration_date > 19000000 and l.orig_expiration_date < r.init_load,
								   0, l.dt_vendor_last_reported);
  self := l;
end;

inp := join(pre_inp, dt, left.orig_state = right.orig_state, checkexp(left, right), left outer, lookup);

//****** Get rid of recs that are just a state dumping the same thing again

dist := distribute(inp, hash(orig_state, dl_number));
srtd := sort(dist,orig_state,dl_number,name,addr1,city,state,zip,dob,race,sex_flag,license_type,
	attention_flag,dod,restrictions,orig_expiration_date,orig_issue_date,lic_issue_date,
	expiration_date,active_date,inactive_date,lic_endorsement,motorcycle_code,ssn,age,
	privacy_flag,driver_edu_code,dup_lic_count,rcd_stat_flag,height,hair_color,eye_color,weight,
	oos_previous_dl_number,oos_previous_st,status,issuance,address_change,name_change,dob_change,
	sex_change,old_dl_number,dl_key_number, 
	//want to keep the oldest rec
	dt_first_seen, lic_issue_date, orig_expiration_date,
	local);
ddpd := dedup(srtd,orig_state,dl_number,name,addr1,city,state,zip,dob,race,sex_flag,license_type,
	attention_flag,dod,restrictions,orig_expiration_date,orig_issue_date,lic_issue_date,
	expiration_date,active_date,inactive_date,lic_endorsement,motorcycle_code,ssn,age,
	privacy_flag,driver_edu_code,dup_lic_count,rcd_stat_flag,height,hair_color,eye_color,weight,
	oos_previous_dl_number,oos_previous_st,status,issuance,address_change,name_change,dob_change,
	sex_change,old_dl_number,dl_key_number, local);


//****** Set the history flag update the dt_last_seen where there is a newer rec for that person


rlup_same_grp := group(sort(ddpd(history <> 'E'),dl_number, orig_State,-dt_last_seen,-dt_first_seen,-orig_expiration_Date,local),dl_number, orig_State,local);


Matrix_DL.Layout_Common make_hist(Matrix_DL.Layout_Common le,Matrix_DL.Layout_Common ri) := transform
  self.history := map(ri.orig_expiration_Date > 0 and ri.orig_expiration_Date < (unsigned4)ut.GetDate => 'E',
					  le.orig_state='' => ri.history,
					  'H');
  self.dt_last_seen := if(ri.dt_last_seen > 0 and le.dt_first_seen > ri.dt_last_seen,
						  le.dt_first_seen, ri.dt_last_seen);
  self := ri;
  end;

res := iterate(rlup_same_grp,make_hist(left,right) ) + ddpd(history = 'E');

export DL_Joined := group(res): persist('Persist::Matrix_DL_Joined');