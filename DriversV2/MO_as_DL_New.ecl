import Drivers, ut, std;

EXPORT MO_as_DL_New(dataset(DriversV2.Layouts_DL_MO_New_In.Layout_MO_with_Clean_MedCert) pFile_MO_Input) := function

dl_file     :=  pFile_MO_Input;

string f2CharCodeAndComma(string pRestrictionCode) :=  // process each two-character restriction code
					 if(trim(pRestrictionCode,right)<>'',
						',' + trim(pRestrictionCode,right),
						''
					   );		

bad_names   := ['UNKNOWN','UNK','UNKN','NONE','N/A','UNAVAILABLE'];
bad_mnames  := ['NMN','NMI'];

//Normalize the records containing Lic Issuance, Permit Issuance and Non_Driver Issuance information
DriversV2.Layouts_DL_MO_New_In.Layout_MO_With_Pdate trfNormLicType(dl_file l, INTEGER c) := TRANSFORM
  SELF.License_Class				:= CHOOSE(c, l.License_Class,
	                                        IF(l.Permit_Iss_Code = 'Y',l.Permit_Class,l.License_Class),
	                                        IF(l.Non_Driver_Code = 'Y','',l.License_Class));
	SELF.Lic_Exp_Date					:= CHOOSE(c, l.Lic_Exp_Date,
	                                        IF(l.Permit_Iss_Code = 'Y',l.Permit_Exp_Date,l.Lic_Exp_Date), 
	                                        IF(l.Non_Driver_Code = 'Y',l.Non_Driver_Exp_Date,l.Lic_Exp_Date));
	SELF.License_Endorsements	:= CHOOSE(c, l.License_Endorsements,
	                                        IF(l.Permit_Iss_Code = 'Y',l.Permit_Endorse_Codes,l.License_Endorsements),
																					IF(l.Non_Driver_Code = 'Y','',l.License_Endorsements));
	SELF.License_Restrictions	:= CHOOSE(c, l.License_Restrictions,
	                                        IF(l.Permit_Iss_Code = 'Y',l.Permit_Restric_Codes,l.License_Restrictions),
																					IF(l.Non_Driver_Code = 'Y','',l.License_Restrictions));
	SELF.License_Trans_Type		:= CHOOSE(c, l.License_Trans_Type,
	                                        IF(l.Permit_Iss_Code = 'Y',l.Permit_Trans_Type,l.License_Trans_Type),
																					IF(l.Non_Driver_Code = 'Y',l.Non_Driver_Trans_Type,l.License_Trans_Type));
	SELF.Lic_Print_Date				:= CHOOSE(c, l.Lic_Print_Date,
	                                        IF(l.Permit_Iss_Code = 'Y',l.Permit_Print_Date,l.Lic_Print_Date),
																					IF(l.Non_Driver_Code = 'Y',l.Non_Driver_Print_Date,l.Lic_Print_Date));
	Issued										:= l.Lic_Iss_Code='Y' or l.lic_Iss_Code='F' or l.Lic_Iss_Code = 'C';
	NonDriverID								:= l.Non_Driver_Code!=' ' and l.Non_Driver_Code!='' and l.Non_Driver_Code!='N';
	Permit										:= l.Permit_Iss_Code!=' ' and l.Permit_Iss_Code!='' and l.Permit_Iss_Code!='N';
	self.IssuedRecord					:= if (Issued or NonDriverID or Permit,
																			'',
																			'U'
																	 );																					
	SELF                       := l;
END;

norm_file1 := NORMALIZE(dl_file,3,trfNormLicType(LEFT,COUNTER));
														
