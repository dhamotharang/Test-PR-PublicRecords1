import ut,lib_stringlib, Drivers,idl_header,std;

	         in_file            :=  DriversV2.File_NE_Unload;
			  
			TrimUpper(string s):= function
		
				return trim(stringlib.StringToUppercase(s),left,right);
			 
			end;

Valid_Lic_type_cd := ['BUS','LIC','LPC','LPD','LPE','MHP','POP',
                      'SCP','WRK'];
					  
string f2CharCodeAndComma(string pRestrictionCode) :=  // process each two-character restriction code
					 if(trim(pRestrictionCode,right)<>'',
						',' + trim(pRestrictionCode,right),
						''
					   );	
					   
DriversV2.Layout_DL_Extended trans_unload(in_file le)   := transform
	self.orig_state       			  := 'NE';
	self.source_code              := 'AD';
	self.dt_first_seen    			  := (unsigned8)lib_stringlib.stringlib.stringfilter((string)le.dt_first_seen,'0123456789') div 100;
	self.dt_last_seen     				:= (unsigned8)lib_stringlib.stringlib.stringfilter((string)le.dt_last_seen,'0123456789') div 100;
	self.dt_vendor_first_reported := (unsigned8)lib_stringlib.stringlib.stringfilter((string)le.dt_vendor_first_reported,'0123456789') div 100;
	self.dt_vendor_last_reported  := (unsigned8)lib_stringlib.stringlib.stringfilter((string)le.dt_vendor_last_reported,'0123456789') div 100;
	self.dateReceived							:= (integer)lib_stringlib.stringlib.stringfilter((string)le.dt_last_seen,'0123456789');
	self.dl_number        				:= if((integer)stringlib.stringfilter(le.dl_nbr,'0123456789')<>0,trim(le.dl_nbr,left,right),'');
	self.name             				:= trim(trimUpper(le.first_name)) + trim(' '+ trimUpper(le.middle_name)) + trim(' '+trimUpper(le.last_name)) + trim(' '+trimUpper(le.suffix)); 
	self.RawFullName							:= trim(trimUpper(le.first_name)) + trim(' '+ trimUpper(le.middle_name)) + trim(' '+trimUpper(le.last_name)) + trim(' '+trimUpper(le.suffix));
	self.addr1            				:= trimUpper(le.address_1) + ' ' +  trimUpper(le.address_2);
	self.city             				:= trimUpper(le.o_city);
	self.state            				:= trimUpper(le.dl_state)  ;
	self.zip              				:= if((integer)stringlib.stringfilter(le.o_ZIP,'0123456789')<>0,stringlib.stringfilter(le.o_ZIP,'0123456789'),'');
	self.ssn 											:= if((integer)stringlib.stringfilter(le.ssn,'0123456789')<>0,trim(le.ssn,left,right),'');
	self.dob              				:= (unsigned4)if((integer)stringlib.stringfilter(le.dob,'0123456789')<>0,stringlib.stringfilter(le.dob,'0123456789'),'');
	self.sex_flag                 := trimUpper(le.gender)  ;
  self.expiration_date  				:= (unsigned4)if((integer)stringlib.stringfilter(le.exp_date,'0123456789')<>0,stringlib.stringfilter(le.exp_date,'0123456789'),'');
  self.lic_issue_date   				:= (unsigned4)if((integer)stringlib.stringfilter(le.issue_date,'0123456789')<>0,stringlib.stringfilter(le.issue_date,'0123456789'),'');
	self.history						  		:= if((string)self.expiration_date <> '0' and (string)self.expiration_date < (string8)Std.Date.Today(),'E', 'U');
	//We have received restriction codes form vendor but did not received the corresponding descriptions to add in codes_v3 table.
	self.restrictions			  			:=if((integer)stringlib.stringfilter(le.license_restrict,'0123456789')<>0,trimUpper(le.license_restrict),'');
	lic_restrictions							:=if((integer)stringlib.stringfilter(le.license_restrict,'0123456789')<>0,lib_stringlib.StringLib.StringFindReplace(trimUpper(le.license_restrict),'  ',''),'');
	self.restrictions_delimited		:= trim(lic_restrictions[1..2],right) +
																					f2CharCodeAndComma(lic_restrictions[3..4]) + 
																					f2CharCodeAndComma(lic_restrictions[5..6]) + 
																					f2CharCodeAndComma(lic_restrictions[7..8]) + 
																					f2CharCodeAndComma(lic_restrictions[9..10]);
	self.OrigLicenseType					:= trim(le.License_Type, left, right);	
	self.OrigLicenseClass					:= '';
	self.license_type			  			:= if (trim(le.License_Type, left, right) in Valid_Lic_type_cd, trim(le.License_Type, left, right), '');
	self.fname            				:= le.fname;
	self.mname            				:= le.mname;
	self.lname            				:= le.lname;
	self.name_suffix     					:= le.sname;
  	self.prim_range      				:= le.prim_range;		                             
	self.predir          					:= le.predir;		                             
	self.prim_name       					:= le.prim_name;		                             
	self.suffix          					:= le.addr_suffix;		                             
	self.postdir         					:= le.postdir;		                             
	self.unit_desig      					:= le.unit_desig;		                             
	self.sec_range       					:= le.sec_range;		                             
	self.p_city_name     					:= le.city;		                             
	self.v_city_name     					:= le.city;		                             
	self.st              					:= le.st;		                             
	self.zip5            					:= le.zip;		                             
	self.zip4            					:= le.zip4;		                             
	self.err_stat        					:= le.addr_error_code;	
	self                  				:= le;
	self                  				:=[];
end;


NE_Unload := project(in_file,trans_unload(left));
 
 ut.mac_flipnames(NE_Unload, fname, mname, lname, NE_Unload_post_flip);

export NE_Unload_As_DL := NE_Unload_post_flip : persist(DriversV2.Constants.Cluster + 'Persist::DL2::DrvLic_NE_Unload_as_DL');