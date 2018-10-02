import lib_stringlib, Drivers,idl_header,std;

export MA_As_DL_New(dataset(DriversV2.Layout_DL_MA_In.Layout_MA_With_Clean) pFile_MA_Input) := function

in_file  :=  pFile_MA_Input;

/* Normalize Cleaned Vendor data on the two Addresses (Mailing & Residential) */
layout_norm := record
  string1   addr_type    := '';
	string40	norm_street1 := '';				 
	string40	norm_street2 := '';				 
	string15	norm_city		 := '';						 
	string2		norm_state	 := '';					 
	string9		norm_zip		 := '';		
  recordof(in_file);
end;

layout_norm tNormalizeRec(in_file l, integer c) := transform
   self.addr_type       := choose(c, 'M', 'R');
   self.norm_street1		:= choose(c, l.licmail_street1, l.licresi_street1);
   self.norm_street2	  := choose(c, l.licmail_street2,	l.licresi_street2);
   self.norm_city 		  := choose(c, l.licmail_city,   	l.licresi_city);
   self.norm_state  		:= choose(c, l.licmail_state,  	l.licresi_state);
   self.norm_zip    		:= choose(c, l.licmail_zip,  		l.licresi_zip);   
   self                 := l;
end;

 TrimUpper(string s):= function
		return trim(stringlib.StringToUppercase(s),left,right);
 end;
 
dNormalize :=	normalize(in_file,	2,	tNormalizeRec(left, counter));
dNormalizeKeep := dNormalize(addr_type = 'M' or 
														 addr_type = 'R' and 	
															(licresi_street1<>'' or licresi_street2<>'' or
														   licresi_city<>'' or licresi_state<>'' or 
														   licresi_zip <> ''));

/* Map Cleaned/Normalized Vendor data to the DL Common Layout */
DriversV2.Layout_DL_Extended  map_to_common(dNormalizeKeep l)   := transform
	self.dt_first_seen 						:= (unsigned8)l.ISSUE_DATE_YYYYMMDD div 100; 
	self.dt_last_seen 						:= (unsigned8)l.ISSUE_DATE_YYYYMMDD div 100; 
	self.dt_vendor_first_reported := (unsigned8)l.process_date div 100;
	self.dt_vendor_last_reported 	:= (unsigned8)l.process_date div 100;
	self.orig_state       			  := 'MA';
	self.source_code              := 'AD';
	self.name             			  := l.LICENSE_FIRST_NAME + ' ' + l.LICENSE_MIDDLE_NAME + ' ' + l.LICENSE_LAST_NAME;
	self.addr_type								:= l.addr_type; /* 'M' or 'R' */
	self.addr1            			  := trimUpper(l.norm_street1) + ' ' + trimUpper(l.norm_street2);
	self.city             			  := trimUpper(l.norm_city);
	self.state            			  := l.norm_state;
	self.zip              		    := l.norm_zip[1..5];
	self.dob              			  := (integer)l.LICENSE_BDATE_YYYYMMDD;
	self.sex_flag									:= l.LICENSE_SEX;
	self.license_class						:= l.LICENSE_LIC_CLASS;	/*'A','B','C','AM','BM','CM','M','D','DM','IM'*/
	self.expiration_date  			  := (integer)l.LICENSE_EDATE_YYYYMMDD;
	self.history						  		:= if((integer)self.expiration_date = 0,'U', if((string)self.expiration_date <> '0' and (string)self.expiration_date < (string8)std.date.today(),'E',if((string)self.expiration_date <> '0' and (string)self.expiration_date >=(string8)std.date.today(),'','H')));
	self.lic_endorsement					:= if(l.LICENSE_LIC_CLASS	in ['AM','BM','CM','DM','M'],'M','');
	self.motorcycle_code					:= map(l.LICENSE_LIC_CLASS	in ['AM','BM','CM','DM'] =>'ALSO'
			                                ,l.LICENSE_LIC_CLASS	= 'M'                    =>'ONLY' ,'');
	self.dl_number        			  := l.LICENSE_LICNO;
	self.height										:= l.LICENSE_HEIGHT;
	self.fname            				:= l.LICENSE_FIRST_NAME;  
	self.mname            				:= l.LICENSE_MIDDLE_NAME;  
	self.lname            				:= l.LICENSE_LAST_NAME;  
	self.CDL_status								:= if(l.LICENSE_LIC_CLASS in ['A','B','C','AM','BM','CM'],l.LICENSE_LIC_CLASS,'');
	self.OrigLicenseClass					:= l.LICENSE_LIC_CLASS;	
	self.dateReceived				  		:= (integer)lib_stringlib.stringlib.stringfilter(l.process_date,'0123456789');
	self.RawFullName							:= l.LICENSE_FIRST_NAME + ' ' + l.LICENSE_MIDDLE_NAME + ' ' + l.LICENSE_LAST_NAME; 			 
	self.lic_issue_date 					:= (integer)l.ISSUE_DATE_YYYYMMDD;
	self.Status										:= l.clean_status;
	self                  				:= [];
end;

MA_As_DL_mapper := project(dNormalizeKeep, map_to_common(left));

return MA_As_DL_mapper;

end;
