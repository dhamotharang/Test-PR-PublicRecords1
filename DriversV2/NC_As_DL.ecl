import ut,lib_stringlib, Data_services, Drivers,idl_header, std;

export NC_As_DL(dataset(DriversV2.Layout_DL_NC_In.Layout_NC_With_Clean) pFile_NC_Input) := function

in_file     :=  pFile_NC_Input;
																			
string f2CharCodeAndComma(string pRestrictionCode) :=  // process each two-character restriction code
					 if(trim(pRestrictionCode,right)<>'',
						',' + trim(pRestrictionCode,right),
						''
					   );		
						 
Table_Layout := record,MAXLENGTH(100)
	string desc;
	string code;
end; 
	
//Restric_Table := dataset(ut.foreign_prod+'thor_data400::lookup::dl2::nc_restrictions',Table_Layout,CSV(SEPARATOR(['|']),QUOTE('"'), TERMINATOR(['\r\n', '\n'])));
Restric_Table := dataset(ut.foreign_prod+'thor_data400::lookup::dl2::nc_restrictions',Table_Layout,CSV(SEPARATOR(['|']),QUOTE('"'), TERMINATOR(['\r\n', '\n'])));
 		
		
DriversV2.Layout_DL_NC_In.Layout_NC_With_Clean restric_Code1(in_file input, Table_Layout r ) := transform
		self.Restriction1 	:= r.code;
		self         		  	:= input;
end;
	
Restriction_codes1 := join(in_file, Restric_Table,
											 trim(left.Restriction1,left,right) = right.desc,
										   restric_Code1(left,right),
											 left outer, lookup
							            );
DriversV2.Layout_DL_NC_In.Layout_NC_With_Clean restric_Code2(Restriction_codes1 input, Table_Layout r ) := transform
	self.Restriction2 	:= r.code;
	self         		  	:= input;
end;
	
Restriction_codes2 := join(Restriction_codes1 , Restric_Table,
											 trim(left.Restriction2,left,right) = right.desc,
										   restric_Code2(left,right),
											 left outer, lookup
							            );
DriversV2.Layout_DL_NC_In.Layout_NC_With_Clean restric_Code3(Restriction_codes2 input, Table_Layout r ) := transform
	self.Restriction3 	:= r.code;
	self         		  	:= input;
end;
	
Restriction_codes3 := join(Restriction_codes2 , Restric_Table,
  										 trim(left.Restriction3,left,right) = right.desc,
										   restric_Code3(left,right),
											 left outer, lookup
							            );
DriversV2.Layout_DL_NC_In.Layout_NC_With_Clean restric_Code4(Restriction_codes3 input, Table_Layout r ) := transform
	self.Restriction4 	:= r.code;
	self         		  	:= input;
end;
	
Restriction_codes4 := join(Restriction_codes3 , Restric_Table,
										 trim(left.Restriction4,left,right) = right.desc,
										 restric_Code4(left,right),
										 left outer, lookup
												);
DriversV2.Layout_DL_NC_In.Layout_NC_With_Clean restric_Code5(Restriction_codes4 input, Table_Layout r ) := transform
	self.Restriction5 	:= r.code;
	self         		  	:= input;
end;

Restriction_codes5 := join(Restriction_codes4 , Restric_Table,
										 trim(left.Restriction5,left,right) = right.desc,
										 restric_Code5(left,right),
										 left outer, lookup
												);
												

