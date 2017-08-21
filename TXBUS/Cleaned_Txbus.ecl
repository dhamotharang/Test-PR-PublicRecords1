import lib_stringlib, Address;

export Cleaned_Txbus(string8 pdate, string8 fdate) := function

  in_txbus_file := File_Txbus_In.File_Raw(fdate);
  
  Layout_Common := Txbus.Layouts_Txbus.Layout_Common;

  Layout_Common cleanTxbusTrf(in_txbus_file l) := transform
			// If Taxpayer_Org_Type = 'IS' then Taxpayer_Name will contain an induvidual's name instead of the  
			// business name. So based on this conditions we only clean if it is an actual person name.
/* 			string73 tempTaxpayerName := stringlib.StringToUpperCase(if(trim(l.Taxpayer_Name,left,right) <> '' and
   																																	stringlib.StringToUpperCase(trim(l.Taxpayer_Org_Type,left,right)) = 'IS',
   															Address.CleanPerson73(trim(l.Taxpayer_Name,left,right)),
   															''));
*/
			/*	Removed address cleaning as it is done using new AID address cleaning at later steps in the build process.
			string182 tempTaxpayerAddr := stringlib.StringToUpperCase(if(trim(l.Taxpayer_Address,left,right) <> '' or
																	trim(l.Taxpayer_City,left,right)  <> '' or
																															trim(l.Taxpayer_State,left,right) <> '' or
																	trim(l.Taxpayer_ZipCode,left,right)   <> '',
																	Address.CleanAddress182(trim(l.Taxpayer_Address,left,right),
																							trim(trim(l.Taxpayer_City,left,right) + ', ' +
																								 trim(l.Taxpayer_State,left,right) + ' ' +
																								 lib_stringlib.stringlib.stringfilter(l.Taxpayer_ZipCode,'0123456789'),left,right)),
																 ''));

			string182 tempOutletAddr   := stringlib.StringToUpperCase(if(trim(l.Outlet_Address,left,right) <> '' or
																	trim(l.Outlet_City,left,right)  <> '' or
																															trim(l.Outlet_State,left,right) <> '' or
																	trim(l.Outlet_ZipCode,left,right)   <> '',
																	Address.CleanAddress182(trim(l.Outlet_Address,left,right),
																							trim(trim(l.Outlet_City,left,right) + ', ' +
																								 trim(l.Outlet_State,left,right) + ' ' +
																								 lib_stringlib.stringlib.stringfilter(l.Outlet_ZipCode,'0123456789'),left,right)),
																 ''));
			*/
			//self.Taxpayer_title		          := tempTaxpayerName[1..5];
			//self.Taxpayer_fname	              := tempTaxpayerName[6..25];
			//self.Taxpayer_mname	              := tempTaxpayerName[26..45];
			//self.Taxpayer_lname		          := tempTaxpayerName[46..65];
			//self.Taxpayer_name_suffix	      := tempTaxpayerName[66..70];
			//self.Taxpayer_name_score	      := tempTaxpayerName[71..73];
			/* Removed address cleaning as it is done using new AID address cleaning at later steps in the build process.
			self.Taxpayer_prim_range    	  := tempTaxpayerAddr[1..10];
			self.Taxpayer_predir 	      	  := tempTaxpayerAddr[11..12];
			self.Taxpayer_prim_name 	  	  := tempTaxpayerAddr[13..40];
			self.Taxpayer_addr_suffix   	  := tempTaxpayerAddr[41..44];
			self.Taxpayer_postdir 	    	  := tempTaxpayerAddr[45..46];
			self.Taxpayer_unit_desig 	  	  := tempTaxpayerAddr[47..56];
			self.Taxpayer_sec_range 	  	  := tempTaxpayerAddr[57..64];
			self.Taxpayer_p_city_name	  	  := tempTaxpayerAddr[65..89];
			self.Taxpayer_v_city_name	  	  := tempTaxpayerAddr[90..114];
			self.Taxpayer_st 			      := if(tempTaxpayerAddr[115..116] = '',
															ziplib.ZipToState2(tempTaxpayerAddr[117..121]),
															tempTaxpayerAddr[115..116]);
			self.Taxpayer_zip5 		      	  := tempTaxpayerAddr[117..121];
			self.Taxpayer_zip4 		      	  := tempTaxpayerAddr[122..125];
			self.Taxpayer_cart 		      	  := tempTaxpayerAddr[126..129];
			self.Taxpayer_cr_sort_sz 	 	  := tempTaxpayerAddr[130];
			self.Taxpayer_lot 		      	  := tempTaxpayerAddr[131..134];
			self.Taxpayer_lot_order 	  	  := tempTaxpayerAddr[135];
			self.Taxpayer_dpbc 		      	  := tempTaxpayerAddr[136..137];
			self.Taxpayer_chk_digit 	  	  := tempTaxpayerAddr[138];
			self.Taxpayer_addr_rec_type	  	  := tempTaxpayerAddr[139..140];
			self.Taxpayer_fips_state	  	  := tempTaxpayerAddr[141..142];
			self.Taxpayer_fips_county 	  	  := tempTaxpayerAddr[143..145];
			self.Taxpayer_geo_lat 	    	  := tempTaxpayerAddr[146..155];
			self.Taxpayer_geo_long 	    	  := tempTaxpayerAddr[156..166];
			self.Taxpayer_cbsa 		      	  := tempTaxpayerAddr[167..170];
			self.Taxpayer_geo_blk             := tempTaxpayerAddr[171..177];
			self.Taxpayer_geo_match 	  	  := tempTaxpayerAddr[178];
			self.Taxpayer_err_stat 	    	  := tempTaxpayerAddr[179..182];
				//Outlet clean Address 
			self.Outlet_prim_range    		  := tempOutletAddr[1..10];
			self.Outlet_predir 	      		  := tempOutletAddr[11..12];
			self.Outlet_prim_name 	  		  := tempOutletAddr[13..40];
			self.Outlet_addr_suffix   		  := tempOutletAddr[41..44];
			self.Outlet_postdir 	    	  := tempOutletAddr[45..46];
			self.Outlet_unit_desig 	  		  := tempOutletAddr[47..56];
			self.Outlet_sec_range 	  		  := tempOutletAddr[57..64];
			self.Outlet_p_city_name	  		  := tempOutletAddr[65..89];
			self.Outlet_v_city_name	  		  := tempOutletAddr[90..114];
			self.Outlet_st 			      	  := if(tempOutletAddr[115..116] = '',
														ziplib.ZipToState2(tempOutletAddr[117..121]),
															tempOutletAddr[115..116]);
			self.Outlet_zip5		      	  := tempOutletAddr[117..121];
			self.Outlet_zip4 		      	  := tempOutletAddr[122..125];
			self.Outlet_cart 		      	  := tempOutletAddr[126..129];
			self.Outlet_cr_sort_sz 	 		  := tempOutletAddr[130];
			self.Outlet_lot 		      	  := tempOutletAddr[131..134];
			self.Outlet_lot_order 	  		  := tempOutletAddr[135];
			self.Outlet_dpbc 		      	  := tempOutletAddr[136..137];
			self.Outlet_chk_digit 	  		  := tempOutletAddr[138];
			self.Outlet_addr_rec_type	  	  := tempOutletAddr[139..140];
			self.Outlet_fips_state	  		  := tempOutletAddr[141..142];
			self.Outlet_fips_county 	  	  := tempOutletAddr[143..145];
			self.Outlet_geo_lat 	    	  := tempOutletAddr[146..155];
			self.Outlet_geo_long 	    	  := tempOutletAddr[156..166];
			self.Outlet_cbsa 		      	  := tempOutletAddr[167..170];
			self.Outlet_geo_blk               := tempOutletAddr[171..177];
			self.Outlet_geo_match 	  		  := tempOutletAddr[178];
			self.Outlet_err_stat 	    	  := tempOutletAddr[179..182];
			*/
			self.process_date                 := trim(pdate, left, right);
			self.dt_first_seen                := stringlib.stringfilter(self.process_date,'0123456789');
			self.dt_last_seen                 := stringlib.stringfilter(self.process_date,'0123456789');
			self.Taxpayer_Number              := trim(l.Taxpayer_Number,left,right);
			self.Outlet_Number                := trim(l.Outlet_Number,left,right);
			self.Taxpayer_Name                := stringlib.StringToUpperCase(trim(l.Taxpayer_Name,left, right));
			self.Taxpayer_Address             := stringlib.StringToUpperCase(trim(l.Taxpayer_Address,left, right));
			self.Taxpayer_City                := stringlib.StringToUpperCase(trim(l.Taxpayer_City,left, right));
			self.Taxpayer_State               := stringlib.StringToUpperCase(trim(l.Taxpayer_State,left, right));
			self.Taxpayer_ZipCode             := trim(l.Taxpayer_ZipCode,left, right);
			self.Taxpayer_County_Code         := stringlib.StringToUpperCase(trim(l.Taxpayer_County_Code,left, right));
			self.Taxpayer_Org_Type            := stringlib.StringToUpperCase(trim(l.Taxpayer_Org_Type,left, right));
			self.Taxpayer_Org_Type_desc       := '';
			self.Taxpayer_Phone               := stringlib.stringfilter(l.Taxpayer_Phone,'0123456789');
			self.Outlet_Name                  := stringlib.StringToUpperCase(trim(l.Outlet_Name,left, right));
			self.Outlet_Address               := stringlib.StringToUpperCase(trim(l.Outlet_Address,left, right));
			self.Outlet_City                  := stringlib.StringToUpperCase(trim(l.Outlet_City,left, right));
			self.Outlet_State                 := stringlib.StringToUpperCase(trim(l.Outlet_State,left, right));
			self.Outlet_ZipCode               := trim(l.Outlet_ZipCode,left, right);
			self.Outlet_County_Code           := stringlib.StringToUpperCase(trim(l.Outlet_County_Code,left, right));
			self.Outlet_Phone                 := stringlib.stringfilter(l.Outlet_Phone,'0123456789');
			self.Outlet_NAICS_Code            := stringlib.StringToUpperCase(trim(l.Outlet_NAICS_Code,left, right));	
			self.Outlet_City_Limits_Indicator := stringlib.StringToUpperCase(trim(l.Outlet_City_Limits_Indicator,left, right));	
			self.Outlet_Permit_Issue_Date     := stringlib.stringfilter(l.Outlet_Permit_Issue_Date,'0123456789');
			self.Outlet_First_Sales_Date      := stringlib.stringfilter(l.Outlet_First_Sales_Date,'0123456789');
			self                              := l;
			self                              := [];
  end;

  Cleaned_file := project(in_txbus_file, cleanTxbusTrf(left));
  
  return(Cleaned_file);
end; 
 