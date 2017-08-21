import address, Business_Header;

file_in := Fictitious_Business_Names.File_Clean_ContactNames;

Layout_clean_ContactNames_mod := record

string100 clean_company_name;

string100 clean_address_split;

string73 clean_cleaned_name;

string73 clean_cleaned_name_2;

recordof(Fictitious_Business_Names.File_Out_AllFlat_Rollup);

end;


Layout_clean_ContactNames_mod xform(file_in l) := Transform
self.clean_company_name := if(trim(l.clean_cleaned_name,left,right)!='' and trim(l.clean_cleaned_name_2,left,right)!='','',l.clean_company_name);
self := l;
end;

file_out_name := Project(file_in,xform(left));
file_out_name_businessname_notblank := file_out_name(trim(businessname,left,right)!='');
//##########################Clean address First#############################

Layout_clean_Addresses := record
string100 clean_company_name;

//string100 clean_address_split;

string73 clean_cleaned_name;

string73 clean_cleaned_name_2;

recordof(Fictitious_Business_Names.File_Out_AllFlat_Rollup);

string10  	CCT_Address_Clean_prim_range			;
string2  		CCT_Address_Clean_predir					;
string28 		CCT_Address_Clean_prim_name				;
string4   	CCT_Address_Clean_addr_suffix			;
string2  		CCT_Address_Clean_postdir					;
string10  	CCT_Address_Clean_unit_desig			;
string8   	CCT_Address_Clean_sec_range				;
string25 		CCT_Address_Clean_p_city_name			;
string25 		CCT_Address_Clean_v_city_name			;
string2  		CCT_Address_Clean_st							;
string5  		CCT_Address_Clean_zip							;
string4  		CCT_Address_Clean_zip4						;
string4  		CCT_Address_Clean_cart						;
string1  		CCT_Address_Clean_cr_sort_sz			;
string4   	CCT_Address_Clean_lot							;
string1  		CCT_Address_Clean_lot_order				;
string2  		CCT_Address_Clean_dpbc						;
string1  		CCT_Address_Clean_chk_digit				;
string2  		CCT_Address_Clean_record_type			;
string2  	CCT_Address_Clean_ace_fips_st				;
string3  	CCT_Address_Clean_fipscounty				;
string10 	CCT_Address_Clean_geo_lat						;
string11 	CCT_Address_Clean_geo_long					;
string4 	CCT_Address_Clean_msa								;
string7  	CCT_Address_Clean_geo_match					;
string4  	CCT_Address_Clean_err_stat					;	

string10  	Business_Address_Clean_prim_range			;
string2 	 	Business_Address_Clean_predir					;
string28 		Business_Address_Clean_prim_name			;
string4   	Business_Address_Clean_addr_suffix		;
string2  		Business_Address_Clean_postdir				;
string10  	Business_Address_Clean_unit_desig			;
string8   	Business_Address_Clean_sec_range			;
string25 		Business_Address_Clean_p_city_name		;
string25 		Business_Address_Clean_v_city_name		;
string2  		Business_Address_Clean_st							;
string5  		Business_Address_Clean_zip						;
string4  		Business_Address_Clean_zip4						;
string4  		Business_Address_Clean_cart						;
string1  		Business_Address_Clean_cr_sort_sz			;
string4   	Business_Address_Clean_lot						;
string1  		Business_Address_Clean_lot_order			;
string2 	 	Business_Address_Clean_dpbc						;
string1  		Business_Address_Clean_chk_digit			;
string2 	 	Business_Address_Clean_record_type		;
string2  		Business_Address_Clean_ace_fips_st		;
string3  		Business_Address_Clean_fipscounty			;
string10 		Business_Address_Clean_geo_lat				;
string11 		Business_Address_Clean_geo_long				;
string4 		Business_Address_Clean_msa						;
string7  		Business_Address_Clean_geo_match			;
string4  		Business_Address_Clean_err_stat				;	