DriversV2.Layout_DL_Extended trfNormAddr(norm_file1 l, INTEGER c) := TRANSFORM
	SELF.orig_state               := 'MO'; 
	SELF.dt_first_seen            := IF(l.lic_print_date = '',0,(UNSIGNED8)l.lic_print_date div 100);
	SELF.dt_last_seen             := IF(l.lic_print_date = '',0,(UNSIGNED8)l.lic_print_date div 100);
	SELF.dt_vendor_first_reported := (UNSIGNED8)l.process_date div 100;
	SELF.dt_vendor_last_reported  := (UNSIGNED8)l.process_date div 100;
	SELF.dateReceived		          := (UNSIGNED4)l.process_date;
	SELF.DLCP_Key                 := TRIM(l.unique_key, LEFT, RIGHT); 
	SELF.name                     := TRIM(l.first_name) + ' ' + TRIM(l.middle_name) + ' ' + TRIM(l.last_name) + ' ' + TRIM(l.suffix);
	SELF.RawFullName              := TRIM(l.first_name) + ' ' + TRIM(l.middle_name) + ' ' + TRIM(l.last_name) + ' ' + TRIM(l.suffix);	
	SELF.addr1                    := CHOOSE(c, TRIM(l.address), TRIM(l.mailing_address1 +' '+ l.mailing_address2)); 
	SELF.city                     := CHOOSE(c, TRIM(l.city), TRIM(l.mailing_city));
	SELF.state                    := CHOOSE(c, TRIM(l.state), TRIM(l.mailing_state));
	SELF.zip                      := CHOOSE(c, l.zip5, l.mailing_zip[1..5]);
	SELF.addr_type                := CHOOSE(c,'R','M');
	SELF.dob                      := (UNSIGNED4)l.date_of_birth; 
	SELF.sex_flag                 := TRIM(l.gender, LEFT, RIGHT);
	SELF.license_class            := TRIM(l.license_class, LEFT, RIGHT);
	SELF.license_type             := TRIM(l.license_trans_type, LEFT, RIGHT);
	SELF.OrigLicenseClass         := TRIM(l.license_class, LEFT, RIGHT);
	SELF.OrigLicenseType          := TRIM(l.license_trans_type, LEFT, RIGHT);	
	SELF.moxie_license_type 	    := TRIM(l.license_class, LEFT, RIGHT);
	SELF.restrictions             := TRIM(l.license_restrictions, LEFT, RIGHT);
	SELF.restrictions_delimited		:= TRIM(l.license_restrictions[1],right) +
																				f2CharCodeAndComma(l.license_restrictions[2]) + 
																				f2CharCodeAndComma(l.license_restrictions[3]) + 
																				f2CharCodeAndComma(l.license_restrictions[4]) + 
																				f2CharCodeAndComma(l.license_restrictions[5]);
	SELF.expiration_date          := IF(l.lic_exp_date='' OR l.lic_exp_date='00000000' OR l.lic_exp_date='99999999',
							                        0,(UNSIGNED4)l.lic_exp_date);
	SELF.history						  		:= IF((INTEGER)SELF.expiration_date = 0,'U', IF((STRING)SELF.expiration_date <> '0' AND (STRING)SELF.expiration_date < (STRING8)Std.Date.Today(),'E',IF((STRING)SELF.expiration_date <> '0' AND (STRING)SELF.expiration_date >=(STRING8)Std.Date.Today(),'','H')));
	SELF.lic_issue_date           := (UNSIGNED4)l.lic_print_date;
	SELF.lic_endorsement          := TRIM(l.license_endorsements, LEFT, RIGHT);
	SELF.dl_number                := TRIM(l.license_number, LEFT, RIGHT);
  SELF.privacy_flag             := TRIM(l.mvr_privacy_code, LEFT, RIGHT);
	SELF.height                   := TRIM(l.height, LEFT, RIGHT);
	SELF.eye_color                := TRIM(l.eye_color, LEFT, RIGHT);
	SELF.weight                   := TRIM(l.weight, LEFT, RIGHT);
	SELF.title                    := TRIM(l.title, LEFT, RIGHT);
	SELF.fname                    := IF(TRIM(l.fname, LEFT, RIGHT) IN bad_names, '', l.fname);
	SELF.mname                    := IF(TRIM(l.mname, LEFT, RIGHT) IN bad_names + bad_mnames, '', l.mname);
	SELF.lname                    := IF(TRIM(l.lname, LEFT, RIGHT) IN bad_names, '', l.lname);
	SELF.name_suffix              := TRIM(l.name_suffix, LEFT, RIGHT);
	SELF.prim_range               := '';
	SELF.predir 	     					  := '';
	SELF.prim_name 	     				  := '';
	SELF.suffix               	  := '';
	SELF.postdir 	     					  := '';
	SELF.unit_desig 	 					  := '';
	SELF.sec_range 	     				  := '';
	SELF.p_city_name						  := '';
	SELF.v_city_name	 					  := '';
	SELF.st	         						  := '';
	SELF.zip5 		     					  := '';
	SELF.zip4 		     					  := '';
	SELF.status                   := TRIM(l.operator_status, LEFT, RIGHT);
	SELF.issuance                 := TRIM(l.license_trans_type, LEFT, RIGHT);
	SELF.dl_key_number            := TRIM(l.unique_key, LEFT, RIGHT);
	SELF.CDL_status               := TRIM(l.commercial_status, LEFT, RIGHT);
	SELF.oos_previous_dl_number   := TRIM(l.previous_dl_number, LEFT, RIGHT);
	SELF.oos_previous_st          := TRIM(l.previous_st, LEFT, RIGHT);
	SELF                          := l;
END;

