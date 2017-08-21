
import lib_stringlib,Address;

trimUpper(string s) := function
		  return trim(stringlib.StringToUppercase(s),left,right);
		  end;
		  
  FilingName	:=	File_FBN_CP_HIST_In(trimUpper(CPS_REC_TYPE)='F') ;
  

	// when CPS_REC_TYPE='O' it's contact name and when CPS_REC_TYPE='F' it's Business name .	
	
Layout_FBN_CP_HIST. Layout_Slim_Clean_bus Trans_slim(FilingName l) := transform
    self.cname 			          := stringlib.StringToUppercase(if(trim(l.NAME_EXT,left,right)<>'',
											trim(l.Name,left,right)+trim(l.NAME_EXT,left,right),trim(l.Name,left,right)));	
	
		
	string182 BusAddr             := stringlib.StringToUppercase(if(trim(l.ADDR_1,left,right) <> '' or
															     trim(l.ADDR_2,left,right)  <> '' or
	  	                                                         trim(l.ADDR_3,left,right) <> '' or
																 trim(l.ADDR_CITY,left,right)  <> '' or
	  	                                                         trim(l.ADDR_ST,left,right) <> '' or
															     trim(l.ADDR_ZIP,left,right)   <> '' ,
															     Address.CleanAddress182(trim(l.ADDR_1,left,right)+' '+trim(l.ADDR_2,left,right)+' '+trim(l.ADDR_3,left,right),
																					trim(trim(l.ADDR_CITY,left,right) + ', ' +
																						 trim(l.ADDR_ST,left,right) + ' ' +
																						 lib_stringlib.stringlib.stringfilter(l.ADDR_ZIP,'0123456789'),left,right)),''));
														         

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
	
	self.CPS_FILE_ST1 	          	  :=trimUpper(l.CPS_FILE_ST1)  ;
	self.CPS_CNTY_NM		  		  :=trimUpper(l.CPS_CNTY_NM)  ;
	self.FILING_NUM1		          :=trim(l.FILING_NUM1,left,right);  
	self.FILING_DTE			          :=stringlib.stringfilter(l.FILING_DTE, '0123456789'); 
	self.INSERT_DTE			          :=stringlib.stringfilter(l.INSERT_DTE, '0123456789'); 
	self.LOCATION_CD1		          :=stringlib.stringfilter(l.LOCATION_CD1, '0123456789');
	self.bus_phone                    :=stringlib.stringfilter(l.PHONE, '0123456789');
	self.CPS_REC_TYPE                 :=trimUpper(l.CPS_REC_TYPE)    	; 
	self.CPS_NAM_TYPE                 :=trimUpper(l.CPS_NAM_TYPE)    	; 
    self					  		  := l;
  end;																 


		clean_FilingName 	 	    := project( FilingName,Trans_slim(left));
	
		export cleaned_FBN_CP_HIST_Business  :=clean_FilingName:persist(cluster.cluster_out+'persist::FBNV2::CleanedFBN_Hist_Business');