string10 BusinessTelephone_clean									;
string10 ContactTelephone_clean										;
end;


Layout_clean_Addresses xform1(file_out_name_businessname_notblank InputRecord) := Transform
	string182 tempCCTAddressReturn := stringlib.StringToUpperCase(
										if(InputRecord.ContactPersonAddress_S1 <> '' or
										   InputRecord.ContactPersonAddress_CY <> '' or
										   InputRecord.ContactPersonAddress_ST <> '' or
										   InputRecord.ContactPersonAddress_ZP <> '',
										   address.CleanAddress182(
										   trim(InputRecord.ContactPersonAddress_S1,left,right),
										   trim(trim(InputRecord.ContactPersonAddress_CY,left,right) + ', ' +
										   trim(InputRecord.ContactPersonAddress_ST,left,right) + ' ' +
										   trim(InputRecord.ContactPersonAddress_ZP,left,right),left,right)),
																							 ''));

	string182 tempBusinessAddressReturn := stringlib.StringToUpperCase(
										if(InputRecord.BusinessAddress_S1 <> '' or
										   InputRecord.BusinessAddress_CY <> '' or
										   InputRecord.BusinessAddress_ST <> '' or
										   InputRecord.BusinessAddress_ZP <> '',
										   address.CleanAddress182(
										   trim(InputRecord.BusinessAddress_S1,left,right),
										   trim(trim(InputRecord.BusinessAddress_CY,left,right) + ', ' +
										   trim(InputRecord.BusinessAddress_ST,left,right) + ' ' +
										   trim(InputRecord.BusinessAddress_ZP,left,right),left,right)),
''));


	self.CCT_Address_Clean_prim_range   := 			tempCCTAddressReturn[1..10];
	self.CCT_Address_Clean_predir 	    := 			tempCCTAddressReturn[11..12];
	self.CCT_Address_Clean_prim_name 	:= 			tempCCTAddressReturn[13..40];
	self.CCT_Address_Clean_addr_suffix  := 			tempCCTAddressReturn[41..44];
	self.CCT_Address_Clean_postdir 		:=			tempCCTAddressReturn[45..46];
	self.CCT_Address_Clean_unit_desig 	:= 			tempCCTAddressReturn[47..56];
	self.CCT_Address_Clean_sec_range 	:= 			tempCCTAddressReturn[57..64];
	self.CCT_Address_Clean_p_city_name	:=			tempCCTAddressReturn[65..89];
	self.CCT_Address_Clean_v_city_name	:= 			tempCCTAddressReturn[90..114];
	self.CCT_Address_Clean_st 			:= 			tempCCTAddressReturn[115..116];
	self.CCT_Address_Clean_zip 			:= 			tempCCTAddressReturn[117..121];
	self.CCT_Address_Clean_zip4 		:=			tempCCTAddressReturn[122..125];
	self.CCT_Address_Clean_cart 		:= 			tempCCTAddressReturn[126..129];
	self.CCT_Address_Clean_cr_sort_sz 	:=			tempCCTAddressReturn[130];
	self.CCT_Address_Clean_lot 			:= 			tempCCTAddressReturn[131..134];
	self.CCT_Address_Clean_lot_order 	:= 			tempCCTAddressReturn[135];
	self.CCT_Address_Clean_dpbc 		:=			tempCCTAddressReturn[136..137];
	self.CCT_Address_Clean_chk_digit 	:=			tempCCTAddressReturn[138];
	self.CCT_Address_Clean_record_type	:= 			tempCCTAddressReturn[139..140];
	self.CCT_Address_Clean_ace_fips_st	:=			tempCCTAddressReturn[141..142];
	self.CCT_Address_Clean_fipscounty 	:= 			tempCCTAddressReturn[143..145];
	self.CCT_Address_Clean_geo_lat 		:= 			tempCCTAddressReturn[146..155];
	self.CCT_Address_Clean_geo_long 	:= 			tempCCTAddressReturn[156..166];
	self.CCT_Address_Clean_msa 			:= 			tempCCTAddressReturn[167..170];
	self.CCT_Address_Clean_geo_match 	:=			tempCCTAddressReturn[178];
	self.CCT_Address_Clean_err_stat 	:= 			tempCCTAddressReturn[179..182];
	
	self.Business_Address_Clean_prim_range   := 			tempBusinessAddressReturn[1..10];
	self.Business_Address_Clean_predir 	     := 		    tempBusinessAddressReturn[11..12];
	self.Business_Address_Clean_prim_name 	 := 			tempBusinessAddressReturn[13..40];
	self.Business_Address_Clean_addr_suffix  := 			tempBusinessAddressReturn[41..44];
	self.Business_Address_Clean_postdir 	 := 			tempBusinessAddressReturn[45..46];
	self.Business_Address_Clean_unit_desig 	 := 			tempBusinessAddressReturn[47..56];
	self.Business_Address_Clean_sec_range 	 := 			tempBusinessAddressReturn[57..64];
	self.Business_Address_Clean_p_city_name	 :=			    tempBusinessAddressReturn[65..89];
	self.Business_Address_Clean_v_city_name	 := 			tempBusinessAddressReturn[90..114];
	self.Business_Address_Clean_st 			 := 			tempBusinessAddressReturn[115..116];
	self.Business_Address_Clean_zip 		 := 			tempBusinessAddressReturn[117..121];
	self.Business_Address_Clean_zip4 		 :=			    tempBusinessAddressReturn[122..125];
	self.Business_Address_Clean_cart 		 := 			tempBusinessAddressReturn[126..129];
	self.Business_Address_Clean_cr_sort_sz 	 :=			    tempBusinessAddressReturn[130];
	self.Business_Address_Clean_lot 		 := 			tempBusinessAddressReturn[131..134]; 
	self.Business_Address_Clean_lot_order 	 := 			tempBusinessAddressReturn[135];
	self.Business_Address_Clean_dpbc 		 :=			    tempBusinessAddressReturn[136..137];
	self.Business_Address_Clean_chk_digit 	 :=			    tempBusinessAddressReturn[138];
	self.Business_Address_Clean_record_type	 := 			tempBusinessAddressReturn[139..140];
	self.Business_Address_Clean_ace_fips_st	 :=			    tempBusinessAddressReturn[141..142];
	self.Business_Address_Clean_fipscounty 	 := 			tempBusinessAddressReturn[143..145];
	self.Business_Address_Clean_geo_lat 	 := 			tempBusinessAddressReturn[146..155];
	self.Business_Address_Clean_geo_long 	 := 			tempBusinessAddressReturn[156..166];
	self.Business_Address_Clean_msa 		 := 			tempBusinessAddressReturn[167..170];
	self.Business_Address_Clean_geo_match 	 :=			    tempBusinessAddressReturn[178];
	self.Business_Address_Clean_err_stat 	 := 			tempBusinessAddressReturn[179..182];