norm_file2 := NORMALIZE(norm_file1, 
												IF(	(TRIM(LEFT.address,LEFT,RIGHT)  <> TRIM(LEFT.mailing_address1 +' '+ LEFT.mailing_address2,LEFT,RIGHT) OR
														TRIM(LEFT.city,LEFT,RIGHT)     <> TRIM(LEFT.mailing_city,LEFT,RIGHT)  OR
														TRIM(LEFT.state,LEFT,RIGHT)    <> TRIM(LEFT.mailing_state,LEFT,RIGHT) OR
														TRIM(LEFT.zip5,LEFT,RIGHT)     <> TRIM(LEFT.mailing_zip[1..5],LEFT,RIGHT))   AND
						  						  TRIM(LEFT.mailing_address1 +' '+ LEFT.mailing_address2,LEFT,RIGHT) <> '',2,1),
													  trfNormAddr(LEFT,COUNTER));

// This extra rollup is necessary to not send in billions of records to the DL_Joined attribute (8/28/13)
srt_ds_joined := SORT(norm_file2,
                         orig_state, dl_number,name, addr1, city, state, zip, dob, race, sex_flag,
												 license_class, license_type, attention_flag, dod, restrictions, orig_expiration_date,
												 orig_issue_date, lic_issue_date, expiration_date, active_date, inactive_date,
												 lic_endorsement, motorcycle_code, ssn, age, privacy_flag, driver_edu_code,
												 dup_lic_count, rcd_stat_flag, height, hair_color, eye_color, weight,
                         oos_previous_dl_number, oos_previous_st, status, issuance, address_change,
												 name_change, dob_change, sex_change, old_dl_number, dl_key_number, 
                        //want to keep the oldest rec
                         lic_issue_date, orig_expiration_date,-dt_last_seen,
                      LOCAL);

mac_selfequalr(field) := MACRO
  SELF.field := r.field;
ENDMACRO;

TYPEOF(srt_ds_joined) rollem(srt_ds_joined l, srt_ds_joined r) := TRANSFORM
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
	self.dt_last_seen             := MAX(l.dt_last_seen, r.dt_last_seen);
	self.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
	self.dt_vendor_last_reported 	:= MAX(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
	//otherwise take the orig
	self := l;
end;

rolled_ds_joined := ROLLUP(srt_ds_joined,
													 LEFT.orig_state = RIGHT.orig_state AND
													 LEFT.dl_number = RIGHT.dl_number AND
													 LEFT.name = RIGHT.name AND
													 LEFT.addr1 = RIGHT.addr1 AND
													 LEFT.city = RIGHT.city AND
													 LEFT.state = RIGHT.state AND
													 LEFT.zip = RIGHT.zip AND
													 LEFT.dob = RIGHT.dob AND
													 LEFT.race = RIGHT.race AND
													 LEFT.sex_flag = RIGHT.sex_flag AND
													 LEFT.license_class = RIGHT.license_class AND
 													 LEFT.license_type = RIGHT.license_type AND
													 LEFT.attention_flag = RIGHT.attention_flag AND
													 LEFT.dod = RIGHT.dod AND
													 LEFT.restrictions = RIGHT.restrictions AND
													 LEFT.orig_expiration_date = RIGHT.orig_expiration_date AND
													 LEFT.orig_issue_date = RIGHT.orig_issue_date AND
													 LEFT.lic_issue_date = RIGHT.lic_issue_date AND
													 LEFT.expiration_date = RIGHT.expiration_date AND
													 LEFT.active_date = RIGHT.active_date AND
													 LEFT.inactive_date = RIGHT.inactive_date AND
													 LEFT.lic_endorsement = RIGHT.lic_endorsement AND
													 LEFT.motorcycle_code = RIGHT.motorcycle_code AND
													 LEFT.ssn = RIGHT.ssn AND
													 LEFT.age = RIGHT.age AND
													 LEFT.privacy_flag = RIGHT.privacy_flag AND
													 LEFT.driver_edu_code = RIGHT.driver_edu_code AND
													 LEFT.dup_lic_count = RIGHT.dup_lic_count AND
													 LEFT.rcd_stat_flag = RIGHT.rcd_stat_flag AND
													 LEFT.height = RIGHT.height AND
													 LEFT.hair_color = RIGHT.hair_color AND
													 LEFT.eye_color = RIGHT.eye_color AND
													 LEFT.weight = RIGHT.weight AND
													 LEFT.oos_previous_dl_number = RIGHT.oos_previous_dl_number AND
													 LEFT.oos_previous_st = RIGHT.oos_previous_st AND
													 LEFT.status = RIGHT.status AND
													 LEFT.issuance = RIGHT.issuance AND
													 LEFT.address_change = RIGHT.address_change AND
													 LEFT.name_change = RIGHT.name_change AND
													 LEFT.dob_change = RIGHT.dob_change AND
													 LEFT.sex_change = RIGHT.sex_change AND
													 LEFT.old_dl_number = RIGHT.old_dl_number AND
													 LEFT.dl_key_number = RIGHT.dl_key_number AND
													 left.IssuedRecord = right.issuedRecord,
													 rollem(LEFT, RIGHT),
													 LOCAL); 

MO_as_DL_mapper := rolled_ds_joined;

return MO_as_DL_mapper;

end;
