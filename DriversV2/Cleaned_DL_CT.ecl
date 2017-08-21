import Drivers, Address, ut, lib_stringlib;

export Cleaned_DL_CT(string processDate, string fileDate) := function

	in_file := DriversV2.File_DL_CT_Update(fileDate);

	layout_out := drivers.Layout_CT_Full;
	
	layout_out mapClean(in_file l) := transform
		string73 tempName := stringlib.StringToUpperCase(if(trim(l.orig_NAME,left,right) <> '',
															Address.CleanPerson73(trim(lib_stringlib.StringLib.stringfindreplace(l.orig_NAME,'@',' '),left,right)),
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
		self.orig_DLSTATE          := stringlib.StringToUpperCase(trim(l.orig_DLSTATE,left,right));  
		self.orig_DLNUMBER         := stringlib.StringToUpperCase(trim(l.orig_DLNUMBER,left,right));
		self.orig_NAME             := stringlib.StringToUpperCase(trim(l.orig_NAME,left,right));
		self.orig_DOB              := lib_stringlib.stringlib.stringfilter(l.orig_DOB,'0123456789');
		self.orig_SEX              := stringlib.StringToUpperCase(trim(l.orig_SEX,left,right));
		self.orig_HEIGHT1          := stringlib.StringToUpperCase(trim(l.orig_HEIGHT1,left,right));
		self.orig_HEIGHT2          := stringlib.StringToUpperCase(trim(l.orig_HEIGHT2,left,right));
		self.orig_EYE_COLOR        := stringlib.StringToUpperCase(trim(l.orig_EYE_COLOR,left,right));
		self.orig_MAILADDRESS      := stringlib.StringToUpperCase(trim(l.orig_MAILADDRESS,left,right));
		self.orig_ENDORSEMENTS     := lib_stringlib.stringlib.stringfilter(l.orig_ENDORSEMENTS,'0123456789');
		self.orig_EXPIRE_DATE      := lib_stringlib.stringlib.stringfilter(l.orig_EXPIRE_DATE,'0123456789');
		self.orig_EXPIRE_DATE_DD   := lib_stringlib.stringlib.stringfilter(l.orig_EXPIRE_DATE_DD,'0123456789');
		self.orig_ISSUE_DATE       := lib_stringlib.stringlib.stringfilter(l.orig_ISSUE_DATE,'0123456789');
		self.orig_ISSUE_DATE_DD    := lib_stringlib.stringlib.stringfilter(l.orig_ISSUE_DATE_DD,'0123456789');			
		self.orig_NONCDLSTATUS     := stringlib.StringToUpperCase(trim(l.orig_NONCDLSTATUS,left,right));
		self.orig_CDLSTATUS        := stringlib.StringToUpperCase(trim(l.orig_CDLSTATUS,left,right));
		self.orig_RESTRICTIONS     := stringlib.StringToUpperCase(trim(l.orig_RESTRICTIONS,left,right));
		self.orig_ORIGDATE         := lib_stringlib.stringlib.stringfilter(l.orig_ORIGDATE,'0123456789');
		self.orig_ORIGCDLDATE      := lib_stringlib.stringlib.stringfilter(l.orig_ORIGCDLDATE,'0123456789');
		self.orig_CANCELST         := stringlib.StringToUpperCase(trim(l.orig_CANCELST,left,right));
		self.orig_CANCELDATE       := lib_stringlib.stringlib.stringfilter(l.orig_CANCELDATE,'0123456789');
		self.orig_CRLF             := l.orig_LF;
		self                       := l;		
	end;

	Cleaned_CT_File := project(in_file, mapClean(left));
	
	return Cleaned_CT_File;
end;
