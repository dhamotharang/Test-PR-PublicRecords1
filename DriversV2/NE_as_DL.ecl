/* Due to state legal restrictions, we can NOT keep history - meaning a renewal
(or any other type)would overwrite/replace the previous drivers license
Information for that individual. This includes not being able to keep name and
address and any other information of that individual
*/
import ut;
export NE_as_DL(dataset(DriversV2.Layouts_DL_NE_In.Layout_NE_With_Clean) in_file):=function

Valid_Lic_type_cd := ['LIC','POP','SCP','LPE','LPD','LPC','BUS','WRK','MHP','IIP'];
					  
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

 ne_mapper 		 := NE_out_post_flip + Ne_out_bnk_Name ;
 ne_mapper_dst := distribute(ne_mapper, hash(dl_number));
 ne_mapper_srt := sort( ne_mapper_dst,
												dl_number, 
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
									
	recordof(ne_mapper_srt) t_rollup (ne_mapper_srt le, ne_mapper_srt ri) := transform
	
		self.dt_first_seen    			  := ut.EarliestDate(le.dt_first_seen, ri.dt_first_seen);
		self.dt_last_seen     				:= max(le.dt_last_seen, ri.dt_last_seen);
		self.dt_vendor_first_reported := ut.EarliestDate(le.dt_vendor_first_reported, ri.dt_vendor_first_reported);
		self.dt_vendor_last_reported 	:= max(le.dt_vendor_last_reported, ri.dt_vendor_last_reported);
		self 													:= ri;	
		
	end;
	
	//Rollup data that is the same to obtain original dates	
	ne_mapper_roll := rollup( ne_mapper_srt,
														left.name						  = right.name and
														left.RawFullName			= right.RawFullName and
														left.addr1						= right.addr1 and
														left.city						  = right.city and
														left.state 						= right.state and
														left.zip 						  = right.zip and
														left.dob 							= right.dob and
														left.hair_color 		  = right.hair_color and
														left.eye_color 				= right.eye_color and
														left.weight 					= right.weight and
														left.height 					= right.height and
														left.sex_flag 				= right.sex_flag and
														left.history 					= right.history and
														left.OrigLicenseType 	= right.OrigLicenseType and
														left.OrigLicenseClass = right.OrigLicenseClass and
														left.license_type 		= right.license_type,
														t_rollup(left, right), local);

	//Dedup to obtain the latest record and remove history		
	ne_as_dl_mapper := dedup(sort(ne_mapper_roll,dl_number, -dt_last_seen, local),dl_number, local); 
  return ne_as_dl_mapper; 

end;