import Drivers, ut;

basic_in    := drivers.File_Mo_BascData_Raw;
issue_in    := drivers.File_Mo_icissu_raw;

// The use of dedup is unnecessary and eliminates data history, the rollup later in the process
// should take care of things. (8/28/13)
basic_dist  := distribute(basic_in, hash(UNIQUE_KEY));
issue_dist  := distribute(issue_in, hash(D_NO_UNIQUE_ID_ISKEY));

bad_names   := ['UNKNOWN','UNK','UNKN','NONE','N/A','UNAVAILABLE'];
bad_mnames  := ['NMN','NMI'];

DriversV2.Layout_DL_Extended make_mo(basic_in l, issue_in r) := transform
	//self.did:= 0 ;
	//self.Preglb_did:= 0 ;
	self.orig_state      := 'MO';
	self.dt_first_seen   := (unsigned8)l.process_date div 100;
	self.dt_last_seen    := (unsigned8)l.process_date div 100;
	self.dt_vendor_first_reported := (unsigned8)l.process_date div 100;
	self.dt_vendor_last_reported  := (unsigned8)l.process_date div 100;
	self.dateReceived		 :=	(integer)l.process_date;
	self.DLCP_Key        := trim(l.UNIQUE_KEY, left, right);
	self.history         := '';
	self.name            := trim(l.firstname) + ' ' + trim(l.middlename) + ' ' + trim(l.lastname) + ' ' + trim(l.name);
	self.RawFullName     := trim(l.firstname) + ' ' + trim(l.middlename) + ' ' + trim(l.lastname) + ' ' + trim(l.name);	
	self.addr1           := l.street;
	self.city            := l.city;
	self.state           := l.state;
	self.zip             := l.zip;
	self.dob             := (unsigned4)l.birthdate;
	self.race            := '';
	self.sex_flag        := l.sex;
	self.license_class   := trim(r.D_CD_CLASS_ISHIS, left, right);
	self.license_type    := trim(r.D_CD_TRANS_TYPE_ISHIS, left, right);
	self.OrigLicenseClass:= trim(r.D_CD_CLASS_ISHIS, left, right);
	self.OrigLicenseType := trim(r.D_CD_TRANS_TYPE_ISHIS, left, right);	
	self.moxie_license_type 	 := if(r.D_CD_RECORD_TYPE_ISHIS <> 'L', r.D_CD_RECORD_TYPE_ISHIS, r.D_CD_CLASS_ISHIS);
	self.attention_flag  := l.donor_ind;
	self.dod             := '';
	self.restrictions    := r.D_CD_RESTRICTIONS_X_ISHS;
	self.orig_issue_date := 0; 		//what goes here
	self.expiration_date := if(r.D_DA_EXPIRATION_ISHIS='' or r.D_DA_EXPIRATION_ISHIS='00000000' or r.D_DA_EXPIRATION_ISHIS='99999999',
							   0,
							   (unsigned4)r.D_DA_EXPIRATION_ISHIS
							  );
	self.lic_issue_date  := (unsigned4)r.D_DA_LICENSE_MAILED_ISHIS;
	self.active_date     := 0;		//what goes here
	self.inactive_date   := 0;		//what goes here
	self.lic_endorsement := r.D_CD_ENDORSEMENTS_X_ISHIS;
	self.motorcycle_code := '';
	self.dl_number       := l.cln;
	self.ssn             := '';
	self.age             := '';
	self.privacy_flag    := l.DPPA_Code;
	self.driver_edu_code := '';
	self.dup_lic_count   := '';
	self.rcd_stat_flag   := '';
	self.height          := l.height;
	self.hair_color      := '';
	self.eye_color       := l.eyes;
	self.weight          := l.weight;
	self.oos_previous_dl_number := r.D_NO_OS_LICENSE_NO_ISCPS;
	self.oos_previous_st := If( r.D_CD_COMPACT_TYPE_ISCPS = '1', r.D_NA_STATE_ISCPS, '');
	/*self.title;*/
	self.fname           := if (trim(l.fname,left,right) in bad_names, '', l.fname);
	self.mname           := if (trim(l.mname,left,right) in bad_names + bad_mnames, '', l.mname);
	self.lname           := if (trim(l.lname,left,right) in bad_names, '', l.lname);
	/*
	self.name_suffix;
	self.cleaning_score;
	self.addr_fix_flag := '';
	self.prim_range;
	self.predir;
	self.prim_name;
	self.suffix;
	self.postdir;
	self.unit_desig;
	self.sec_range;
	self.p_city_name;
	self.v_city_name;
	self.st;
	self.zip5;
	self.zip4;
	self.cart;
	self.cr_sort_sz;
	self.lot;
	self.lot_order;
	self.dpbc := '';
	self.chk_digit;
	self.rec_type;
	self.ace_fips_st := '';
	self.county;
	self.geo_lat;
	self.geo_long;
	self.msa := '';
	self.geo_blk;
	self.geo_match;
	self.err_stat;*/
	self.status          := l.OPER_STATUS;
	self.issuance        := '';
	self.address_change  := '';
	self.name_change     := '';
	self.dob_change      := '';
	self.sex_change      := '';
	self.old_dl_number   := '';
	self.dl_key_number   := r.D_NO_Unique_ID_ISKEY;
	self.CDL_status      := l.COMM_STATUS;
	Issued							 := l.lic_ic='Y' or l.lic_ic='F' or l.lic_ic = 'C';
	NonDriverID					 := l.id_card_ic!=' ' and l.id_card_ic!='' and l.id_card_ic!='N';
	Permit							 := l.permit_ind!=' ' and l.permit_ind!='' and l.permit_ind!='N';
	self.IssuedRecord		 := if (Issued or NonDriverID or Permit,
																'',
																'U'
															);	
	self                 := l;
