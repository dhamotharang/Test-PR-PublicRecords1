/*  Due to state legal restrictions, we can NOT keep history - meaning a renewal
(or any other type)would overwrite/replace the previous drivers license
Information for that individual. This includes not being able to keep name and
address and any other information of that individual
*/
import ut;
	NE_base_file :=	NE_Unload_As_DL + NE_as_DL ;
	NE_base_dst := distribute(NE_base_file, hash(dl_number));
	NE_base_srt := sort(NE_base_dst,dl_number, 
											name,
											RawFullName,
											addr1,
											city,
											state,
											zip,
											dob,
											hair_color,
											eye_color,
											weight,
											height,
											sex_flag,
											history,
											OrigLicenseType,
											OrigLicenseClass,
											license_type,
											dt_last_seen, 
											local);
											
  recordof(NE_base_srt) t_rollup (NE_base_srt le, NE_base_srt ri) := transform
	self.dt_first_seen    			  := ut.EarliestDate(le.dt_first_seen, ri.dt_first_seen);
	self.dt_last_seen     				:= max(le.dt_last_seen, ri.dt_last_seen);
	self.dt_vendor_first_reported := ut.EarliestDate(le.dt_vendor_first_reported, ri.dt_vendor_first_reported);
	self.dt_vendor_last_reported 	:= max(le.dt_vendor_last_reported, ri.dt_vendor_last_reported);
	self := ri;
  end;
//Rollup data that is the same to obtain original dates	
	NE_base_roll := rollup(NE_base_srt,
											left.name = right.name and
											left.RawFullName = right.RawFullName and
											left.addr1 = right.addr1 and
											left.city = right.city and
											left.state = right.state and
											left.zip = right.zip and
											left.dob = right.dob and
											left.hair_color = right.hair_color and
											left.eye_color = right.eye_color and
											left.weight = right.weight and
											left.height = right.height and
											left.sex_flag = right.sex_flag and
											left.history = right.history and
											left.OrigLicenseType = right.OrigLicenseType and
											left.OrigLicenseClass = right.OrigLicenseClass and
											left.license_type = right.license_type,
											t_rollup(left, right), local);

//Dedup to obtain the latest record and remove history		
 export Update_NE_dls := dedup(sort(NE_base_roll,dl_number, -dt_last_seen, local),dl_number, local)  : persist(DriversV2.Constants.Cluster + 'Persist::DL2::NE_DlRecs_With_NOHistory');
		