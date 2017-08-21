
import lib_stringlib,Address;

trimUpper(string s) := function
		  return trim(stringlib.StringToUppercase(s),left,right);
		  end;
		  
  FilingName	:=	File_fbn_experian_in(trimUpper(Name_type)='B');
  

	// when Name_type='O' it's contact name and when Name_type='B' it's Business name .	
	
 Layout_fbn_experian.Layout_Slim_Clean_Bus Trans_slim(FilingName l) := transform
    self.cname 			          := stringlib.StringToUppercase(trim(l.Name,left,right));	
	
		
	string182 BusAddr             := stringlib.StringToUppercase(if(trim(l.address,left,right) <> ''or 
																 trim(l.city,left,right)  <> '' or
	  	                                                         trim(l.state,left,right) <> '' or
															     trim(l.zip_code,left,right)   <> '' ,
															     Address.CleanAddress182(trim(l.address,left,right),
																					trim(trim(l.city,left,right) + ', ' +
																						 trim(l.state,left,right) + ' ' +
																						 lib_stringlib.stringlib.stringfilter(l.zip_code,'0123456789'),left,right)),''));
														         

	self.Bus_prim_range    	      := BusAddr[1..10];
	self.Bus_predir 	      	  := BusAddr[11..12];
	self.Bus_prim_name 	  	      := BusAddr[13..40];
	self.Bus_addr_suffix   	      := BusAddr[41..44];
	self.Bus_postdir 	    	  := BusAddr[45..46];
	self.Bus_unit_desig 	  	  := BusAddr[47..56];
	self.Bus_sec_range 	  	      := BusAddr[57..64];
	self.Bus_p_city_name	  	  := BusAddr[65..89];
	self.Bus_v_city_name	  	  := BusAddr[90..114];
	self.Bus_st 			      := if(BusAddr[115..116] = '',
									  	    ziplib.ZipToState2(BusAddr[117..121]),
									  	    BusAddr[115..116]);
	self.Bus_zip5 		      	  := BusAddr[117..121];
	self.Bus_zip4 		      	  := BusAddr[122..125];
	self.Bus_cart 		      	  := BusAddr[126..129];
	self.Bus_cr_sort_sz 	 	  := BusAddr[130];
	self.Bus_lot 		      	  := BusAddr[131..134];
	self.Bus_lot_order 	  	      := BusAddr[135];
	self.Bus_dpbc 		      	  := BusAddr[136..137];
	self.Bus_chk_digit 	  	      := BusAddr[138];
	self.Bus_addr_rec_type	 	  := BusAddr[139..140];
	self.Bus_fips_state	  	      := BusAddr[141..142];
	self.Bus_fips_county 	  	  := BusAddr[143..145];
	self.Bus_geo_lat 	    	  := BusAddr[146..155];
	self.Bus_geo_long 	    	  := BusAddr[156..166];
	self.Bus_cbsa 		      	  := BusAddr[167..170];
	self.Bus_geo_blk              := BusAddr[171..177];
	self.Bus_geo_match 	  	      := BusAddr[178];
	self.Bus_err_stat 	    	  := BusAddr[179..182];
	self.Filing_Number		      :=trim(l.Filing_Number,left,right);  
	self.Filing_Date			  :=stringlib.stringfilter(l.Filing_Date, '0123456789'); 
	self.Insert_Date			  :=stringlib.stringfilter(l.Insert_Date, '0123456789');
	self.bus_phone                :=stringlib.stringfilter(l.telephone, '0123456789');
	self.Name_type                :=trimUpper(l.Name_type)    	; 
	self.Name_Code                :=trimUpper(l.Name_Code)    	; 
	self.Record_Code              :=trimUpper(l.Record_Code)    	; 
	self.Location_Code            :=trim(l.Location_Code,left,right); 
	self.Filing_state             :=trimUpper(l.Filing_state);
    self					  	  := l;
  end;																 


		Clean_AllStates	 	          := project( FilingName,Trans_slim(left));
		export cleaned_fbn_experian_business   :=Clean_AllStates	:persist(cluster.cluster_out+'persist::FBNV2::CleanedFBN_Experian_business');