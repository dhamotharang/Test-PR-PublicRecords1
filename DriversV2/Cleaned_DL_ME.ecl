import Drivers, Address, ut, lib_stringlib, NID,_Validate;

export Cleaned_DL_ME(string processDate, string fileDate) := function

	in_file := DriversV2.File_DL_ME_Update(fileDate);

	layout_out := drivers.Layout_ME_Full;
	
	ConvertInchesToFeet(string in_hgt) := function
   integer  orig_hgt_in_ft       := (integer)trim(in_hgt,left,right)/12;
   real     orig_hgt_in_inch     := ((real4)in_hgt%12)*.01;
	 string2  orig_hgt_in_inch_str := if(orig_hgt_in_inch = 0, '00',
	                                     if(orig_hgt_in_inch = .1, '10',((string)orig_hgt_in_inch)[3..4]));
	 string3 num_ft := (string)orig_hgt_in_ft + orig_hgt_in_inch_str;
   return num_ft;
  end;
	
	NID.Mac_CleanParsedNames(in_file,cln_file,orig_FName,orig_MI,orig_LName,orig_NameSuf);
	
	inrecs := cln_file;
	
	layout_out mapClean(inrecs l) := transform
  		self.clean_name_prefix      := l.cln_title;
			self.clean_name_first       := l.cln_fname;
			self.clean_name_middle      := l.cln_mname;
			self.clean_name_last        := l.cln_lname;
			self.clean_name_suffix	    := l.cln_suffix; 
			self.clean_name_score   	  := '';
			self.clean_prim_range       := '';
			self.clean_predir 	        := '';
			self.clean_prim_name 	      := '';
			self.clean_addr_suffix      := '';
			self.clean_postdir 	        := '';
			self.clean_unit_desig 	    := '';
			self.clean_sec_range 	      := '';
			self.clean_p_city_name	    := '';
			self.clean_v_city_name	    := '';
			self.clean_st			          := '';
			self.clean_zip 		          := '';
			self.clean_zip4 		        := '';
			self.clean_cart 		        := '';
			self.clean_cr_sort_sz 	    := '';
			self.clean_lot 		          := '';
			self.clean_lot_order 	      := '';
			self.clean_dpbc 		        := '';
			self.clean_chk_digit 	      := '';
			self.clean_record_type	    := '';
			self.clean_ace_fips_st	    := '';
			self.clean_fipscounty 	    := '';
			self.clean_geo_lat 	        := '';
			self.clean_geo_long 	      := '';
			self.clean_msa 		          := '';
			self.clean_geo_blk          := '';
			self.clean_geo_match 	      := '';
			self.clean_err_stat 	      := '';
			self.append_process_date    := IF(_Validate.Date.fIsValid(processDate),processDate,'');
			self.orig_DOB               := IF(_Validate.Date.fIsValid(l.orig_DOB[5..8]+l.orig_DOB[1..2]+l.orig_DOB[3..4]) AND
	                                   _Validate.Date.fIsValid(l.orig_DOB[5..8]+l.orig_DOB[1..2]+l.orig_DOB[3..4],_Validate.Date.Rules.DateInPast),l.orig_DOB,'');
			self.orig_Credential_Type   := stringlib.StringToUpperCase(trim(l.orig_Credential_Type,left,right));
			self.orig_ID_Terminal_Date  := IF(_Validate.Date.fIsValid(l.orig_ID_Terminal_Date[5..8]+l.orig_ID_Terminal_Date[1..2]+l.orig_ID_Terminal_Date[3..4]),l.orig_ID_Terminal_Date,'');
			self.orig_LName             := stringlib.StringToUpperCase(trim(l.orig_LName,left,right));
			self.orig_FName             := stringlib.StringToUpperCase(trim(l.orig_FName,left,right));
			self.orig_MI                := stringlib.StringToUpperCase(trim(l.orig_MI,left,right));
			self.orig_NameSuf           := stringlib.StringToUpperCase(trim(l.orig_NameSuf,left,right));
			self.orig_Street            := stringlib.StringToUpperCase(trim(l.orig_Street,left,right));
			self.orig_CITY              := stringlib.StringToUpperCase(trim(l.orig_CITY,left,right));
			self.orig_STATE             := stringlib.StringToUpperCase(trim(l.orig_STATE,left,right));
			self.orig_Zip               := trim(l.orig_Zip,left,right);
			self.orig_DriverEd          := stringlib.StringToUpperCase(trim(l.orig_DriverEd,left,right));
			self.orig_Sex               := stringlib.StringToUpperCase(trim(l.orig_Sex,left,right));
			
			string3 Total_Hgt           := ConvertInchesToFeet(l.orig_Height_Ins);
			
			self.orig_Height            := Total_Hgt[1];
			self.orig_Height2           := Total_Hgt[2..3];
			self.orig_Weight            := lib_stringlib.stringlib.stringfilter(l.orig_Weight,'0123456789');
			self.orig_DLStat            := stringlib.StringToUpperCase(trim(l.orig_DLStat,left,right));
			self.orig_RegStatCR         := stringlib.StringToUpperCase(trim(l.orig_RegStatCR,left,right));
			self.orig_DLClass           := stringlib.StringToUpperCase(trim(l.orig_DLClass,left,right));
			self.orig_HistoryNum        := stringlib.StringToUpperCase(trim(l.orig_HistoryNum,left,right));
			self.orig_DisabledVet       := stringlib.StringToUpperCase(trim(l.orig_DisabledVet,left,right));			
			self.orig_Photo             := stringlib.StringToUpperCase(trim(l.orig_Photo,left,right));
			self.orig_HabitualOffender  := stringlib.StringToUpperCase(trim(l.orig_HabitualOffender,left,right));
			self.orig_Restrictions      := stringlib.StringToUpperCase(trim(l.orig_Restrictions,left,right));	
			self.orig_Endorsements      := stringlib.StringToUpperCase(trim(l.orig_Endorsements,left,right));
			self.orig_Endorsements2     := stringlib.StringToUpperCase(trim(l.orig_Endorsements2,left,right));
			self.orig_Endorsements3     := stringlib.StringToUpperCase(trim(l.orig_Endorsements3,left,right));
			self.orig_Endorsements4     := stringlib.StringToUpperCase(trim(l.orig_Endorsements4,left,right));
			self.orig_Endorsements5     := stringlib.StringToUpperCase(trim(l.orig_Endorsements5,left,right));
			self.orig_Endorsements6     := stringlib.StringToUpperCase(trim(l.orig_Endorsements6,left,right));
			self.orig_Endorsements7     := stringlib.StringToUpperCase(trim(l.orig_Endorsements7,left,right));
			self.orig_Endorsements8     := stringlib.StringToUpperCase(trim(l.orig_Endorsements8,left,right));
			self.orig_Endorsements9     := stringlib.StringToUpperCase(trim(l.orig_Endorsements9,left,right));
			self.orig_Endorsements10    := stringlib.StringToUpperCase(trim(l.orig_Endorsements10,left,right));
			self.orig_Endorsements11_20 := stringlib.StringToUpperCase(trim(l.orig_Endorsements11_20,left,right));
			self.orig_Comm_Driv_Status  := stringlib.StringToUpperCase(trim(l.orig_Comm_Driv_Status,left,right));
			self.orig_Disabled_Vet_Type := stringlib.StringToUpperCase(trim(l.orig_Disabled_Vet_Type,left,right));
			self.orig_Organ_Donor       := stringlib.StringToUpperCase(trim(l.orig_Organ_Donor,left,right));
			self.orig_DLExpireDate      := IF(_Validate.Date.fIsValid(l.orig_DLExpireDate[5..8]+l.orig_DLExpireDate[1..2]+l.orig_DLExpireDate[3..4]),l.orig_DLExpireDate,'');
			self.orig_DLIssueDate       := IF(_Validate.Date.fIsValid(l.orig_DLIssueDate[5..8]+l.orig_DLIssueDate[1..2]+l.orig_DLIssueDate[3..4]) AND
	                                  _Validate.Date.fIsValid(l.orig_DLIssueDate[5..8]+l.orig_DLIssueDate[1..2]+l.orig_DLIssueDate[3..4],_Validate.Date.Rules.DateInPast),l.orig_DLIssueDate,'');
			self.orig_OriginalIssueDate := IF(_Validate.Date.fIsValid(l.orig_OriginalIssueDate[5..8]+l.orig_OriginalIssueDate[1..2]+l.orig_OriginalIssueDate[3..4]) AND
	                                  _Validate.Date.fIsValid(l.orig_OriginalIssueDate[5..8]+l.orig_OriginalIssueDate[1..2]+l.orig_OriginalIssueDate[3..4],_Validate.Date.Rules.DateInPast),l.orig_OriginalIssueDate,'');
			self.orig_CRLF              := l.orig_LF;
			self                        := l;		
	end;

	Cleaned_ME_File := project(inrecs, mapClean(left));
    
	return Cleaned_ME_File;
end;
