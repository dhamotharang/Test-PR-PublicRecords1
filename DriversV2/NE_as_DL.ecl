import ut,lib_stringlib, Drivers,idl_header;

in_file := DriversV2.File_NE_cleanSuper;

Valid_Lic_type_cd := ['LIC','POP','SCP','LPE','LPD','LPC','BUS',
                      'WRK','MHP','IIP'];
					  
DriversV2.Layout_DL_Extended intof(in_file le)   := transform
	self.orig_state       			  := 'NE';
	self.source_code              := 'AD';
	self.dt_first_seen    			  := (unsigned8)le.process_date div 100;
	self.dt_last_seen     				:= (unsigned8)le.process_date div 100;
	self.dt_vendor_first_reported := (unsigned8)le.process_date div 100;
	self.dt_vendor_last_reported 	:= (unsigned8)le.process_date div 100;
	self.dateReceived				  		:= (integer)le.process_date;	
	self.dl_number        				:= le.DLN;
	self.name             				:= le.NAME;
	self.RawFullName							:= le.NAME;
	self.addr1            				:= le.ADDRESS_STREET;
	self.city             				:= le.ADDRESS_CITY;
	self.state            				:= le.ADDRESS_STATE;
	self.zip              				:= le.ADDRESS_ZIP5;
	self.dob              				:= (unsigned4)le.dob;
	self.hair_color       				:= if(le.hair_color<>'UNK',le.hair_color,'');
	self.eye_color        				:= if(le.eye_color<>'UNK',le.eye_color,'');
	self.weight           				:= le.weight;
	self.height           				:= le.height;
	self.sex_flag									:= if(le.GENDER<>'U',le.GENDER,'');
  //self.expiration_date  			:= '';
 // self.lic_issue_date   			:= '';
	self.history				  				:= 'U';		// if no expiration date, set history to 'U'
	self.OrigLicenseType					:= trim(le.License_Type, left, right);	
	self.OrigLicenseClass					:= '';
	self.license_type			  			:= if (trim(le.License_Type, left, right) in Valid_Lic_type_cd, trim(le.License_Type, left, right), '');
	self.fname            				:= le.fname;
	self.mname            				:= le.mname;
	self.lname            				:= le.lname;
	self.name_suffix     					:= le.name_suffix;
	self.cleaning_score     			:= le.cleaning_score;
  	self.prim_range      				:= le.prim_range;		                             
	self.predir          					:= le.predir;		                             
	self.prim_name       					:= le.prim_name;		                             
	self.suffix          					:= le.suffix;		                             
	self.postdir         					:= le.postdir;		                             
	self.unit_desig      					:= le.unit_desig;		                             
	self.sec_range       					:= le.sec_range;		                             
	self.p_city_name     					:= le.p_city_name;		                             
	self.v_city_name     					:= le.v_city_name;		                             
	self.st              					:= le.state;		                             
	self.zip5            					:= le.zip;		                             
	self.zip4            					:= le.zip4;		                             
	self.cart            					:= le.cart;		                             
	self.cr_sort_sz      					:= le.cr_sort_sz;		                             
	self.lot             					:= le.lot;		                             
	self.lot_order       					:= le.lot_order;		                             
	self.dpbc            					:= le.dpbc;		                             
	self.chk_digit       					:= le.chk_digit;		                             
	self.rec_type        					:= le.rec_type;		                             
	self.ace_fips_st     					:= le.ace_fips_st;		                             
	self.county          					:= le.county;		                             
	self.geo_lat         					:= le.geo_lat;		                             
	self.geo_long        					:= le.geo_long;		                             
	self.msa             					:= le.msa;		                             
	self.geo_blk         					:= le.geo_blk;		                             
	self.geo_match       					:= le.geo_match;		                             
	self.err_stat        					:= le.err_stat;	
	self                  				:= le;
	self                  				:=[];
end;


 NE_out := project(in_file,intof(left));
 
 Ne_out_Nbnk_Name:=NE_out(name != '');
 Ne_out_bnk_Name :=NE_out(name = '');
 
	ut.mac_flipnames(Ne_out_Nbnk_Name, fname, mname, lname, NE_out_post_flip);

export NE_as_DL := NE_out_post_flip + Ne_out_bnk_Name :persist(DriversV2.Constants.Cluster + 'Persist::DL2::DrvLic_NE_as_DL');