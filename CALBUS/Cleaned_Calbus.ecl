import lib_stringlib, Address;

export Cleaned_Calbus(string8 pdate, string8 fdate) := function

  in_Calbus_file := File_Calbus_In.File_Raw(fdate);
  
  Layout_Common := Calbus.Layouts_Calbus.Layout_Common;
  
  Layout_Common cleanCalbusTrf(in_Calbus_file l) := transform
	// When Ownership_code = ['P','V','S'] then Owner_Name may contain an induvidual's name otherwise 
	// Owner_Name will be a business name. So based on this conditions, clean the owner_name if it is 
	// an actual person name.
	string73 tempOwnerName     := stringlib.StringToUpperCase(if(trim(l.Owner_Name,left,right) <> '' and
	                                                             stringlib.StringToUpperCase(trim(l.Ownership_code,left,right)) in Calbus.Constants.OwnerShip_Code_Check,
																 Address.CleanPerson73(trim(l.Owner_Name,left,right)),
													             ''));
	/* Removed address cleaning for applying AID process at later steps.
	string182 tempBusinessAddr := stringlib.StringToUpperCase(if(trim(l.BUSINESS_STREET,left,right) <> '' or
															     trim(l.BUSINESS_CITY,left,right)  <> '' or
	  	                                                         trim(l.BUSINESS_STATE,left,right) <> '' or
															     trim(l.BUSINESS_ZIP_5,left,right)   <> '',
															     Address.CleanAddress182(trim(l.BUSINESS_STREET,left,right),
																					trim(trim(l.BUSINESS_CITY,left,right) + ', ' +
																						 trim(l.BUSINESS_STATE,left,right) + ' ' +
																						 lib_stringlib.stringlib.stringfilter(l.BUSINESS_ZIP_5 + l.BUSINESS_ZIP_PLUS_4,'0123456789'),left,right)),
														         ''));

	string182 tempMailingAddr   := stringlib.StringToUpperCase(if(trim(l.MAILING_STREET,left,right) <> '' or
															      trim(l.MAILING_CITY,left,right)  <> '' or
	  	                                                          trim(l.MAILING_STATE,left,right) <> '' or
															      trim(l.MAILING_ZIP_5,left,right)   <> '',
															      Address.CleanAddress182(trim(l.MAILING_STREET,left,right),
																					trim(trim(l.MAILING_CITY,left,right) + ', ' +
																						 trim(l.MAILING_STATE,left,right) + ' ' +
																						 lib_stringlib.stringlib.stringfilter(l.MAILING_ZIP_5 + l.MAILING_ZIP_PLUS_4,'0123456789'),left,right)),
														          ''));

	*/
	self.Owner_title		          	:= tempOwnerName[1..5];
	self.Owner_fname	              := tempOwnerName[6..25];
	self.Owner_mname	              := tempOwnerName[26..45];
	self.Owner_lname		          	:= tempOwnerName[46..65];
	self.Owner_name_suffix	        := tempOwnerName[66..70];
	self.Owner_name_score	          := tempOwnerName[71..73];
	/* Removed address cleaning for applying AID process at later steps.
	self.Business_prim_range    	  := tempBusinessAddr[1..10];
	self.Business_predir 	      	  := tempBusinessAddr[11..12];
	self.Business_prim_name 	  	  := tempBusinessAddr[13..40];
	self.Business_addr_suffix   	  := tempBusinessAddr[41..44];
	self.Business_postdir 	    	  := tempBusinessAddr[45..46];
	self.Business_unit_desig 	  	  := tempBusinessAddr[47..56];
	self.Business_sec_range 	  	  := tempBusinessAddr[57..64];
	self.Business_p_city_name	  	  := tempBusinessAddr[65..89];
	self.Business_v_city_name	  	  := tempBusinessAddr[90..114];
	self.Business_st 			      		:= if(tempBusinessAddr[115..116] = '',
																				ziplib.ZipToState2(tempBusinessAddr[117..121]),
																				tempBusinessAddr[115..116]);
	self.Business_zip5 		      	  := tempBusinessAddr[117..121];
	self.Business_zip4 		      	  := tempBusinessAddr[122..125];
	self.Business_cart 		      	  := tempBusinessAddr[126..129];
	self.Business_cr_sort_sz 	 	  	:= tempBusinessAddr[130];
	self.Business_lot 		      	  := tempBusinessAddr[131..134];
	self.Business_lot_order 	  	  := tempBusinessAddr[135];
	self.Business_dpbc 		      	  := tempBusinessAddr[136..137];
	self.Business_chk_digit 	  	  := tempBusinessAddr[138];
	self.Business_addr_rec_type	 	  := tempBusinessAddr[139..140];
	self.Business_fips_state	  	  := tempBusinessAddr[141..142];
	self.Business_fips_county 	  	:= tempBusinessAddr[143..145];
	self.Business_geo_lat 	    	  := tempBusinessAddr[146..155];
	self.Business_geo_long 	    	  := tempBusinessAddr[156..166];
	self.Business_cbsa 		      	  := tempBusinessAddr[167..170];
	self.Business_geo_blk           := tempBusinessAddr[171..177];
	self.Business_geo_match 	  	  := tempBusinessAddr[178];
	self.Business_err_stat 	    	  := tempBusinessAddr[179..182];
  //Outlet clean Address 
	self.Mailing_prim_range    		  := tempMailingAddr[1..10];
	self.Mailing_predir 	      	  := tempMailingAddr[11..12];
	self.Mailing_prim_name 	  		  := tempMailingAddr[13..40];
	self.Mailing_addr_suffix   		  := tempMailingAddr[41..44];
	self.Mailing_postdir 	    	  	:= tempMailingAddr[45..46];
	self.Mailing_unit_desig 	  	  := tempMailingAddr[47..56];
	self.Mailing_sec_range 	  		  := tempMailingAddr[57..64];
	self.Mailing_p_city_name	  	  := tempMailingAddr[65..89];
	self.Mailing_v_city_name	  	  := tempMailingAddr[90..114];
	self.Mailing_st 			      		:= if(tempMailingAddr[115..116] = '',
																				ziplib.ZipToState2(tempMailingAddr[117..121]),
																				tempMailingAddr[115..116]);
	self.Mailing_zip5 		      	  := tempMailingAddr[117..121];
	self.Mailing_zip4 		      	  := tempMailingAddr[122..125];
	self.Mailing_cart 		      	  := tempMailingAddr[126..129];
	self.Mailing_cr_sort_sz 	 	  	:= tempMailingAddr[130];
	self.Mailing_lot 		      	  	:= tempMailingAddr[131..134];
	self.Mailing_lot_order 	  		  := tempMailingAddr[135];
	self.Mailing_dpbc 		      	  := tempMailingAddr[136..137];
	self.Mailing_chk_digit 	  		  := tempMailingAddr[138];
	self.Mailing_addr_rec_type		  := tempMailingAddr[139..140];
	self.Mailing_fips_state  	  	  := tempMailingAddr[141..142];
	self.Mailing_fips_county 	  	  := tempMailingAddr[143..145];
	self.Mailing_geo_lat 	    	  	:= tempMailingAddr[146..155];
	self.Mailing_geo_long 	    	  := tempMailingAddr[156..166];
	self.Mailing_cbsa 		      	  := tempMailingAddr[167..170];
	self.Mailing_geo_blk            := tempMailingAddr[171..177];
	self.Mailing_geo_match 	  		  := tempMailingAddr[178];
	self.Mailing_err_stat 	    	  := tempMailingAddr[179..182];
	*/
	self.process_date                 := trim(pdate, left, right);
	self.dt_first_seen                := stringlib.stringfilter(self.process_date,'0123456789');
	self.dt_last_seen                 := stringlib.stringfilter(self.process_date,'0123456789');
	self.DISTRICT_BRANCH              := stringlib.StringToUpperCase(trim(l.DISTRICT_BRANCH,left,right));
	self.ACCOUNT_NUMBER               := trim(l.ACCOUNT_NUMBER,left,right);
	self.sub_account_number           := trim(l.sub_account_number,left,right);
	self.account_type 							  := stringlib.StringToUpperCase(trim(l.account_type,left,right));           
	self.DISTRICT                     := stringlib.StringToUpperCase(trim(l.DISTRICT,left,right));
	self.FIRM_NAME                    := stringlib.StringToUpperCase(trim(l.FIRM_NAME,left, right));
	self.OWNER_NAME                   := stringlib.StringToUpperCase(trim(l.OWNER_NAME,left, right));
	self.BUSINESS_STREET              := stringlib.StringToUpperCase(trim(l.BUSINESS_STREET,left, right));
	self.BUSINESS_CITY                := stringlib.StringToUpperCase(trim(l.BUSINESS_CITY,left, right));
	self.BUSINESS_STATE               := stringlib.StringToUpperCase(trim(l.BUSINESS_STATE,left, right));	
	self.BUSINESS_ZIP_5               := trim(l.BUSINESS_ZIP_5,left, right);
	self.BUSINESS_ZIP_PLUS_4          := trim(l.BUSINESS_ZIP_PLUS_4,left, right);
	self.BUSINESS_FOREIGN_ZIP         := trim(l.BUSINESS_FOREIGN_ZIP,left, right);
	self.BUSINESS_COUNTRY_NAME        := stringlib.StringToUpperCase(trim(l.BUSINESS_COUNTRY_NAME,left, right));