DriversV2.Layout_DL_Extended trans_unload(Restriction_codes5 le)   := transform
	self.orig_state       			  := 'NC';
	self.source_code              := 'AD';
	self.dt_first_seen    			  := (unsigned8)le.process_date div 100;
	self.dt_last_seen     			  := (unsigned8)le.process_date div 100;
	self.dt_vendor_first_reported := (unsigned8)le.process_date div 100;
	self.dt_vendor_last_reported 	:= (unsigned8)le.process_date div 100;
	self.dateReceived				  		:= (integer)lib_stringlib.stringlib.stringfilter(le.process_date,'0123456789');
	self.dl_number        			  := if((integer)stringlib.stringfilter(le.License_Number,'0123456789')<>0,trim(le.License_Number,left,right),'');
	self.name             			  := trim(if(Datalib.StrCompare(le.FirstName,'0123456789')=0,trim(le.FirstName),'')+ 
																 if(Datalib.StrCompare(le.MiddleName,'0123456789')=0,trim(' '+le.MiddleName),'')+
																 if(Datalib.StrCompare(le.LastName,'0123456789')=0,trim(' '+le.LastName),'')+trim(' '+le.Suffix),left);
	self.addr1            			  := if(trim(le.ADDRESS1) <> '** ADDRESS NOT ON FILE **',trim(le.ADDRESS1),'')+trim(' '+le.ADDRESS2);
	self.city             			  := le.city;
	self.state            			  := le.state;
	self.zip              			  := if((integer)stringlib.stringfilter(le.ZIP,'0123456789')<>0,stringlib.stringfilter(le.ZIP,'0123456789'),'');
	self.dob              			  := if((unsigned4)stringlib.stringfilter(le.dob,'0123456789')<>0,(unsigned4)stringlib.stringfilter(le.dob,'0123456789'),0);
	self.orig_expiration_date 		:= if((unsigned4)stringlib.stringfilter(le.expiration,'0123456789')<>0,(unsigned4)stringlib.stringfilter(le.expiration,'0123456789'),0);
	self.orig_issue_date 					:= if((unsigned4)stringlib.stringfilter(le.ISSUEDATE,'0123456789')<>0,(unsigned4)stringlib.stringfilter(le.ISSUEDATE,'0123456789'),0);
	self.expiration_date  			  := if((unsigned4)stringlib.stringfilter(le.expiration,'0123456789')<>0,(unsigned4)stringlib.stringfilter(le.expiration,'0123456789'),0);
	self.lic_issue_date  			    := if((unsigned4)stringlib.stringfilter(le.ISSUEDATE,'0123456789')<>0,(unsigned4)stringlib.stringfilter(le.ISSUEDATE,'0123456789'),0);
	self.history						  		:=if((integer)self.expiration_date = 0,'U', if((string)self.expiration_date <> '0' and (string)self.expiration_date < (string8)Std.Date.Today(),'E',if((string)self.expiration_date <> '0' and (string)self.expiration_date >=(string8)Std.Date.Today(),'','H')));
	self.Restrictions		       		:= trim(trim(le.Restriction1,left,right) + trim(' '+trim(le.Restriction2,left,right)) + 
																			trim(' '+trim(le.Restriction3,left,right))+ trim(' '+trim(le.Restriction4,left,right))
																			+ trim(' '+trim(le.Restriction5,left,right)),left,right);
	lic_restrictions							:=if((integer)stringlib.stringfilter(self.Restrictions,'0123456789')<>0,lib_stringlib.StringLib.StringFindReplace(self.Restrictions,' ',''),'');
	self.restrictions_delimited		:= trim(lic_restrictions[1..2],right) +
																				f2CharCodeAndComma(lic_restrictions[3..4]) + 
																				f2CharCodeAndComma(lic_restrictions[5..6]) + 
																				f2CharCodeAndComma(lic_restrictions[7..8]) + 
																				f2CharCodeAndComma(lic_restrictions[9..10]);
	self.OrigLicenseType			  	:= le.licensetype;
	self.fname            				:= le.fname; //if(Datalib.StrCompare(le.fname,'0123456789')=0,le.fname,'');
	self.mname            				:= le.mname; //if(Datalib.StrCompare(le.mname,'0123456789')=0,le.mname,'');
	self.lname            				:= le.lname; //if(Datalib.StrCompare(le.lname,'0123456789')=0,le.lname,'');
	self.name_suffix     				  := le.name_suffix;
	self.prim_range      				  := le.prim_range;		                             
	self.predir          					:= le.predir;		                             
	self.prim_name       					:= le.prim_name;		                             
	self.suffix          					:= le.addr_suffix;		                             
	self.postdir         					:= le.postdir;		                             
	self.unit_desig      					:= le.unit_desig;		                             
	self.sec_range       					:= le.sec_range;		                             
	self.p_city_name     					:= le.p_city_name;		                             
	self.v_city_name     					:= le.v_city_name;		                             
	self.st              					:= le.st;		                             
	self.zip5            					:= le.zip;		                             
	self.zip4            					:= le.zip4;		
	self.cart                     := le.cart;
	self.cr_sort_sz               := le.cr_sort_sz;
	self.lot                      := le.lot;
	self.lot_order                := le.lot_order;
	self.dpbc                     := le.dpbc;
	self.chk_digit                := le.chk_digit;
	self.rec_type                 := le.rec_type;
	self.ace_fips_st              := le.ace_fips_st;
	self.county                   := le.county;
	self.geo_lat                  := le.geo_lat;
	self.geo_long                 := le.geo_long;
	self.msa                      := le.msa;
	self.geo_blk                  := le.geo_blk;
	self.geo_match                := le.geo_match;
	self.err_stat        					:= le.err_stat;
	self                  				:= [];
end;

NC_Update := project(Restriction_codes5,trans_unload(left));

license_Table := dataset(Data_services.foreign_prod+'thor_data400::lookup::dl2::nc_license_class',Table_Layout,CSV(SEPARATOR(['|']),QUOTE('"'), TERMINATOR(['\r\n', '\n'])));				   

DriversV2.Layout_DL_Extended Trans_license_type(DriversV2.Layout_DL_Extended input, Table_Layout r ) := transform
	//self.license_type 	:= r.code;
	self.license_class  := r.code;
	self         		  	:= input;
end;

licenseType := join(NC_Update , license_Table,
										 trim(left.OrigLicenseType,left,right) = right.desc,
										 Trans_license_type(left,right),
										 left outer, lookup
												);

ut.mac_flipnames(licenseType, fname, mname, lname, NC_Unload_post_flip);

NC_As_DL_mapper := NC_Unload_post_flip;

return NC_As_DL_mapper;

end;