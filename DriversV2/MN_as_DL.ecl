import ut, Drivers;

r := drivers.File_MN_Raw;

unsigned4	fFixDate(string pDateIn)
 :=	if(pDateIn[1] not in ['1','2'],
	     0,
	     (unsigned4)ut.unDoJulian((integer)pDateIn)
	  );

bad_names  := ['UNKNOWN','UNK','UNKN','NONE','N/A','UNAVAILABLE'];
bad_mnames := ['NMN','NMI'];

DriversV2.Layout_DL_Extended com(r le) := transform
	self.orig_state      := 'MN';
	self.dt_first_seen   := (unsigned8)le.process_date div 100;
	self.dt_last_seen    := (unsigned8)le.process_date div 100;
	self.dt_vendor_first_reported := (unsigned8)le.process_date div 100;
	self.dt_vendor_last_reported  := (unsigned8)le.process_date div 100;
	self.dateReceived		 := (integer)le.process_date;	
	self.DLCP_Key        := trim(le.key_driver_license, left, right);
	//name                                                                                        
	self.addr1           := le.address;		                             
	self.city            := le.city;		                             
	//state		                                             		                             
	self.zip             := le.zip;		                             
	self.dob             := (unsigned4)ut.unDoJulian((integer)le.dob);		                             
	//race		                                             		                             
	self.sex_flag        := le.sex;		  
	self.license_class   := le.class;
	self.license_type    := le._type;
	self.OrigLicenseClass:= le.class;
	self.OrigLicenseType := le._type;	
	self.moxie_license_type := le.class;
	self.attention_flag  := le.donor;		                             
	//dod		                                             		                             
	self.restrictions    := trim(le.code_restrictions) + 
						    if(le.corrective_lenses = 'Y', 'Z', ''); 		                             
	//self.orig_expiration_date := fFixDate(le.dl_date_expire);
	self.expiration_date := fFixDate(le.dl_date_expire);
	self.lic_issue_date  := fFixDate(le.dl_date_issue);		                             
	self.lic_endorsement := le.code_endors;		                             
	//motorcycle_code		                                             		                             
	self.dl_number       := le.key_driver_license[1..13];		                             
	//ssn		                                             		                             
	//age		                                             		                             
	self.privacy_flag    := le.indc_restric;		                             
	//dl_orig_issue_date   Julian Date
	self.height          := le.hieght;		                             
	//oos_previous_dl_number		        	                             		                             
	//oos_previous_st		                                             		                             
	self.title           := le.name_title;		                             
	self.fname           := if (trim(le.name_first,left,right) in bad_names,'',le.name_first);	                             
	self.mname           := if (trim(le.name_middle,left,right) in bad_names + bad_mnames,'',le.name_middle);		                             
	self.lname           := if (trim(le.name_last,left,right) in bad_names,'',le.name_last);		                             
	self.name_suffix     := le.name_suffix;		                             
	self.cleaning_score  := le.name_score;		                             
	//addr_fix_flag		                                             		                             
	self.prim_range      := le.prim_range;		                             
	self.predir          := le.predir;		                             
	self.prim_name       := le.prim_name;		                             
	self.suffix          := le.addr_suffix;		                             
	self.postdir         := le.postdir;		                             
	self.unit_desig      := le.unit_desig;		                             
	self.sec_range       := le.sec_range;		                             
	self.p_city_name     := le.p_city_name;		                             
	self.v_city_name     := le.v_city_name;		                             
	self.st              := le.state;		                             
	self.zip5            := le.zip5;		                             
	self.zip4            := le.zip4;		                             
	self.cart            := le.cart;		                             
	self.cr_sort_sz      := le.cr_sort_sz;		                             
	self.lot             := le.lot;		                             
	self.lot_order       := le.lot_order;		                             
	self.dpbc            := le.dpbc;		                             
	self.chk_digit       := le.chk_digit;		                             
	self.rec_type        := le.rec_type;		                             
	self.ace_fips_st     := le.ace_fips_st;		                             
	self.county          := le.county;		                             
	self.geo_lat         := le.geo_lat;		                             
	self.geo_long        := le.geo_long;		                             
	self.msa             := le.msa;		                             
	self.geo_blk         := le.geo_blk;		                             
	self.geo_match       := le.geo_match;		                             
	self.err_stat        := le.err_stat;		                             
	self.issuance        := '';	
	self.old_dl_number   := if(le.key_driver_license[1..13] = le.soundex, '', le.soundex);
	self.weight          := le.wieght;		                             
	//dlkeynumber		                                             		                             
    self.status          := le.code_status_lic;
	self.CDL_Status      := le.code_status_com;
	self.RawFullName		 :=	le.name;
    self                 := le;	
	/*address_change		                                             		                             
	name_change		                                             		                             
	dob_change		                                             		                             
	sex_change		                                             		                             
	old_dl_number		                                             		                             
	driv_edu_code		                                             		                             
	dup_lic_count		                                             		                             
	rcd_stat_flag		                                             		                             
	hair_color		                                             		                             
	eye_color	*/	
end;

export MN_as_DL := project(r, com(left));