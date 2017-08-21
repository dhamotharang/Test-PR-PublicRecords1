

import address;

Fictitious_Business_Names.Layout_All_Clean CleanFBN(File_Out_AllFlat InputRecord) := transform
	string73 tempCCTName := 
	stringlib.StringToUpperCase(if(trim(InputRecord.CCT_fullname,left,right) <> '',
	   address.CleanPersonfml73(trim(InputRecord.CCT_fullname,left,right)) ,									
	'')
	);

	self.CCT1_Clean_title						:= if(trim(InputRecord.CCT_fullname,left,right) <> '' and tempCCTName[71..73]<='085' and regexfind(' & ',InputRecord.CCT_fullname)=false,Address.CleanPerson73(trim(InputRecord.CCT_fullname,left,right))[1..5],tempCCTName[1..5]);
	self.CCT1_Clean_fname						:= tempCCTName[6..25]			;
	self.CCT1_Clean_mname						:= tempCCTName[26..45]		;
	self.CCT1_Clean_lname						:= tempCCTName[46..65]		;
	self.CCT1_Clean_name_suffix	    := tempCCTName[66..70]		;
	self.CCT1_Clean_cleaning_score	:= tempCCTName[71..73]		;
/*
string73 tempCCTName2 := 
if(self.CCT1_Clean_cleaning_score<'085'and self.CCT1_Clean_cleaning_score!='' ,Address.CleanPerson73(trim(InputRecord.CCT_fullname,left,right)),'');
	self.CCT2_Clean_title			:= tempCCTName2[1..5] ;
	self.CCT2_Clean_fname			:= tempCCTName2[6..25];
	self.CCT2_Clean_mname			:= tempCCTName2[26..45];
	self.CCT2_Clean_lname			:= tempCCTName2[46..65];
	self.CCT2_Clean_name_suffix	    := tempCCTName2[66..70];
	self.CCT2_Clean_cleaning_score	:= tempCCTName2[71..73];
	
	string73 tempCCTName3 := 
												if(
												self.CCT2_Clean_cleaning_score<'085'and regexfind('&',InputRecord.CCT_fullname)=true ,
												Address.CleanPersonfml73(trim(InputRecord.CCT_fullname[1..StringLib.StringFind(InputRecord.CCT_fullname, '&',1)],left,right)+' '+trim(InputRecord.CCT_lastname,left,right)),
												 ''
												  );


	self.CCT3_Clean_title			:= tempCCTName3[1..5] ;
	self.CCT3_Clean_fname			:= tempCCTName3[6..25];
	self.CCT3_Clean_mname			:= tempCCTName3[26..45];
	self.CCT3_Clean_lname			:= tempCCTName3[46..65];
	self.CCT3_Clean_name_suffix	    := tempCCTName3[66..70];
	self.CCT3_Clean_cleaning_score	:= tempCCTName3[71..73];


	string73 tempCCTName4 := 
												if(
												regexfind('&',InputRecord.CCT_fullname)=true ,
												Address.CleanPersonfml73(trim(InputRecord.CCT_fullname[StringLib.StringFind(InputRecord.CCT_fullname, '&',1)+1..],left,right)),'');


	self.CCT4_Clean_title			:= tempCCTName4[1..5] ;
	self.CCT4_Clean_fname			:= tempCCTName4[6..25];
	self.CCT4_Clean_mname			:= tempCCTName4[26..45];
	self.CCT4_Clean_lname			:= tempCCTName4[46..65];
	self.CCT4_Clean_name_suffix	    := tempCCTName4[66..70];
	self.CCT4_Clean_cleaning_score	:= tempCCTName4[71..73];


	*/
	string182 tempCCTAddressReturn := stringlib.StringToUpperCase(
										if(InputRecord.ContactPersonAddress_S1 <> '' or
										   InputRecord.ContactPersonAddress_CY <> '' or
										   InputRecord.ContactPersonAddress_ST <> '' or
										   InputRecord.ContactPersonAddress_ZP <> '',
										   Address.CleanAddress182(
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
										   Address.CleanAddress182(
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

self.BusinessTelephone_clean  := address.CleanPhone(InputRecord.businesstelephone_number);
self.ContactTelephone_clean 	:= address.CleanPhone(InputRecord.telephone_number);
self.businessname							:= stringlib.StringToUpperCase(InputRecord.businessname);
self := InputRecord;	
end;

	

export File_All_Clean := Project(File_Out_AllFlat,CleanFBN(left));