self.BusinessTelephone_clean  := address.CleanPhone(trim(InputRecord.BusinessTelephone_AreaCode) + trim(InputRecord.businesstelephone_number));
self.ContactTelephone_clean 	:= address.CleanPhone(trim(InputRecord.Telephone_AreaCode) + trim(InputRecord.telephone_number));
self.businessname							:= stringlib.StringToUpperCase(InputRecord.businessname);
self := InputRecord;	

end;

export File_Clean_NameAddress := Project(file_out_name_businessname_notblank,xform1(left)):persist('~thor_data400::persist::FBN_Clean_file');
/*
//#########################Normalize the file##################################

Layout_Normalize := record
unsigned1		name_count;
string100 clean_company_name;
string73 clean_name;
recordof(Fictitious_Business_Names.File_Out_AllFlat_Rollup);
string10  	CCT_Address_Clean_prim_range			;
string2  		CCT_Address_Clean_predir					;
string28 		CCT_Address_Clean_prim_name				;
string4   	CCT_Address_Clean_addr_suffix			;
string2  		CCT_Address_Clean_postdir					;
string10  	CCT_Address_Clean_unit_desig			;
string8   	CCT_Address_Clean_sec_range				;
string25 		CCT_Address_Clean_p_city_name			;
string25 		CCT_Address_Clean_v_city_name			;
string2  		CCT_Address_Clean_st							;
string5  		CCT_Address_Clean_zip							;
string4  		CCT_Address_Clean_zip4						;
string4  		CCT_Address_Clean_cart						;
string1  		CCT_Address_Clean_cr_sort_sz			;
string4   	CCT_Address_Clean_lot							;
string1  		CCT_Address_Clean_lot_order				;
string2  		CCT_Address_Clean_dpbc						;
string1  		CCT_Address_Clean_chk_digit				;
string2  		CCT_Address_Clean_record_type			;
string2  	CCT_Address_Clean_ace_fips_st				;
string3  	CCT_Address_Clean_fipscounty				;
string10 	CCT_Address_Clean_geo_lat						;
string11 	CCT_Address_Clean_geo_long					;
string4 	CCT_Address_Clean_msa								;
string7  	CCT_Address_Clean_geo_match					;
string4  	CCT_Address_Clean_err_stat					;	

string10  	Business_Address_Clean_prim_range			;
string2 	 	Business_Address_Clean_predir					;
string28 		Business_Address_Clean_prim_name			;
string4   	Business_Address_Clean_addr_suffix		;
string2  		Business_Address_Clean_postdir				;
string10  	Business_Address_Clean_unit_desig			;
string8   	Business_Address_Clean_sec_range			;
string25 		Business_Address_Clean_p_city_name		;
string25 		Business_Address_Clean_v_city_name		;
string2  		Business_Address_Clean_st							;
string5  		Business_Address_Clean_zip						;
string4  		Business_Address_Clean_zip4						;
string4  		Business_Address_Clean_cart						;
string1  		Business_Address_Clean_cr_sort_sz			;
string4   	Business_Address_Clean_lot						;
string1  		Business_Address_Clean_lot_order			;
string2 	 	Business_Address_Clean_dpbc						;
string1  		Business_Address_Clean_chk_digit			;
string2 	 	Business_Address_Clean_record_type		;
string2  		Business_Address_Clean_ace_fips_st		;
string3  		Business_Address_Clean_fipscounty			;
string10 		Business_Address_Clean_geo_lat				;
string11 		Business_Address_Clean_geo_long				;
string4 		Business_Address_Clean_msa						;
string7  		Business_Address_Clean_geo_match			;
string4  		Business_Address_Clean_err_stat				;	

string10 BusinessTelephone_clean									;
string10 ContactTelephone_clean										;

end;

file_for_normalize := file_out_clean_addresses(trim(clean_cleaned_name_2,left,right)!='');

Layout_Normalize norm1(file_out_clean_addresses l,unsigned1 cnt) := Transform
self.name_count := cnt;
self.clean_name := choose(cnt,l.clean_cleaned_name,l.clean_cleaned_name_2);
self := l;
end;

file_out_normalize := normalize(file_out_clean_addresses,2,norm1(left,counter));
file_out_normalize_remove_blank_busi := file_out_normalize(trim(businessname,left,right)!='');
//###################break clean name################################

Layout_after_clean := record
unsigned1		name_count;
string100 clean_company_name								;
//string100 clean_name;
string5   			CCT_Clean_title							;
string20 	 			CCT_Clean_fname							;
string20  			CCT_Clean_mname							;
string20 				CCT_Clean_lname							;
string5  		 		CCT_Clean_name_suffix 			;
string3     		CCT_Clean_cleaning_score 	  ;
recordof(Fictitious_Business_Names.File_Out_AllFlat_Rollup);
string10  	CCT_Address_Clean_prim_range			;
string2  		CCT_Address_Clean_predir					;
string28 		CCT_Address_Clean_prim_name				;
string4   	CCT_Address_Clean_addr_suffix			;
string2  		CCT_Address_Clean_postdir					;
string10  	CCT_Address_Clean_unit_desig			;
string8   	CCT_Address_Clean_sec_range				;
string25 		CCT_Address_Clean_p_city_name			;
string25 		CCT_Address_Clean_v_city_name			;
string2  		CCT_Address_Clean_st							;
string5  		CCT_Address_Clean_zip							;
string4  		CCT_Address_Clean_zip4						;
string4  		CCT_Address_Clean_cart						;
string1  		CCT_Address_Clean_cr_sort_sz			;
string4   	CCT_Address_Clean_lot							;
string1  		CCT_Address_Clean_lot_order				;
string2  		CCT_Address_Clean_dpbc						;
string1  		CCT_Address_Clean_chk_digit				;
string2  		CCT_Address_Clean_record_type			;
string2  	CCT_Address_Clean_ace_fips_st				;
string3  	CCT_Address_Clean_fipscounty				;
string10 	CCT_Address_Clean_geo_lat						;
string11 	CCT_Address_Clean_geo_long					;
string4 	CCT_Address_Clean_msa								;
string7  	CCT_Address_Clean_geo_match					;
string4  	CCT_Address_Clean_err_stat					;	

string10  	Business_Address_Clean_prim_range			;
string2 	 	Business_Address_Clean_predir					;
string28 		Business_Address_Clean_prim_name			;
string4   	Business_Address_Clean_addr_suffix		;
string2  		Business_Address_Clean_postdir				;
string10  	Business_Address_Clean_unit_desig			;
string8   	Business_Address_Clean_sec_range			;
string25 		Business_Address_Clean_p_city_name		;
string25 		Business_Address_Clean_v_city_name		;
string2  		Business_Address_Clean_st							;
string5  		Business_Address_Clean_zip						;
string4  		Business_Address_Clean_zip4						;
string4  		Business_Address_Clean_cart						;
string1  		Business_Address_Clean_cr_sort_sz			;
string4   	Business_Address_Clean_lot						;
string1  		Business_Address_Clean_lot_order			;
string2 	 	Business_Address_Clean_dpbc						;
string1  		Business_Address_Clean_chk_digit			;
string2 	 	Business_Address_Clean_record_type		;
string2  		Business_Address_Clean_ace_fips_st		;
string3  		Business_Address_Clean_fipscounty			;
string10 		Business_Address_Clean_geo_lat				;
string11 		Business_Address_Clean_geo_long				;
string4 		Business_Address_Clean_msa						;
string7  		Business_Address_Clean_geo_match			;
string4  		Business_Address_Clean_err_stat				;	

string10 BusinessTelephone_clean									;
string10 ContactTelephone_clean										;

end;

Layout_after_clean xform2(file_out_normalize_remove_blank_busi le) := Transform
	self.CCT_Clean_title						:= le.clean_name[1..5]			;
	self.CCT_Clean_fname						:= le.clean_name[6..25]			;
	self.CCT_Clean_mname						:= le.clean_name[26..45]		;
	self.CCT_Clean_lname						:= le.clean_name[46..65]		;
	self.CCT_Clean_name_suffix	    := le.clean_name[66..70]		;
	self.CCT_Clean_cleaning_score		:= le.clean_name[71..73]		;
  self := le;
	end;

file_out_norm :=  Project(file_out_normalize_remove_blank_busi,xform2(left));

export File_Flat_Rollup_CleanName_Address := file_out_norm:persist('~thor_data400::persist::normalized_businessname_not_blank');
	

output(File_Flat_Rollup_CleanName_Address)
*/