// Removing below fields to apply layout changes 
/* 	self.TAX_CODE_FULL                := stringlib.StringToUpperCase(trim(l.TAX_CODE_FULL,left,right));
		self.MAILING_STREET               := stringlib.StringToUpperCase(trim(l.MAILING_STREET,left, right));
   	self.MAILING_CITY                 := stringlib.StringToUpperCase(trim(l.MAILING_CITY,left, right));
   	self.MAILING_STATE                := stringlib.StringToUpperCase(trim(l.MAILING_STATE,left, right));
   	self.MAILING_ZIP_5                := trim(l.MAILING_ZIP_5,left, right);
   	self.MAILING_ZIP_PLUS_4           := trim(l.MAILING_ZIP_PLUS_4,left, right);
   	self.MAILING_COUNTRY_NAME         := stringlib.StringToUpperCase(trim(l.MAILING_COUNTRY_NAME,left, right));
    self.INDUSTRY_CODE                := stringlib.StringToUpperCase(trim(l.INDUSTRY_CODE,left, right));
   	self.NAICS_CODE                   := stringlib.StringToUpperCase(trim(l.NAICS_CODE,left, right));	
   	self.COUNTY_CODE                  := stringlib.StringToUpperCase(trim(l.COUNTY_CODE,left, right));	
    self.CITY_CODE                    := stringlib.StringToUpperCase(trim(l.CITY_CODE,left, right));
*/
	self.START_DATE                   := stringlib.stringfilter(l.START_DATE,'0123456789');
	self.OWNERSHIP_CODE               := stringlib.StringToUpperCase(trim(l.OWNERSHIP_CODE,left, right));
	self                              := l;
	self                              := [];
  end;

  Cleaned_file := project(in_Calbus_file, cleanCalbusTrf(left));
  
  return(Cleaned_file);
end; 