import ut;
r := drivers.File_MN_Raw;

unsigned4	fFixDate(string pDateIn)
 :=	if(pDateIn[1] not in ['1','2'],
	   0,
	   (unsigned4)ut.unDoJulian((integer)pDateIn)
	  );

drivers.layout_dl com(r le) := transform
    self.dt_first_seen := (unsigned8)le.process_date div 100;
    self.dt_last_seen := (unsigned8)le.process_date div 100;
    self.dt_vendor_first_reported := (unsigned8)le.process_date div 100;
    self.dt_vendor_last_reported := (unsigned8)le.process_date div 100;
    self.orig_state := 'MN';

	//name                                                                                        
	self.addr1 := le.address;		                             
	self.city := le.city;		                             
	//state		                                             		                             
	self.zip := le.zip;		                             
	self.dob := (unsigned4)ut.unDoJulian((integer)le.dob);		                             
	//race		                                             		                             
	self.sex_flag := le.sex;		                             
	self.license_type := le.class;		                             
	self.attention_flag := le.donor;		                             
	//dod		                                             		                             
	self.restrictions := trim(le.code_restrictions) + 
						 if(le.corrective_lenses = 'Y', 'Z', ''); 		                             
	self.orig_expiration_date := fFixDate(le.dl_date_expire);		                             
	self.lic_issue_date := fFixDate(le.dl_date_issue);		                             
	self.lic_endorsement := le.code_endors;		                             
	//motorcycle_code		                                             		                             
	self.dl_number := le.key_driver_license;		                             
	//ssn		                                             		                             
	//age		                                             		                             
	self.privacy_flag := le.indc_restric;		                             
	//dl_orig_issue_date		        	                             		                             Julian Date
	self.height := le.hieght;		                             
	//oos_previous_dl_number		        	                             		                             
	//oos_previous_st		                                             		                             
	self.title := le.name_title;		                             
	self.fname := le.name_first;		                             
	self.mname := le.name_middle;		                             
	self.lname := le.name_last;		                             
	self.name_suffix := le.name_suffix;		                             
	self.cleaning_score := le.name_score;		                             
	//addr_fix_flag		                                             		                             
	self.prim_range := le.prim_range;		                             
	self.predir := le.predir;		                             
	self.prim_name := le.prim_name;		                             
	self.suffix := le.addr_suffix;		                             
	self.postdir := le.postdir;		                             
	self.unit_desig := le.unit_desig;		                             
	self.sec_range := le.sec_range;		                             
	self.p_city_name := le.p_city_name;		                             
	self.v_city_name := le.v_city_name;		                             
	self.st := le.state;		                             
	self.zip5 := le.zip5;		                             
	self.zip4 := le.zip4;		                             
	self.cart := le.cart;		                             
	self.cr_sort_sz := le.cr_sort_sz;		                             
	self.lot := le.lot;		                             
	self.lot_order := le.lot_order;		                             
	self.dpbc := le.dpbc;		                             
	self.chk_digit := le.chk_digit;		                             
	self.rec_type := le.rec_type;		                             
	self.ace_fips_st := le.ace_fips_st;		                             
	self.county := le.county;		                             
	self.geo_lat := le.geo_lat;		                             
	self.geo_long := le.geo_long;		                             
	self.msa := le.msa;		                             
	self.geo_blk := le.geo_blk;		                             
	self.geo_match := le.geo_match;		                             
	self.err_stat := le.err_stat;		                             
	//status		                                             		                             
	self.issuance := le._type;		                             
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
	self.weight := le.wieght;		                             
	//dlkeynumber		                                             		                             

    self := le;
end;

export MN_as_DL := project(r, com(left));