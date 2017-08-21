import Prof_License_Mari, ut;

#workunit('name','IAS0826 Conversion Reformat');

EXPORT BWR_IAS0826_refomat(DATASET(recordof(Prof_License_Mari.layouts.base)) pDataset) :=  function;

// dsFile := dataset('~thor_data400::in::prolic::mari::s0826', Prof_License_Mari.layouts.base, thor);
dsFile := pDataset;

	code 								:= 'IAS0826';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state

// Reference Files
county_names    := Prof_License_Mari.files_References.county_names(SOURCE_UPD =src_cd);

// Translate County Names
Prof_License_Mari.layouts.base cnty_bus(dsFile L, county_names R) := transform
		self.ADDR_CNTY_1 := IF(R.COUNTY_NAMES != '',R.COUNTY_NAMES,L.ADDR_CNTY_1);
		self := L;
	end;

	business_county_name := JOIN(dsFile, county_names,
																	TRIM(left.ADDR_CNTY_1,left,right)= TRIM(right.COUNTY_NBR,left,right)
																	AND right.field='CNTY_NAME', 
																	cnty_bus(left,right),left outer,lookup);


Prof_License_Mari.layouts.base cnty_mail(business_county_name L, county_names R) := transform
		self.ADDR_CNTY_2			:= IF(R.COUNTY_NAMES != '',R.COUNTY_NAMES,L.ADDR_CNTY_2);
		self := L;
	end;

	mail_county_name := JOIN(business_county_name, county_names,
																	TRIM(left.ADDR_CNTY_2,left,right)= TRIM(right.COUNTY_NBR,left,right)
																	AND right.field='CNTY_NAME', 
																	cnty_mail(left,right),left outer,lookup);

// ConvertCountyNames := OUTPUT(mail_county_name);

Prof_License_Mari.layouts.base		xform_reformat(Prof_License_Mari.layouts.base L) := TRANSFORM
self.ORIG_ISSUE_DTE		:= if(L.orig_issue_dte = '0   0000','17530101', L.orig_issue_dte);
self.EXPIRE_DTE				:= if(L.expire_dte = '0   0000','17530101', L.expire_dte);
self.CURR_ISSUE_DTE		:= if(L.curr_issue_dte = '0   0000','17530101', L.curr_issue_dte);

self.license_nbr 		:= if(regexfind('^[0-9]', trim(L.license_nbr)),
													stringlib.stringcleanspaces(ut.fnTrim2Upper(L.STD_LICENSE_TYPE)+ '0' + L.LICENSE_NBR),
															ut.fnTrim2Upper(L.LICENSE_NBR));

self.name_office		:= StringLib.StringFindReplace(L.name_office,'&AMP','&');
self.office_parse		:= if(trim(self.name_office) != '', L.office_parse,'');
self.name_mari_org	:= StringLib.StringFindReplace(L.name_mari_org,'&AMP','&');

error_addr := '(N/A|INVALID|MOVED  TO|SAME)';
self.addr_bus_ind		:= if(L.addr_bus_ind = '' and L.addr_addr1_1 != '' and L.addr_zip5_1 != '','B',L.addr_bus_ind);
self.addr_addr1_1		:= IF(REGEXFIND(error_addr, trim(L.addr_addr1_1)), '',L.addr_addr1_1);
self.addr_addr2_1		:= IF(REGEXFIND(error_addr, trim(L.addr_addr2_1)), '',L.addr_addr2_1);

self.addr_mail_ind	:= if(L.addr_mail_ind = '' and L.addr_addr1_2 != '' and L.addr_zip5_2 != '','H',L.addr_mail_ind);
self.addr_addr1_2		:= IF(REGEXFIND(error_addr, trim(L.addr_addr1_2)), '',L.addr_addr1_2);
self.addr_addr2_2		:= IF(REGEXFIND(error_addr, trim(L.addr_addr2_2)), '',L.addr_addr2_2);

self.provnote_2			:= If(trim(L.provnote_2) = 'LicenseMethod=E', 'LICENSED BY: EXAM',
													IF(trim(L.provnote_2) = 'LicenseMethod=R', 'LICENSED BY: RECIPROCITY',''
															));

self := L;

END;

ds_map := project(mail_county_name, xform_reformat(left));

return ds_map;

// output(ds_map, ,'~thor_data400::in::proflic_mari::s0826::refomat',__compressed__,overwrite);
END;
