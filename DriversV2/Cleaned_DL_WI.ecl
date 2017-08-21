import Drivers, Address, ut, lib_stringlib;

export Cleaned_DL_WI(string processDate, string fileDate) := function

	in_file := DriversV2.File_DL_WI_Raw(fileDate);

	layout_out := drivers.Layout_WI_Full;

	layout_out CleanAndNorm(in_file l, integer c) := transform
		string73 tempName := stringlib.StringToUpperCase(if(trim(trim(l.orig_FIRST_NAME,left,right) + ' ' +
														   trim(l.orig_LAST_NAME,left,right),left,right) <> '',
														   Address.CleanPersonFML73(trim(trim(l.orig_FIRST_NAME,left,right) + ' ' +	
														   						         trim(l.orig_MIDDLE_INITIAL,left,right) + ' ' +
																						 trim(l.orig_LAST_NAME,left,right),left,right)),
														   ''));
		
		self.clean_name_prefix      := tempName[1..5];
		self.clean_name_first       := tempName[6..25];
		self.clean_name_middle      := tempName[26..45];
		self.clean_name_last        := tempName[46..65];
		self.clean_name_suffix	    := ut.fGetSuffix(tempName[66..70]);
		self.clean_name_score   	  := tempName[71..73];
		self.clean_prim_range       := '';
		self.clean_predir 	        := '';
		self.clean_prim_name 	      := '';
		self.clean_addr_suffix      := '';
		self.clean_postdir 	        := '';
		self.clean_unit_desig 	    := '';
		self.clean_sec_range 	      := '';
		self.clean_p_city_name	    := '';
		self.clean_v_city_name	    :='';
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
		self.append_process_date    := lib_stringlib.stringlib.stringfilter(processDate,'0123456789');
		self.orig_DL_NUMBER         := stringlib.StringToUpperCase(trim(l.orig_DL_NUMBER,left,right));
		self.orig_LAST_NAME         := stringlib.StringToUpperCase(trim(l.orig_LAST_NAME,left,right));
		self.orig_FIRST_NAME        := stringlib.StringToUpperCase(trim(l.orig_FIRST_NAME,left,right));
		self.orig_MIDDLE_INITIAL    := stringlib.StringToUpperCase(trim(l.orig_MIDDLE_INITIAL,left,right));
		self.orig_DOB               := lib_stringlib.stringlib.stringfilter(l.orig_DOB,'0123456789');
		self.orig_SEX               := stringlib.StringToUpperCase(trim(l.orig_SEX,left,right));
		self.orig_ADDRESS1          := stringlib.StringToUpperCase(trim(l.orig_ADDRESS1,left,right));
		self.orig_ADDRESS2          := stringlib.StringToUpperCase(trim(l.orig_ADDRESS2,left,right));
		self.append_PO_BOX          := stringlib.StringToUpperCase(trim(l.orig_PO_BOX,left,right));
		self.orig_CITY              := stringlib.StringToUpperCase(trim(l.orig_CITY,left,right));
		self.orig_COUNTY_NAME       := stringlib.StringToUpperCase(trim(l.orig_COUNTY_NAME,left,right));
		self.orig_STATE             := stringlib.StringToUpperCase(trim(l.orig_STATE,left,right));
		self.orig_ZIP_CODE          := trim(l.orig_ZIP_CODE,left,right);
		self.orig_OPT_OUT_CODE      := stringlib.StringToUpperCase(trim(l.orig_OPT_OUT_CODE,left,right));
    self.orig_LICENSE_COUNTER   := stringlib.StringToUpperCase(trim(l.orig_LICENSE_COUNTER,left,right));		
		
		self.append_ISSUE_DATE      := choose(c,
		                                      lib_stringlib.stringlib.stringfilter(l.orig_GROUP1_ISSUE_DATE,'0123456789'),
											  lib_stringlib.stringlib.stringfilter(l.orig_GROUP2_ISSUE_DATE,'0123456789'),
											  lib_stringlib.stringlib.stringfilter(l.orig_GROUP3_ISSUE_DATE,'0123456789'),
											  lib_stringlib.stringlib.stringfilter(l.orig_GROUP4_ISSUE_DATE,'0123456789'),
											  lib_stringlib.stringlib.stringfilter(l.orig_GROUP5_ISSUE_DATE,'0123456789'),
											  lib_stringlib.stringlib.stringfilter(l.orig_GROUP6_ISSUE_DATE,'0123456789')
											 );
		
		self.append_EXPIRATION_DATE := choose(c,
		                                      lib_stringlib.stringlib.stringfilter(l.orig_GROUP1_EXPIRATION_DATE,'0123456789'),
											  lib_stringlib.stringlib.stringfilter(l.orig_GROUP2_EXPIRATION_DATE,'0123456789'),
											  lib_stringlib.stringlib.stringfilter(l.orig_GROUP3_EXPIRATION_DATE,'0123456789'),
											  lib_stringlib.stringlib.stringfilter(l.orig_GROUP4_EXPIRATION_DATE,'0123456789'),
											  lib_stringlib.stringlib.stringfilter(l.orig_GROUP5_EXPIRATION_DATE,'0123456789'),
											  lib_stringlib.stringlib.stringfilter(l.orig_GROUP6_EXPIRATION_DATE,'0123456789')
											 );		
		
		self.append_LICENSE_TYPE    := choose(c,
		                                      stringlib.StringToUpperCase(trim(l.orig_GROUP1_LICENSE_TYPE,left,right)),
											  stringlib.StringToUpperCase(trim(l.orig_GROUP2_LICENSE_TYPE,left,right)),
											  stringlib.StringToUpperCase(trim(l.orig_GROUP3_LICENSE_TYPE,left,right)),
											  stringlib.StringToUpperCase(trim(l.orig_GROUP4_LICENSE_TYPE,left,right)),
											  stringlib.StringToUpperCase(trim(l.orig_GROUP5_LICENSE_TYPE,left,right)),
											  stringlib.StringToUpperCase(trim(l.orig_GROUP6_LICENSE_TYPE,left,right))
											 );
		
		self.append_CLASSES         := choose(c,
		                                      stringlib.StringToUpperCase(trim(l.orig_GROUP1_CLASSES,left,right)),
											  stringlib.StringToUpperCase(trim(l.orig_GROUP2_CLASSES,left,right)),
											  stringlib.StringToUpperCase(trim(l.orig_GROUP3_CLASSES,left,right)),
											  stringlib.StringToUpperCase(trim(l.orig_GROUP4_CLASSES,left,right)),
											  stringlib.StringToUpperCase(trim(l.orig_GROUP5_CLASSES,left,right)),
											  stringlib.StringToUpperCase(trim(l.orig_GROUP6_CLASSES,left,right))
											 );
		
		self.append_ENDORSEMENTS    := choose(c,
		                                      stringlib.StringToUpperCase(trim(l.orig_GROUP1_ENDORSEMENTS,left,right)),
											  stringlib.StringToUpperCase(trim(l.orig_GROUP2_ENDORSEMENTS,left,right)),
											  stringlib.StringToUpperCase(trim(l.orig_GROUP3_ENDORSEMENTS,left,right)),
											  stringlib.StringToUpperCase(trim(l.orig_GROUP4_ENDORSEMENTS,left,right)),
											  stringlib.StringToUpperCase(trim(l.orig_GROUP5_ENDORSEMENTS,left,right)),
											  stringlib.StringToUpperCase(trim(l.orig_GROUP6_ENDORSEMENTS,left,right))
											 );
		
		self                        := l;		
	end;

	Cleaned_WI_File := normalize(in_file, (integer)left.orig_license_counter, CleanAndNorm(left, counter));
	
	return Cleaned_WI_File;
end;