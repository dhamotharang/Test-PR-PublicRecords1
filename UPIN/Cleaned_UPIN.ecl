import UPIN, lib_stringlib, Address;

UPIN.Layout_UPIN_common tcleaning(UPIN.Layout_UPIN L) := transform


string20 temp_PHYSICIAN_LNAME := stringlib.stringfilterout(L.PHYSICIAN_LAST_NAME, '0123456789');

string6 temp_PHYSICIAN_NAME_suffix := stringlib.stringfilterout(stringlib.stringfilterout(L.PHYSICIAN_NAME_suffix, '0123456789'), '\t\t');


string73 temp_Physician_Name := stringlib.StringToUpperCase(Address.CleanPersonlfm73(trim(trim(temp_PHYSICIAN_LNAME,left,right) + ', ' + 
																	                               trim(L.Physician_first_Name,left,right) + ' ' +
																					               trim(L.Physician_Middle_Name,left,right) + ' ' +
																								   trim(temp_PHYSICIAN_NAME_suffix,left,right),left,right)));
																								   
																								   
																								   
string182 clean_address := Address.CleanAddress182(' ', L.PHYSICIAN_LICENSE_STATE_CD + ' ' + L.BUSINESS_ZIP_CD);																								   
self.process_date := '20050701';
self.Date_First_Seen := '';
self.Date_Last_Seen  := '';
self.Date_Vendor_First_Reported := '';
self.Date_Vendor_Last_Reported  := '';
self.Physician_Clean_name_title := temp_Physician_Name[1..5];
self.Physician_Clean_fname      := temp_Physician_Name[6..25];
self.Physician_Clean_mname      := temp_Physician_Name[26..45];
self.Physician_Clean_lname      := temp_Physician_Name[46..65];
self.Physician_Clean_name_suffix := temp_Physician_Name[66..70];
self.Physician_Clean_name_score  := temp_Physician_Name[71..73];
self.physician_Clean_prim_range 		            := 		clean_address[1..10]				;
self.physician_Clean_predir     		:=		clean_address[11..12]				;
self.physician_Clean_prim_name			:= 		clean_address[13..40]				;
self.physician_Clean_addr_suffix		:= 		clean_address[41..44]				;
self.physician_Clean_postdir				:=		clean_address[45..46]				;
self.physician_Clean_unit_desig			:= 		clean_address[47..56]				;
self.physician_Clean_sec_range				:= 		clean_address[57..64]				;
self.physician_Clean_p_city_name			:= 		clean_address[65..89]				;
self.physician_Clean_v_city_name			:= 		clean_address[90..114]				;
self.physician_Clean_st					:= 		clean_address[115..116]			;
self.physician_Clean_zip					:=		clean_address[117..121]			;
self.physician_Clean_zip4					:=		clean_address[122..125]			;
self.physician_Clean_cart					:=		clean_address[126..129]			;
self.physician_Clean_cr_sort_sz			:=		clean_address[130]					;
self.physician_Clean_lot					:=		clean_address[131..134]			;
self.physician_Clean_lot_order				:=		clean_address[135]					;
self.physician_Clean_dpbc					:=		clean_address[136..137]			;
self.physician_Clean_chk_digit				:=		clean_address[138]					;
self.physician_Clean_record_type			:=		clean_address[139..140]			;
self.physician_Clean_ace_fips_st			:=		clean_address[141..142]			;
self.physician_Clean_fipscounty			:=		clean_address[143..145]			;
self.physician_Clean_geo_lat				:=		clean_address[146..155]			;
self.physician_Clean_geo_long				:=		clean_address[156..166]			;
self.physician_Clean_msa					:=		clean_address[167..170]			;
self.physician_Clean_geo_match				:=		clean_address[178]					;
self.physician_Clean_err_stat				:=		clean_address[179..182]		;
self.BUSINESS_ZIP_5              := L.BUSINESS_ZIP_CD[1..5];
self                             := L;

end;

Cleaned_UPIN_out := project(UPIN.File_UPIN_in, tcleaning(left));

//make specialty desciption available

UPIN.Layout_UPIN_common   tjoin(UPIN.Layout_UPIN_common L, UPIN.Layout_Spclty R) := transform

self.PHYSICIAN_PRIMARY_SPECIALTY_DESC := R.desc;
self := L;

end;

UPIN_joined := join(Cleaned_UPIN_out, UPIN.Decode_Spclty, left.PHYSICIAN_PRIMARY_SPECIALTY_CD = right.code,
               tjoin(left, right), many lookup);
			   
			   
export cleaned_UPIN := UPIN_joined;

