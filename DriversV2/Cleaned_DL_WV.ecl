import Drivers, Address, ut, lib_stringlib;

export Cleaned_DL_WV(string processDate, string fileDate) := function

	in_file := DriversV2.File_DL_WV_Update(fileDate);

	layout_out := drivers.Layout_WV_Full;

	layout_out mapClean(in_file l) := transform
		string73 tempName := stringlib.StringToUpperCase(if(trim(trim(l.orig_FName,left,right) + ' ' +
															trim(l.orig_LName,left,right),left,right) <> '',
															Address.CleanPersonFML73(trim(trim(l.orig_FName,left,right) + ' ' +	
																				          trim(l.orig_MName,left,right) + ' ' +
																				          trim(l.orig_LName,left,right) + ' ' +
																				          trim(l.orig_NameSuf,left,right),left,right)),
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
		self.clean_sec_range 	     :='';
		self.clean_p_city_name	   := '';
		self.clean_v_city_name	   :='';
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
		self.orig_DLNum            := stringlib.StringToUpperCase(trim(l.orig_DLNum,left,right));
		self.orig_LName            := stringlib.StringToUpperCase(trim(l.orig_LName,left,right));
		self.orig_FName            := stringlib.StringToUpperCase(trim(l.orig_FName,left,right));
		self.orig_MName            := stringlib.StringToUpperCase(trim(l.orig_MName,left,right));
		self.orig_NameSuf          := stringlib.StringToUpperCase(trim(l.orig_NameSuf,left,right));
		self.orig_DOB              := lib_stringlib.stringlib.stringfilter(l.orig_DOB,'0123456789');
		self.orig_Sex              := stringlib.StringToUpperCase(trim(l.orig_Sex,left,right));
		self.orig_Height           := stringlib.StringToUpperCase(trim(l.orig_Height,left,right));
		self.orig_Weight           := stringlib.StringToUpperCase(trim(l.orig_Weight,left,right));
		self.orig_Eyes             := stringlib.StringToUpperCase(trim(l.orig_Eyes,left,right));
		self.orig_StreetNum        := stringlib.StringToUpperCase(trim(l.orig_StreetNum,left,right));
		self.orig_Street           := stringlib.StringToUpperCase(trim(l.orig_Street,left,right));
		self.orig_City             := stringlib.StringToUpperCase(trim(l.orig_City,left,right));
		self.orig_State            := stringlib.StringToUpperCase(trim(l.orig_State,left,right));
		self.orig_Zip              := trim(l.orig_Zip,left,right);
		self.orig_Zip4             := trim(l.orig_Zip4,left,right);
		self.orig_DLExpireDate     := lib_stringlib.stringlib.stringfilter(l.orig_DLExpireDate,'0123456789');
		self.orig_DLIssueDate      := lib_stringlib.stringlib.stringfilter(l.orig_DLIssueDate,'0123456789');
		self.orig_DLType           := stringlib.StringToUpperCase(trim(l.orig_DLType,left,right));
		self.orig_Restrictions     := stringlib.StringToUpperCase(trim(l.orig_Restrictions,left,right));
		self.orig_LicenseStatus    := stringlib.StringToUpperCase(trim(l.orig_LicenseStatus,left,right));
		self.orig_CDLStatus        := stringlib.StringToUpperCase(trim(l.orig_CDLStatus,left,right));
		self.orig_LicenseClass     := stringlib.StringToUpperCase(trim(l.orig_LicenseClass,left,right));
		self.orig_TotalPoints      := stringlib.StringToUpperCase(trim(l.orig_TotalPoints,left,right));
		self.orig_EarliestPointsDate  := lib_stringlib.stringlib.stringfilter(l.orig_EarliestPointsDate,'0123456789');
		self.orig_EarliestPointsTotal := stringlib.StringToUpperCase(trim(l.orig_EarliestPointsTotal,left,right));
		self.orig_Endorsements     := stringlib.StringToUpperCase(trim(l.orig_Endorsements,left,right));			
		self.orig_SSN              := lib_stringlib.stringlib.stringfilter(l.orig_SSN,'0123456789');
		self                       := l;		
	end;

	Cleaned_WV_File := project(in_file, mapClean(left));
	
	return Cleaned_WV_File;
end;