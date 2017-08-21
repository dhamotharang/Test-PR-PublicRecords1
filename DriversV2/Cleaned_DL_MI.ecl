import Drivers, Address, ut, lib_stringlib;

export Cleaned_DL_MI(string processDate, string filedate) := function

	in_file := DriversV2.File_DL_MI_Update(filedate);

	layout_norm := record
	    string1 addr_type := '';
		recordof(in_file);
	end;
	
	layout_norm trfNormAddr(in_file l, integer c) := transform
	   self.addr_type    := choose(c,'','M');
	   self.orig_Street  := choose(c, l.orig_Street, l.orig_MailingStreet);
	   self.orig_City    := choose(c, l.orig_City, l.orig_MailingCity);
	   self.orig_State   := choose(c, l.orig_State, l.orig_MailingState);
	   self.orig_Zip     := choose(c, l.orig_Zip, l.orig_MailingZip);
	   self              := l;
	end;
	
	norm_file := normalize(in_file, 
	                       if(trim(left.orig_MailingStreet,left,right) <> trim(left.orig_Street,left,right) and 
							  trim(left.orig_MailingStreet,left,right) <> '',2,1)
						  ,trfNormAddr(left,counter));
		
		
	layout_out := record
		Drivers.Layout_MI_Full;
		string1 addr_type;
	end;
	
	layout_out mapClean(norm_file l) := transform
		string73 tempName     := stringlib.StringToUpperCase(if(trim(l.orig_Name,left,right) <> '',
																Address.CleanPerson73(trim(l.orig_Name,left,right)),
																''));
		self.clean_name_prefix 		:= tempName[1..5];
		self.clean_name_first		:= tempName[6..25];
		self.clean_name_middle 		:= tempName[26..45];
		self.clean_name_last   		:= tempName[46..65];
		self.clean_name_suffix 		:= tempName[66..70];
		self.clean_name_score 		:= tempName[71..73];
		self.clean_prim_range		  := '';
		self.clean_predir 	      := '';
		self.clean_prim_name 	  	:= '';
		self.clean_addr_suffix		:= '';
		self.clean_postdir 	    	:= '';
		self.clean_unit_desig 	  := '';
		self.clean_sec_range 	  	:= '';
		self.clean_p_city_name	  := '';
		self.clean_v_city_name	  := '';
		self.clean_st 			      := '';
		self.clean_zip 		      	:= '';
		self.clean_zip4 		      := '';
		self.clean_cart 		      := '';
		self.clean_cr_sort_sz 	 	:= '';
		self.clean_lot 		      	:= '';
		self.clean_lot_order 	  	:= '';
		self.clean_dpbc 		      := '';
		self.clean_chk_digit 	  	:= '';
		self.clean_record_type  	:= '';
		self.clean_ace_fips_st	  := '';
		self.clean_fipscounty  		:= '';
		self.clean_geo_lat 	    	:= '';
		self.clean_geo_long 	    := '';
		self.clean_msa 		      	:= '';
		self.clean_geo_blk        := '';
		self.clean_geo_match 	  	:= '';
		self.clean_err_stat 	    := '';
		self.append_process_date    := lib_stringlib.stringlib.stringfilter(processDate,'0123456789');
		self.orig_RecCode           := stringlib.StringToUpperCase(trim(l.orig_RecCode,left,right));
		self.orig_ClientIDNum       := stringlib.StringToUpperCase(trim(l.orig_ClientIDNum,left,right));
		self.orig_PersonalIDNum     := stringlib.StringToUpperCase(trim(l.orig_PersonalIDNum,left,right));
		self.orig_DLNum             := stringlib.StringToUpperCase(trim(l.orig_DLNum,left,right));
		self.orig_Name              := stringlib.StringToUpperCase(trim(l.orig_Name,left,right));
		self.orig_Street            := stringlib.StringToUpperCase(trim(l.orig_Street,left,right));
		self.orig_city              := stringlib.StringToUpperCase(trim(l.orig_city,left,right));
		self.orig_State             := stringlib.StringToUpperCase(trim(l.orig_State,left,right));
		self.orig_Zip               := trim(l.orig_Zip,left,right);
		self.orig_dob               := lib_stringlib.stringlib.stringfilter(l.orig_dob,'0123456789');
		self.orig_County            := stringlib.StringToUpperCase(trim(l.orig_County,left,right));
		self.orig_Sex               := stringlib.StringToUpperCase(trim(l.orig_Sex,left,right));
		self.orig_DLNorPIDIndicator := stringlib.StringToUpperCase(trim(l.orig_DLNorPIDIndicator,left,right));
		self.orig_MailingStreet     := stringlib.StringToUpperCase(trim(l.orig_MailingStreet,left,right));
		self.orig_MailingCity       := stringlib.StringToUpperCase(trim(l.orig_MailingCity,left,right));
		self.orig_MailingState      := stringlib.StringToUpperCase(trim(l.orig_MailingState,left,right));
		self.orig_MailingZip        := trim(l.orig_MailingZip,left,right);
		self.orig_OptOutIndicator   := stringlib.StringToUpperCase(trim(l.orig_OptOutIndicator,left,right));
		self.orig_LF                := '';
		self                        := l;		
	end;

	Cleaned_MI_File := project(norm_file, mapClean(left));
	
	return Cleaned_MI_File;
end;
