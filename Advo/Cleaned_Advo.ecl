 import lib_stringlib, Address;

export Cleaned_Advo:= function
  trimUpper(string s):=function
     return stringlib.StringToUpperCase(trim(s,left,right));
  end;

  in_advo_file := File_Advo_In.File_Raw;
  
Layout_Common 	:= Advo.Layouts_Advo.Layout_Common;

  Layout_Common cleanAdvotrf(in_advo_file l) := transform
													
	string182 tempCleanAddr 				:=stringlib.StringToUpperCase(if(trim(l.STREET_NAME,left,right) <> '' or
															trim(l.City_Name,left,right)  <> '' or
	  	                                                    trim(l.State_Code,left,right) <> '' or
															trim(l.ZIP,left,right)   <> '',
															Address.CleanAddress182(trim(l.STREET_NUM,left,right)+trim(l.STREET_NAME,left,right),
																					trim(trim(l.City_Name,left,right) + ', ' +
																						 trim(l.State_Code,left,right) + ' ' +
																						 lib_stringlib.stringlib.stringfilter((trim(l.zip,left,right)+trim(l.Zip4,left,right)),'0123456789'),left,right)),
														 ''));


	self.Clean_postdir 	    	  			:=tempCleanAddr[45..46];
	self.Clean_unit_desig 	  	  			:=tempCleanAddr[47..56];
	self.Clean_sec_range 	  	  			:=tempCleanAddr[57..64];
	self.Clean_p_city_name	  	  			:=tempCleanAddr[65..89];
	self.Clean_v_city_name	  	  			:=tempCleanAddr[90..114];
	self.Clean_st 			      			:=if(tempCleanAddr[115..116] = '',
									  	           ziplib.ZipToState2(tempCleanAddr[117..121]),
									  	             tempCleanAddr[115..116]);
	self.Clean_zip5 		      			:=tempCleanAddr[117..121];
	self.Clean_zip4 		      			:=tempCleanAddr[122..125];
	self.Clean_cart 		      			:=tempCleanAddr[126..129];
	self.Clean_cr_sort_sz 	 	  			:=tempCleanAddr[130];
	self.Clean_lot 		      	  			:=tempCleanAddr[131..134];
	self.Clean_lot_order 	  	  			:=tempCleanAddr[135];
	self.Clean_dpbc 		     			:=tempCleanAddr[136..137];
	self.Clean_chk_digit 	  	 			:=tempCleanAddr[138];
	self.Clean_addr_rec_type	 			:=tempCleanAddr[139..140];
	self.Clean_fips_state	  	  			:=tempCleanAddr[141..142];
	self.Clean_fips_county 	  	  			:=tempCleanAddr[143..145];
	self.Clean_geo_lat 	    	  			:=tempCleanAddr[146..155];
	self.Clean_geo_long 	      			:=tempCleanAddr[156..166];
	self.Clean_cbsa 		      			:=tempCleanAddr[167..170];
	self.Clean_geo_blk            			:=tempCleanAddr[171..177];
	self.Clean_geo_match 	  	  			:=tempCleanAddr[178];
	self.Clean_err_stat 	     		    :=tempCleanAddr[179..182];
	self.Address_Vacancy_Indicator			:=trimUpper(l.Address_Vacancy_Indicator );
	self.Throw_Back_Indicator				:=trimUpper(l.Throw_Back_Indicator );
	self.Seasonal_Delivery_Indicator		:=trimUpper(l.Seasonal_Delivery_Indicator );
	self.DND_Indicator						:=trimUpper(l.DND_Indicator );
	self.College_Indicator					:=trimUpper(l.College_Indicator );
	self.Address_Style_Flag					:=trimUpper(l.Address_Style_Flag );
	self.Drop_Indicator						:=trimUpper(l.Drop_Indicator );
	self.Residential_or_Business_Ind		:=trimUpper(l.Residential_or_Business_Ind );
	self.County_Name						:=trimUpper(l.County_Name );
	self.OWGM_Indicator						:=trimUpper(l.OWGM_Indicator );
	self.Record_Type_Code					:=trimUpper(l.Record_Type_Code );
	self.Mixed_Address_Usage				:=trimUpper(l.Mixed_Address_Usage );
	self.Update_Date						:=stringlib.stringfilter(l.Update_Date, '0123456789');
    self.File_Release_Date				    :=stringlib.stringfilter(l.File_Release_Date, '0123456789');
    self.Override_file_release_date			:=stringlib.stringfilter(l.Override_file_release_date, '0123456789');
    self.College_Start_Suppression_Date		:=stringlib.stringfilter(l.College_Start_Suppression_Date, '0123456789');
    self.College_End_Suppression_Date	    :=stringlib.stringfilter(l.College_End_Suppression_Date, '0123456789');
	self.Route_Num							:=trimUpper(l.Route_Num);
	self.WALK_Sequence						:=trim(l.WALK_Sequence ,left,right);
	self.STREET_PRE_DIRectional				:=trim(l.STREET_PRE_DIRectional ,left,right);
	self.STREET_POST_DIRectional			:=trim(l.STREET_POST_DIRectional ,left,right);
	self.STREET_SUFFIX						:=trimupper(l.STREET_SUFFIX);
	self.Secondary_Unit_Designator			:=trimUpper(l.Secondary_Unit_Designator);
	self.Secondary_Unit_Number				:=stringlib.stringfilter(l.Secondary_Unit_Number , '0123456789');
    self.Seasonal_Start_Suppression_Date	:=stringlib.stringfilter(l.Seasonal_Start_Suppression_Date, '0123456789');
	self.Seasonal_End_Suppression_Date		:=trim(l.Seasonal_End_Suppression_Date ,left,right);
    self.Simplify_Address_Count				:=trim(l.Simplify_Address_Count ,left,right);
    self.DPBC_Digit							:=trim(l.DPBC_Digit ,left,right);
    self.DPBC_Check_Digit				    :=trim(l.DPBC_Check_Digit	 ,left,right);
    self.County_Num							:=trim(l.County_Num ,left,right);
    self.State_Num							:=trim(l.State_Num ,left,right);
    self.Congressional_District_Number		:=trim(l.Congressional_District_Number ,left,right);
    self.ADVO_Key						    :=trim(l.ADVO_Key ,left,right);
    self.Address_Type					    :=trim(l.Address_Type ,left,right);
	self                          			:= l;
	self                          			:= [];
  end;

  Cleaned_file := project(in_advo_file, cleanAdvotrf(left));
  
  return(Cleaned_file);
end; 
 
 