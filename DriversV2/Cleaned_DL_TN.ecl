import Drivers, Address, ut, lib_stringlib;

export Cleaned_DL_TN(string processDate, string fileDate) := function

	in_file := DriversV2.File_DL_TN_Update(fileDate);

	layout_out := drivers.Layout_TN_Full;
	
	layout_out mapClean(in_file l) := transform
		string73 tempName := stringlib.StringToUpperCase(if(trim(trim(l.orig_FIRST_NAME,left,right) + ' ' +
															trim(l.orig_LAST_NAME,left,right),left,right) <> '',
															Address.CleanPersonFML73(trim(trim(l.orig_FIRST_NAME,left,right)  + ' ' +
																					      trim(l.orig_MIDDLE_NAME,left,right) + ' ' +
																						  trim(l.orig_LAST_NAME,left,right)   + ' ' +
															                    	      trim(l.orig_NAME_SUFFIX,left,right),left,right)),
															''));
		
		self.clean_name_prefix     := tempName[1..5];
		self.clean_name_first      := tempName[6..25];
		self.clean_name_middle     := tempName[26..45];
		self.clean_name_last       := tempName[46..65];
		self.clean_name_suffix	   := tempName[66..70];
		self.clean_name_score      := tempName[71..73];
		self.clean_prim_range      := '';
		self.clean_predir 	       := '';
		self.clean_prim_name 	     := '';
		self.clean_addr_suffix     := '';
		self.clean_postdir 	       := '';
		self.clean_unit_desig 	   := '';
		self.clean_sec_range 	     := '';
		self.clean_p_city_name	   := '';
		self.clean_v_city_name	   := '';
		self.clean_st			         := '';
		self.clean_zip 		         := '';
		self.clean_zip4 		       := '';
		self.clean_cart 		       := '';
		self.clean_cr_sort_sz 	   := '';
		self.clean_lot 		         := '';
		self.clean_lot_order 	     := '';
		self.clean_dpbc 		       := '';
		self.clean_chk_digit 	     := '';
		self.clean_record_type	   := '';
		self.clean_ace_fips_st	   := '';
		self.clean_fipscounty 	   := '';
		self.clean_geo_lat 	       := '';
		self.clean_geo_long 	     := '';
		self.clean_msa 		         := '';
		self.clean_geo_blk         := '';
		self.clean_geo_match 	     := '';
		self.clean_err_stat 	     := '';	
		self.append_process_date   := lib_stringlib.stringlib.stringfilter(processDate,'0123456789');
		self.orig_LAST_NAME        := stringlib.StringToUpperCase(trim(l.orig_LAST_NAME,left,right));
		self.orig_FIRST_NAME       := stringlib.StringToUpperCase(trim(l.orig_FIRST_NAME,left,right));
		self.orig_MIDDLE_NAME      := stringlib.StringToUpperCase(trim(l.orig_MIDDLE_NAME,left,right));
		self.orig_STREET_ADDRESS_1 := stringlib.StringToUpperCase(trim(l.orig_STREET_ADDRESS_1,left,right));
		self.orig_STREET_ADDRESS_2 := stringlib.StringToUpperCase(trim(l.orig_STREET_ADDRESS_2,left,right));
		self.orig_CITY             := stringlib.StringToUpperCase(trim(l.orig_CITY,left,right));
		self.orig_STATE            := stringlib.StringToUpperCase(trim(l.orig_STATE,left,right));
		self.orig_ZIP_CODE         := trim(l.orig_ZIP_CODE,left,right);
		self.orig_DL_NUMBER        := stringlib.StringToUpperCase(trim(l.orig_DL_NUMBER,left,right));
		self.orig_DOB              := lib_stringlib.stringlib.stringfilter(l.orig_DOB,'0123456789');
		self.orig_LICENSE_TYPE     := stringlib.StringToUpperCase(trim(l.orig_LICENSE_TYPE,left,right));
		self.orig_SEX              := stringlib.StringToUpperCase(trim(l.orig_SEX,left,right));
		self.orig_HEIGHT           := lib_stringlib.stringlib.stringfilter(l.orig_HEIGHT,'0123456789');
		self.orig_WEIGHT           := stringlib.StringToUpperCase(trim(l.orig_WEIGHT,left,right));
		self.orig_EYE_COLOR        := stringlib.StringToUpperCase(trim(l.orig_EYE_COLOR,left,right));
		self.orig_HAIR_COLOR       := stringlib.StringToUpperCase(trim(l.orig_HAIR_COLOR,left,right));
		self.orig_RESTRICTIONS     := stringlib.StringToUpperCase(trim(l.orig_RESTRICTIONS,left,right));
		self.orig_ENDORSEMENTS     := stringlib.StringToUpperCase(trim(l.orig_ENDORSEMENTS,left,right));
		self.orig_EXPIRE_DATE      := lib_stringlib.stringlib.stringfilter(l.orig_EXPIRE_DATE,'0123456789');
		self.orig_ISSUE_DATE       := lib_stringlib.stringlib.stringfilter(l.orig_ISSUE_DATE,'0123456789');
		self.orig_NON_CDL_STATUS   := stringlib.StringToUpperCase(trim(l.orig_NON_CDL_STATUS,left,right));
		self.orig_CDL_STATUS       := stringlib.StringToUpperCase(trim(l.orig_CDL_STATUS,left,right));
		self                       := l;		
	end;

	Cleaned_TN_File := project(in_file, mapClean(left));
	
	return Cleaned_TN_File;
end;