end;

ds_joined := join(basic_dist, issue_dist,
				  left.unique_key = right.D_NO_UNIQUE_ID_ISKEY,
			 	  make_mo(left, right),
				  left outer,
				  local);

// This extra rollup is necessary to not send in billions of records to the DL_Joined attribute (8/28/13)
srt_ds_joined := sort(ds_joined,
                         orig_state, dl_number,name, addr1, city, state, zip, dob, race, sex_flag,
												 license_type, attention_flag, dod, restrictions, orig_expiration_date,
												 orig_issue_date, lic_issue_date, expiration_date, active_date, inactive_date,
												 lic_endorsement, motorcycle_code, ssn, age, privacy_flag, driver_edu_code,
												 dup_lic_count, rcd_stat_flag, height, hair_color, eye_color, weight,
                         oos_previous_dl_number, oos_previous_st, status, issuance, address_change,
												 name_change, dob_change, sex_change, old_dl_number, dl_key_number, 
                         //want to keep the oldest rec
                         lic_issue_date, orig_expiration_date,-dt_last_seen,
                      local);

mac_selfequalr(field) := macro
  self.field := r.field;
endmacro;

typeof(srt_ds_joined) rollem(srt_ds_joined l, srt_ds_joined r) := transform
	//take the right (older data) on cleaned fields
	mac_selfequalr(title)
	mac_selfequalr(fname)
	mac_selfequalr(mname)
	mac_selfequalr(lname)
	mac_selfequalr(name_suffix)
	mac_selfequalr(cleaning_score)
	mac_selfequalr(addr_fix_flag)
	mac_selfequalr(prim_range)
	mac_selfequalr(predir)
	mac_selfequalr(prim_name)
	mac_selfequalr(suffix)
	mac_selfequalr(postdir)
	mac_selfequalr(unit_desig)
	mac_selfequalr(sec_range)
	mac_selfequalr(p_city_name)
	mac_selfequalr(v_city_name)
	mac_selfequalr(st)
	mac_selfequalr(zip5)
	mac_selfequalr(zip4)
	mac_selfequalr(cart)
	mac_selfequalr(cr_sort_sz)
	mac_selfequalr(lot)
	mac_selfequalr(lot_order)
	mac_selfequalr(dpbc)
	mac_selfequalr(chk_digit)
	mac_selfequalr(rec_type)
	mac_selfequalr(ace_fips_st)
	mac_selfequalr(county)
	mac_selfequalr(geo_lat)
	mac_selfequalr(geo_long)
	mac_selfequalr(msa)
	mac_selfequalr(geo_blk)
	mac_selfequalr(geo_match)
	mac_selfequalr(err_stat)
	self.dt_first_seen            := ut.EarliestDate(l.dt_first_seen,	r.dt_first_seen);
	self.dt_last_seen             := max(l.dt_last_seen, r.dt_last_seen);
	self.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
	self.dt_vendor_last_reported 	:= max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
	//otherwise take the orig
	self := l;
end;

rolled_ds_joined := rollup(srt_ds_joined,
													 left.orig_state = right.orig_state and
															left.dl_number = right.dl_number and
															left.name = right.name and
															left.addr1 = right.addr1 and
															left.city = right.city and
															left.state = right.state and
															left.zip = right.zip and
															left.dob = right.dob and
															left.race = right.race and
															left.sex_flag = right.sex_flag and
															left.license_type = right.license_type and
															left.attention_flag = right.attention_flag and
															left.dod = right.dod and
															left.restrictions = right.restrictions and
															left.orig_expiration_date = right.orig_expiration_date and
															left.orig_issue_date = right.orig_issue_date and
															left.lic_issue_date = right.lic_issue_date and
															left.expiration_date = right.expiration_date and
															left.active_date = right.active_date and
															left.inactive_date = right.inactive_date and
															left.lic_endorsement = right.lic_endorsement and
															left.motorcycle_code = right.motorcycle_code and
															left.ssn = right.ssn and
															left.age = right.age and
															left.privacy_flag = right.privacy_flag and
															left.driver_edu_code = right.driver_edu_code and
															left.dup_lic_count = right.dup_lic_count and
															left.rcd_stat_flag = right.rcd_stat_flag and
															left.height = right.height and
															left.hair_color = right.hair_color and
															left.eye_color = right.eye_color and
															left.weight = right.weight and
															left.oos_previous_dl_number = right.oos_previous_dl_number and
															left.oos_previous_st = right.oos_previous_st and
															left.status = right.status and
															left.issuance = right.issuance and
															left.address_change = right.address_change and
															left.name_change = right.name_change and
															left.dob_change = right.dob_change and
															left.sex_change = right.sex_change and
															left.old_dl_number = right.old_dl_number and
															left.dl_key_number = right.dl_key_number and
															left.IssuedRecord = right.IssuedRecord,
													 rollem(left, right),
													 local);

export MO_as_DL := rolled_ds_joined : persist(DriversV2.Constants.Cluster + 'Persist::DL2::DrvLic_MO_as_DL');