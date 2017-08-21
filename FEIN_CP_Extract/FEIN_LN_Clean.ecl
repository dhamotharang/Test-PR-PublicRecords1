import lib_stringlib,Address;
 
 FEIN_LN_Raw  := FEIN_CP_Extract.File_FEIN_LN_RawIN;
	
 FEIN_CP_Extract.Layouts.Fein_LN_Clean_raw Trans_Clean(FEIN_LN_Raw l) := transform

	string182 BusAddr             := stringlib.StringToUppercase(if(trim(l.Address,left,right) <> '' or
																 trim(l.City,left,right)  <> '' or
	  	                                                         trim(l.state,left,right) <> '' or
															     trim(l.ZIP,left,right)   <> '' ,
															     Address.CleanAddress182(trim(l.Address,left,right),
																					trim(trim(l.CITY,left,right) + ', ' +
																						 trim(l.state,left,right) + ' ' +
																						 lib_stringlib.stringlib.stringfilter(l.ZIP,'0123456789'),left,right)),''));
														         

	self.Bus_prim_range    	        := BusAddr[1..10];
	self.Bus_predir 	      	    := BusAddr[11..12];
	self.Bus_prim_name 	  	        := BusAddr[13..40];
	self.Bus_addr_suffix   	        := BusAddr[41..44];
	self.Bus_postdir 	    	    := BusAddr[45..46];
	self.Bus_unit_desig 	  	    := BusAddr[47..56];
	self.Bus_sec_range 	  	        := BusAddr[57..64];
	self.Bus_p_city_name	  	    := BusAddr[65..89];
	self.Bus_v_city_name	  	    := BusAddr[90..114];
	self.Bus_st 			      	:= if(BusAddr[115..116] = '',
									  	    ziplib.ZipToState2(BusAddr[117..121]),
									  	    BusAddr[115..116]);
	self.Bus_zip5 		      	    := BusAddr[117..121];
	self.Bus_zip4 		      	    := BusAddr[122..125];
/* 	self.Bus_cart 		      	    := BusAddr[126..129];
   	self.Bus_cr_sort_sz 	 	    := BusAddr[130];
   	self.Bus_lot 		      	    := BusAddr[131..134];
   	self.Bus_lot_order 	  	        := BusAddr[135];
   	self.Bus_dpbc 		      	    := BusAddr[136..137];
   	self.Bus_chk_digit 	  	        := BusAddr[138];
   	self.Bus_addr_rec_type	 	    := BusAddr[139..140];
   	self.Bus_fips_state	  	        := BusAddr[141..142];
   	self.Bus_fips_county 	  	    := BusAddr[143..145];
   	self.Bus_geo_lat 	    	    := BusAddr[146..155];
   	self.Bus_geo_long 	    	    := BusAddr[156..166];
   	self.Bus_cbsa 		      	    := BusAddr[167..170];
   	self.Bus_geo_blk                := BusAddr[171..177];
   	self.Bus_geo_match 	  	        := BusAddr[178];
   	self.Bus_err_stat 	    	    := BusAddr[179..182];
*/
	self.Tax_ID_Number			    := if(lib_stringlib.StringLib.StringFindReplace(l.Tax_ID_Number, '0','')<>'',trim(l.Tax_ID_Number,left,right),'');
	self.Source_Duns_Number		    := if(lib_stringlib.StringLib.StringFindReplace(l.Source_Duns_Number, '0','')<>'',trim(l.Source_Duns_Number,left,right),'');
	self.Business_Name 	    		:= stringlib.StringToUppercase(trim(l.Business_Name,left,right));
	self.Address		     		:= stringlib.StringToUppercase(trim(l.Address,left,right));
	self.CITY		     			:= stringlib.StringToUppercase(trim(l.CITY,left,right));
	self.state		     			:= stringlib.StringToUppercase(trim(l.state,left,right));
	self.ZIP		     			:= if(lib_stringlib.StringLib.StringFindReplace(l.ZIP, '0','')<>'',trim(l.Zip,left,right),'');
	self.Reference_Name_Source		:= stringlib.StringToUppercase(trim(l.Reference_Name_Source,left,right));
	self.Date_of_Input_data			:= if(lib_stringlib.StringLib.StringFindReplace(l.Date_of_Input_data, '0','')<>'',trim(l.Date_of_Input_data,left,right),'');
    self.Case_Duns_Number			:= if(lib_stringlib.StringLib.StringFindReplace(l.Case_Duns_Number, '0','')<>'',trim(l.Case_Duns_Number,left,right),'');
	self.Confidence_Code            := trim(l.Confidence_Code,left,right);
	self.Indirect_Direct_Source_Ind := trim(l.Indirect_Direct_Source_Ind,left,right);
	self.Best_FEIN_Indicator		:= trim(l.Best_FEIN_Indicator,left,right);
	self.Company_Name		     	:= stringlib.StringToUppercase(trim(l.Company_Name,left,right));
	self.Tradestyle			     	:= stringlib.StringToUppercase(trim(l.Tradestyle,left,right));
	self.SIC_Code		     		:= if(lib_stringlib.StringLib.StringFindReplace(l.SIC_Code, '0','')<>'',trim(l.SIC_Code,left,right),'');
	self.Telephone_Number		    := if(lib_stringlib.StringLib.StringFindReplace(l.Telephone_Number, '0','')<>'',trim(l.Telephone_Number,left,right),'');
	self.Top_Contact_Name		    := stringlib.StringToUppercase(trim(l.Top_Contact_Name,left,right));
	self.Top_Contact_Title		    := stringlib.StringToUppercase(trim(l.Top_Contact_Title,left,right));
	self.Headquarter_Paren_Duns_Nbr	:= if(lib_stringlib.StringLib.StringFindReplace(l.Headquarter_Paren_Duns_Nbr, '0','')<>'',trim(l.Headquarter_Paren_Duns_Nbr,left,right),'');
    self					  		:= l;
	
  end;
	
		export FEIN_LN_Clean  		:=project( FEIN_LN_Raw,Trans_Clean(left));
