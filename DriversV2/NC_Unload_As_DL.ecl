import ut, lib_stringlib, Drivers, idl_header, _Validate, Data_services, std;

in_file 	:=  DriversV2.File_DL_NC_In_Full;
		
TrimUpper(string s)	:= function
   return trim(stringlib.StringToUppercase(s),left,right);
end;

Table_Layout 	:= record,MAXLENGTH(100)
  string desc;
  string code;
end; 

//Restric_Table   := dataset(ut.foreign_prod+'thor_data400::lookup::dl2::nc_restrictions',Table_Layout,CSV(SEPARATOR(['|']),QUOTE('"'), TERMINATOR(['\r\n', '\n'])));
Restric_Table   := dataset('~thor_data400::lookup::dl2::nc_restrictions',Table_Layout,CSV(SEPARATOR(['|']),QUOTE('"'), TERMINATOR(['\r\n', '\n'])));


DriversV2.Layout_DL_NC_In.raw_full restric_Trans(in_file l, Table_Layout r ) := transform
  self.RESTRICTIONS 	:= if(lib_stringlib.StringLib.StringFind(trim(l.restrictions,left,right),r.desc,1)<>0,r.code,'');
	self         		  	:= l;
end;

restriction_codes := join(in_file , Restric_Table,
											TrimUpper(left.RESTRICTIONS[1..7]) = right.desc[1..7],
											restric_Trans(left,right),
											left outer, lookup
  										 );

DriversV2.Layout_DL_Extended trans_unload(restriction_codes le)   := transform
  self.orig_state       			  	:= 'NC';
	self.source_code              	:= 'AD';
	self.dt_first_seen    			  	:= if(_Validate.Date.fIsValid((string)le.dt_first_seen),le.dt_first_seen div 100,0);
	self.dt_last_seen     			  	:= if(_Validate.Date.fIsValid((string)le.dt_last_seen),le.dt_last_seen div 100, 0);
	self.dt_vendor_first_reported 	:= if(_Validate.Date.fIsValid((string)le.dt_vendor_first_reported),le.dt_vendor_first_reported div 100, 0);
	self.dt_vendor_last_reported 		:= if(_Validate.Date.fIsValid((string)le.dt_vendor_last_reported),le.dt_vendor_last_reported div 100, 0);
	self.dateReceived				  	    := if(_Validate.Date.fIsValid((string)le.dt_last_seen),le.dt_last_seen,0);
	self.dl_number        			  	:= if((integer)stringlib.stringfilter(le.dl_nbr,'0123456789')<>0,trim(le.dl_nbr,left,right),'');
  self.name             			  	:= trim(if(Datalib.StrCompare(le.first_name,'0123456789')=0,trim(le.first_name),'')+ 
																					if(Datalib.StrCompare(le.middle_name,'0123456789')=0,trim(' '+ le.middle_name),'') +
																					if(Datalib.StrCompare(le.last_name,'0123456789')=0,trim(' '+le.last_name),'')+ trim(' '+le.suffix),left); 
	self.addr1            			  	:= le.ADDRESS ;
	self.city             			  	:= le.o_city;
	self.state            			  	:= le.o_state  ;
	self.zip              			  	:= if((integer)stringlib.stringfilter(le.o_ZIP5,'0123456789')<>0,stringlib.stringfilter(le.o_ZIP5,'0123456789'),'');
	self.dob              			  	:= if(_Validate.Date.fIsValid((string)le.dob),le.dob,0);
	self.sex_flag                		:= le.gender  ;
	self.orig_expiration_date 			:= le.exp_date;
	self.orig_issue_date 				    := if(_Validate.Date.fIsValid((string)le.ISSUE_DATE),le.ISSUE_DATE,0);
	self.expiration_date  			  	:= le.exp_date;
	self.lic_issue_date   			  	:= if(_Validate.Date.fIsValid((string)le.ISSUE_DATE),le.ISSUE_DATE,0);
	self.history						        := if(self.expiration_date = 0,'U', if(self.expiration_date <> 0 and (string)self.expiration_date < (string8)Std.Date.Today(),'E',if(self.expiration_date <> 0 and (string)self.expiration_date >=(string8)Std.Date.Today(),'','H')));
	self.restrictions			  	      := trim(le.RESTRICTIONS, left, right);
	self.restrictions_delimited			:= self.restrictions;
	self.OrigLicenseClass			  	  := trim(le.license_CLASS, left, right);
	self.fname            				  := if(Datalib.StrCompare(le.fname,'0123456789')=0,le.fname,'');
	self.mname            			  	:= if(Datalib.StrCompare(le.mname,'0123456789')=0,le.mname,'');
	self.lname            			  	:= if(Datalib.StrCompare(le.lname,'0123456789')=0,le.lname,'');
	self.name_suffix     				    := ut.fGetSuffix(le.sname);
	self.prim_range      				    := le.prim_range;		                             
	self.predir          			     	:= le.predir;		                             
	self.prim_name       				    := le.prim_name;		                             
	self.suffix          				    := le.addr_suffix;		                             
	self.postdir         				    := le.postdir;		                             
	self.unit_desig      				    := le.unit_desig;		                             
	self.sec_range       			    	:= le.sec_range;		                             
	self.p_city_name     				    := le.p_city_name;		                             
	self.v_city_name     				    := le.v_city_name;		                             
	self.st              				    := le.st;		                             
	self.zip5            				    := le.zip;		                             
	self.zip4            			    	:= le.zip4;	
	self.err_stat        				    := le.addr_error_code;
	self.CDL_status                 := le.cdl_ind;
	self                  				  := [];
end;

NC_Unload 		:= project(restriction_codes,trans_unload(left));

license_Table := dataset(Data_services.foreign_prod+'thor_data400::lookup::dl2::nc_license_class',Table_Layout,CSV(SEPARATOR(['|']),QUOTE('"'), TERMINATOR(['\r\n', '\n'])));				   

DriversV2.Layout_DL_Extended Trans_licen_class(DriversV2.Layout_DL_Extended input, Table_Layout r ) := transform
  self.license_class 		:= r.code;
  self         		  	  := input;
end;

license_class := join(NC_Unload , license_Table,
										trim(left.OrigLicenseClass,left,right) = right.desc,
										Trans_licen_class(left,right),
										left outer, lookup
										 );

ut.mac_flipnames(license_class, fname, mname, lname, NC_Unload_post_flip);

export NC_Unload_As_DL := NC_Unload_post_flip : persist(DriversV2.Constants.Cluster + 'Persist::DL2::DrvLic_NC_Unload_as_DL');