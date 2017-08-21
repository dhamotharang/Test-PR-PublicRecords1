import Drivers, Address, ut, lib_stringlib;

export Cleaned_DL_WY(string processDate, string fileDate) := function

	in_file := DriversV2.File_DL_WY_Update(fileDate);

	layout_out := drivers.Layout_WY_Full;

	layout_out mapClean(in_file l) := transform
		string73 tempName := stringlib.StringToUpperCase(if(trim(trim(l.orig_FIRST_NAME,left,right) + ' ' +
										                         trim(l.orig_LAST_NAME,left,right),left,right) <> '',
															Address.CleanPersonFML73(trim(trim(l.orig_FIRST_NAME,left,right)  + ' ' +
																				          trim(l.orig_MIDDLE_NAME,left,right) + ' ' +
																						  trim(l.orig_LAST_NAME,left,right),left,right)),
															''));
		string182 tempAddress1 := stringlib.StringToUpperCase(if(trim(l.mailing_STREET_ADDR_1,left,right) <> '' or 
																 trim(l.mailing_CITY_1,left,right)  <> '' or
																 trim(l.mailing_STATE_1,left,right) <> '' or
																 trim(l.mailing_ZIP_CODE_1,left,right)   <> '',
																 Address.CleanAddress182(trim(l.mailing_STREET_ADDR_1,left,right),
																    					 trim(trim(l.mailing_CITY_1,left,right) + ', ' +
															        					      trim(l.mailing_STATE_1,left,right) + ' ' +
																    						  stringlib.stringfilter(l.mailing_ZIP_CODE_1,'0123456789'),left,right)),
																 ''));
		string182 tempAddress2 := stringlib.StringToUpperCase(if(trim(l.orig_STREET_ADDR_2,left,right) <> '' or 
																 trim(l.orig_CITY_2,left,right)  <> '' or
																 trim(l.orig_STATE_2,left,right) <> '' or
																 trim(l.orig_ZIP_CODE_2,left,right)   <> '',
																 Address.CleanAddress182(trim(l.orig_STREET_ADDR_2,left,right),
																 						 trim(trim(l.orig_CITY_2,left,right) + ', ' +
																                              trim(l.orig_STATE_2,left,right) + ' ' +
																							  stringlib.stringfilter(l.orig_ZIP_CODE_2,'0123456789'),left,right)),
																 ''));

		self.clean_name_prefix     := tempName[1..5];
		self.clean_name_first      := tempName[6..25];
		self.clean_name_middle     := tempName[26..45];
		self.clean_name_last       := tempName[46..65];
		self.clean_name_suffix	   := tempName[66..70];
		self.clean_name_score      := tempName[71..73];
		self.clean_prim_range_1    := tempAddress1[1..10];
		self.clean_predir_1 	   := tempAddress1[11..12];
		self.clean_prim_name_1 	   := tempAddress1[13..40];
		self.clean_addr_suffix_1   := tempAddress1[41..44];
		self.clean_postdir_1 	   := tempAddress1[45..46];
		self.clean_unit_desig_1    := tempAddress1[47..56];
		self.clean_sec_range_1 	   := tempAddress1[57..64];
		self.clean_p_city_name_1   := tempAddress1[65..89];
		self.clean_v_city_name_1   := tempAddress1[90..114];
		self.clean_st_1			   := if(tempAddress1[115..116] = '',
										 ziplib.ZipToState2(tempAddress1[117..121]),
															tempAddress1[115..116]);
		self.clean_zip_1 		   := tempAddress1[117..121];
		self.clean_zip4_1 		   := tempAddress1[122..125];
		self.clean_cart_1 		   := tempAddress1[126..129];
		self.clean_cr_sort_sz_1    := tempAddress1[130];
		self.clean_lot_1 		   := tempAddress1[131..134];
		self.clean_lot_order_1 	   := tempAddress1[135];
		self.clean_dpbc_1 		   := tempAddress1[136..137];
		self.clean_chk_digit_1 	   := tempAddress1[138];
		self.clean_record_type_1   := tempAddress1[139..140];
		self.clean_ace_fips_st_1   := tempAddress1[141..142];
		self.clean_fipscounty_1    := tempAddress1[143..145];
		self.clean_geo_lat_1 	   := tempAddress1[146..155];
		self.clean_geo_long_1 	   := tempAddress1[156..166];
		self.clean_msa_1 		   := tempAddress1[167..170];
		self.clean_geo_blk_1       := tempAddress1[171..177];
		self.clean_geo_match_1 	   := tempAddress1[178];
		self.clean_err_stat_1 	   := tempAddress1[179..182];			
		self.clean_prim_range_2    := tempAddress2[1..10];
		self.clean_predir_2 	   := tempAddress2[11..12];
		self.clean_prim_name_2 	   := tempAddress2[13..40];
		self.clean_addr_suffix_2   := tempAddress2[41..44];
		self.clean_postdir_2 	   := tempAddress2[45..46];
		self.clean_unit_desig_2    := tempAddress2[47..56];
		self.clean_sec_range_2 	   := tempAddress2[57..64];
		self.clean_p_city_name_2   := tempAddress2[65..89];
		self.clean_v_city_name_2   := tempAddress2[90..114];
		self.clean_st_2			   := if(tempAddress2[115..116] = '',
										 ziplib.ZipToState2(tempAddress2[117..121]),
															tempAddress2[115..116]);
		self.clean_zip_2 		   := tempAddress2[117..121];
		self.clean_zip4_2 		   := tempAddress2[122..125];
		self.clean_cart_2 		   := tempAddress2[126..129];
		self.clean_cr_sort_sz_2    := tempAddress2[130];
		self.clean_lot_2 		   := tempAddress2[131..134];
		self.clean_lot_order_2 	   := tempAddress2[135];
		self.clean_dpbc_2 		   := tempAddress2[136..137];
		self.clean_chk_digit_2 	   := tempAddress2[138];
		self.clean_record_type_2   := tempAddress2[139..140];
		self.clean_ace_fips_st_2   := tempAddress2[141..142];
		self.clean_fipscounty_2    := tempAddress2[143..145];
		self.clean_geo_lat_2 	   := tempAddress2[146..155];
		self.clean_geo_long_2 	   := tempAddress2[156..166];
		self.clean_msa_2 		   := tempAddress2[167..170];
		self.clean_geo_blk_2       := tempAddress2[171..177];
		self.clean_geo_match_2 	   := tempAddress2[178];
		self.clean_err_stat_2 	   := tempAddress2[179..182];			
		self.append_process_date   := lib_stringlib.stringlib.stringfilter(processDate,'0123456789');
		self.orig_LAST_NAME        := stringlib.StringToUpperCase(trim(l.orig_LAST_NAME,left,right));
		self.orig_FIRST_NAME       := stringlib.StringToUpperCase(trim(l.orig_FIRST_NAME,left,right));
		self.orig_MIDDLE_NAME      := stringlib.StringToUpperCase(trim(l.orig_MIDDLE_NAME,left,right));
		self.orig_STREET_ADDRESS_1 := stringlib.StringToUpperCase(trim(l.mailing_STREET_ADDR_1,left,right));
		self.orig_CITY_1           := stringlib.StringToUpperCase(trim(l.mailing_CITY_1,left,right));
		self.orig_STATE_1          := stringlib.StringToUpperCase(trim(l.mailing_STATE_1,left,right));
		self.orig_ZIP_CODE_1       := trim(l.mailing_ZIP_CODE_1,left,right);
		self.orig_DOB              := lib_stringlib.stringlib.stringfilter(l.orig_DOB,'0123456789');
		self.orig_STREET_ADDRESS_2 := stringlib.StringToUpperCase(trim(l.orig_STREET_ADDR_2,left,right));
		self.orig_CITY_2           := stringlib.StringToUpperCase(trim(l.orig_CITY_2,left,right));
		self.orig_STATE_2          := stringlib.StringToUpperCase(trim(l.orig_STATE_2,left,right));
		self.orig_ZIP_CODE_2       := trim(l.orig_ZIP_CODE_2,left,right);
		self.orig_DL_NUMBER        := stringlib.StringToUpperCase(trim(l.orig_DL_NUMBER,left,right));
		self.orig_CODE_1           := stringlib.StringToUpperCase(trim(l.orig_CODE_1,left,right));
		self.orig_CODE_2           := stringlib.StringToUpperCase(trim(l.orig_CODE_2,left,right));
		self.orig_CODE_3           := stringlib.StringToUpperCase(trim(l.orig_CODE_3,left,right));
		self.orig_CODE_4           := stringlib.StringToUpperCase(trim(l.orig_CODE_4,left,right));
		self.orig_CODE_5           := stringlib.StringToUpperCase(trim(l.orig_CODE_5,left,right));
		self.orig_CODE_6           := stringlib.StringToUpperCase(trim(l.orig_CODE_6,left,right));
		self.orig_CODE_7           := stringlib.StringToUpperCase(trim(l.orig_CODE_7,left,right));
		self.orig_CODE_8           := stringlib.StringToUpperCase(trim(l.orig_CODE_8,left,right));
		self.orig_EXPIRE_DATE      := lib_stringlib.stringlib.stringfilter(l.orig_EXPIRE_DATE,'0123456789');
		self.orig_ISSUE_DATE       := lib_stringlib.stringlib.stringfilter(l.orig_ISSUE_DATE,'0123456789');
		self                       := l;		
	end;

	Cleaned_WY_File := project(in_file, mapClean(left));
	
	return Cleaned_WY_File;
end;