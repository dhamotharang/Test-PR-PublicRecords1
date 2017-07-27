import lib_AddrClean;
file_in := InfoUSA.File_IDEXEC_in;

//#################remove html encoded charcters to latin################



infousa.Layout_IDEXEC_in xform_cleanExecNames(file_in le) := transform
self.exec_full_name := map(regexfind('&#8217;',le.exec_full_name)=true => regexreplace('&#8217;',le.exec_full_name,'\''),
													 regexfind('&#8211;',le.exec_full_name)=true => regexreplace('&#8211;',le.exec_full_name,'-'),
//													 regexfind('&#269;',le.exec_full_name)=true => regexreplace('&#269;',le.exec_full_name,'?'),
//													 regexfind('&#287;',le.exec_full_name)=true => regexreplace('&#287;',le.exec_full_name,'?'),	
//													 regexfind('&#305;',le.exec_full_name)=true => regexreplace('&#305;',le.exec_full_name,'?'),	
													le.exec_full_name	
														) ;
self := le;
end;

file_out := Project(file_in,xform_cleanExecNames(left));



InfoUSA.Layout_Cleaned_IDEXEC_file xform_clean(file_out InputRecord) := transform
self.Firm_Name := stringlib.StringToUpperCase(InputRecord.Firm_Name);
string73 tempExecName := 
	stringlib.StringToUpperCase(if(trim(InputRecord.Exec_full_name,left,right) <> '',
	   lib_AddrClean.AddrCleanLib.CleanPersonfml73(trim(InputRecord.Exec_full_name,left,right)) ,									
	'')
	);

	self.Exec_Clean_title						:= tempExecName[1..5]			;
	self.Exec_Clean_fname						:= tempExecName[6..25]			;
	self.Exec_Clean_mname						:= tempExecName[26..45]			;
	self.Exec_Clean_lname						:= tempExecName[46..65]			;
	self.Exec_Clean_name_suffix	    := tempExecName[66..70]			;
	self.Exec_Clean_cleaning_score	:= tempExecName[71..73]			;

string182 tempFirmAddressReturn := stringlib.StringToUpperCase(
										if(InputRecord.loc_address_1 <> '' or
										   InputRecord.loc_address_2 <> '' ,
											 
											 if(trim(InputRecord.loc_address_3,left,right) ='',
											 lib_AddrClean.AddrCleanLib.CleanAddress182(trim(InputRecord.loc_address_1,left,right),trim(InputRecord.loc_address_2,left,right)),
 											 lib_AddrClean.AddrCleanLib.CleanAddress182((trim(InputRecord.loc_address_1,left,right)+','+ trim(InputRecord.loc_address_2,left,right)),trim(InputRecord.loc_address_3,left,right))
												 ),''));							 

self.Firm_Address_Clean_prim_range := 		tempFirmAddressReturn[1..10]			;
self.Firm_Address_Clean_predir     :=			tempFirmAddressReturn[11..12]			;
self.Firm_Address_Clean_prim_name	 := 		tempFirmAddressReturn[13..40]			;
self.Firm_Address_Clean_addr_suffix:= 		tempFirmAddressReturn[41..44]			;
self.Firm_Address_Clean_postdir		 :=			tempFirmAddressReturn[45..46]			;
self.Firm_Address_Clean_unit_desig	:= 		tempFirmAddressReturn[47..56]			;
self.Firm_Address_Clean_sec_range		:= 		tempFirmAddressReturn[57..64]			;
self.Firm_Address_Clean_p_city_name	:= 		tempFirmAddressReturn[65..89]			;
self.Firm_Address_Clean_v_city_name	:= 		tempFirmAddressReturn[90..114]			;
self.Firm_Address_Clean_st					:= 		tempFirmAddressReturn[115..116]			;
self.Firm_Address_Clean_zip					:=		tempFirmAddressReturn[117..121]			;
self.Firm_Address_Clean_zip4				:=		tempFirmAddressReturn[122..125]			;
self.Firm_Address_Clean_cart				:=		tempFirmAddressReturn[126..129]			;
self.Firm_Address_Clean_cr_sort_sz	:=		tempFirmAddressReturn[130]			;
self.Firm_Address_Clean_lot					:=		tempFirmAddressReturn[131..134]			;
self.Firm_Address_Clean_lot_order		:=		tempFirmAddressReturn[135]			;
self.Firm_Address_Clean_dpbc				:=		tempFirmAddressReturn[136..137]			;
self.Firm_Address_Clean_chk_digit		:=		tempFirmAddressReturn[138]			;
self.Firm_Address_Clean_record_type	:=		tempFirmAddressReturn[139..140]			;
self.Firm_Address_Clean_ace_fips_st	:=		tempFirmAddressReturn[141..142]			;
self.Firm_Address_Clean_fipscounty	:=		tempFirmAddressReturn[143..145]			;
self.Firm_Address_Clean_geo_lat			:=		tempFirmAddressReturn[146..155]			;
self.Firm_Address_Clean_geo_long		:=		tempFirmAddressReturn[156..166]			;
self.Firm_Address_Clean_msa					:=		tempFirmAddressReturn[167..170]			;
self.Firm_Address_Clean_geo_match		:=		tempFirmAddressReturn[178]			;
self.Firm_Address_Clean_err_stat		:=		tempFirmAddressReturn[179..182]			;
self.IDEXEC_key							:= InputRecord.exec_id+InputRecord.firm_id+hash64(trim(InputRecord.Firm_name,left,right),trim(InputRecord.Exec_full_name,left,right));
self := InputRecord																				;
end;

cleaned_file := Project(file_out,xform_clean(left));
export Cleaned_IDEXEC_file := cleaned_file(trim(loc_country_name,left,right)='United States');