import lib_stringlib,std;

MN_clean :=DriversV2.File_MN_New_cleanSuper(trim(RECORD_TYPE,left,right)='1');

//RECORD_TYPE='2'-records are B_card restrictions and we are not mapping these records at this time.

DriversV2.Layout_DL_Extended Trans_common(MN_clean l) := transform
	self.orig_state     		  		:= 'MN';
	self.dt_first_seen   		  		:= (unsigned8)l.process_date div 100;
	self.dt_last_seen    		  		:= (unsigned8)l.process_date div 100;
	self.dt_vendor_first_reported	:= (unsigned8)l.process_date div 100;
	self.dt_vendor_last_reported	:= (unsigned8)l.process_date div 100;
	self.dateReceived							:= (integer)l.process_date;	
	self.name 					  				:= l.NAME_FML;  
	self.RawFullName							:= l.name_FML;
	self.addr1           		  		:= l.address1;		                             
	self.city            		  		:= l.city;		                             
	self.state			 		  				:= l.state ;   
	self.zip             		 			:= l.zip_code;		                             
	self.dob             		  		:= (unsigned4)l.BIRTHDAY;                
	self.sex_flag        	 	  		:= l.SEX;		  
	self.license_class   					:= l.LICENSE_CLASS;
	string temp_licType 					:= trim(l.LICENSE_TYPE,left,right);
	self.license_type    					:= map( temp_licType = 'REGULAR'=>'1'
	                                      ,temp_licType = 'DUPL REG'=>'2'
																				,temp_licType = 'PROVISNL'=>'3'
																				,temp_licType = 'DUP PROV'=>'4'
	                                      ,temp_licType = 'PERMIT'=>'5'
																				,temp_licType = 'EXAM'=>'11'
																				,temp_licType = 'SEASONAL FARM REGULAR'=>'7'
																				,temp_licType = 'SEASONAL FARM DUPLICATE'=>'8'
																				,temp_licType = 'SEASONAL FARM UNDER21'=>'9'
	                                      ,temp_licType = 'SEASONAL FARM DUP UNDER21'=>'0'
																				,temp_licType = 'PROVISIONAL(GRADUATED LIC)'=>'P'
																				,temp_licType = 'DUPL PROVISIONAL(GARD LIC)'=>'Q','');
	self.OrigLicenseClass   			:= l.LICENSE_CLASS;
	self.OrigLicenseType 					:= trim(l.LICENSE_TYPE,left,right);											 
	self.attention_flag  					:= l.DONOR_INDICATOR; 
	integer temp_restric 					:= (integer)trim(l.RESTRICTIONS,left,right);
	self.restrictions    					:= map(	temp_restric = 1 =>'Z',
																				temp_restric between  2  and  3 =>'V',
																				temp_restric between  4  and  7 =>'U',
																				temp_restric between  8  and  15 =>'R',
																				temp_restric between  16  and  31 =>'Q',
																				temp_restric between  32  and  63 =>'L',
																				temp_restric between  64  and  127 =>'K',
																				temp_restric between  128  and  255 =>'G',
																				temp_restric between  256  and  511 =>'F',
																				temp_restric between  512  and  1023 =>'E',
																				temp_restric between  1024  and  2047 =>'D',
																				temp_restric between  2048  and  4095 =>'C',
																				temp_restric between  4096  and  8191 =>'A',
																				temp_restric between  8192  and  16383 =>'B',
																				temp_restric between  16384  and  32767 =>'I',
																				temp_restric between  32768  and  65635 =>'J',
																				temp_restric between  65636  and  131071 =>'O',
																				temp_restric between  131072  and  262143 =>'W',
																				temp_restric =262144 =>'Y',''); 
	self.expiration_date 					:= (unsigned4)l.LICENSE_EXPIR_DATE;
	self.lic_issue_date  					:= (unsigned4)l.LICENSE_ISSUE_DATE;
	self.history                  := if(self.expiration_date <> 0 and (string)self.expiration_date < (string8)Std.Date.Today(),'E', 'U');
	integer temp_Endors 					:= (integer) trim(l.ENDORSEMENTS,left,right);
	self.lic_endorsement 					:= map( temp_Endors =1=>'S',
																				temp_Endors     between  2  and  3 =>'T',
																				temp_Endors     between  4  and  7 =>'X',
																				temp_Endors     between  8  and  15 =>'H',
																				temp_Endors     between  16  and  31 =>'P',
																				temp_Endors     between  32  and  63 =>'N',
																				temp_Endors     between  64  and  127 =>'M',
																				temp_Endors = 128 =>'J',
																				temp_Endors = 129 =>'Z',''); 
	self.DLCP_Key        					:= l.DRIVER_LICENSE_NUMBER;
	self.dl_number       					:= l.DRIVER_LICENSE_NUMBER;
	self.eye_color        				:= l.EYE_COLOR;
	self.height          					:= l.HEIGHT; 
	self.weight         					:= l.WEIGHT;                             		                
	self.title           					:= l.title;
	//** JIRA: DF-17515, Person name "Tobin Jackson Dayton" flipped by the name cleaners in MN DL's
	self.fname           					:= if(trim(l.name_FML) = 'TOBIN JACKSON DAYTON', 'TOBIN', l.fname);
	self.mname           					:= if(trim(l.name_FML) = 'TOBIN JACKSON DAYTON', 'JACKSON', l.mname);
	self.lname           					:= if(trim(l.name_FML) = 'TOBIN JACKSON DAYTON', 'DAYTON', l.lname);
	self.name_suffix     					:= if(trim(l.name_FML) = 'TOBIN JACKSON DAYTON', '', l.name_suffix);
	self.prim_range      					:= l.prim_range;		                             
	self.predir										:= l.predir;		                             
	self.prim_name       					:= l.prim_name;		                             
	self.suffix          					:= l.suffix;		                             
	self.postdir        					:= l.postdir;		                             
	self.unit_desig      					:= l.unit_desig;		                             
	self.sec_range       					:= l.sec_range;		                             
	self.p_city_name     					:= l.p_city_name;		                             
	self.v_city_name     					:= l.v_city_name;		                             
	self.st              					:= l.state;		                             
	self.zip5            					:= l.zip;		                             
	self.zip4            					:= l.zip4;		                             
	self.cart           					:= l.cart;		                             
	self.cr_sort_sz     					:= l.cr_sort_sz;		                             
	self.lot             					:= l.lot;		                             
	self.lot_order       					:= l.lot_order;		                             
	self.dpbc            					:= l.dpbc;		                             
	self.chk_digit       					:= l.chk_digit;		                             
	self.rec_type        					:= l.rec_type;		                             
	self.ace_fips_st     					:= l.ace_fips_st;		                             
	self.county          					:= l.county;		                             
	self.geo_lat         					:= l.geo_lat;		                             
	self.geo_long        					:= l.geo_long;		                             
	self.msa             					:= l.msa;		                             
	self.geo_blk        					:= l.geo_blk;		                             
	self.geo_match       					:= l.geo_match;		                             
	self.err_stat        					:= l.err_stat;		                             
	self.issuance        					:= '';	
	self.old_dl_number   					:= if(trim(l.DRIVER_LICENSE_NUMBER,left,right) <> trim(l.OLD_DL_NUMBER,left,right) ,l.OLD_DL_NUMBER,''); 
	self.oos_previous_dl_number 	:= l.PREVIOUS1_LICENSE_NUMBER;
	string temp_status 						:= trim(l.LICENSE_STATUS,left,right);
  self.status          					:= map(	temp_status  = 'VALID'		=> '0'
	                                      ,temp_status = 'LIMITED'	=> '1'
																				,temp_status = 'REVOKED'	=> '2'
																				,temp_status = 'SUSPEND'	=> '3'
	                                      ,temp_status = 'CANCEL'		=> '4'
																				,temp_status = 'EXPIRED'	=> '5'
																				,temp_status = 'PENDING'	=> '6'
																				,temp_status = 'CANC-IPS'	=> '7'
																				,temp_status = 'DECEASED' => '8'
																				,temp_status = 'ID ONLY' 	=> '9'
																				,temp_status = 'TRACER' 	=> '10'
																				,temp_status = 'CONAX' 		=> '11'
																				,temp_status = 'MOPED'		=> '12'
																				,'');
	string temp_CDLstatus 				:= trim(l.COMMERCIAL_DRIVER_STATUS,left,right);									   
	self.CDL_Status      					:= map(	temp_CDLstatus  = 'VALID'=>'V'
	                                      ,temp_CDLstatus = 'LIMITED'=>'1'
																				,temp_CDLstatus = 'REVOKED'=>'2'
																				,temp_CDLstatus = 'SUSPEND'=>'3'
																				,temp_CDLstatus = 'CANCEL'=>'4'
																				,temp_CDLstatus = 'OTHER'=>'6'
																				,temp_CDLstatus = 'DECEASED'=>'7'
																				,temp_CDLstatus = 'DISQUAL'=>'8'
																				,temp_CDLstatus = 'PENDING'=>'9',''); 
    self                 				:= l;	
	
end;

export MN_New_as_dl :=project(MN_clean, Trans_common(left)): persist(DriversV2.Constants.Cluster + 'Persist::DL2::DrvLic_MN_New_as_DL');
