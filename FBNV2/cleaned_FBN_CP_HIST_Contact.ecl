import lib_stringlib,Address;

trimUpper(string s) := function
		  return trim(stringlib.StringToUppercase(s),left,right);
		  end;
		  
  FilingName	:=	fbnv2.File_FBN_CP_HIST_In(trimUpper(CPS_REC_TYPE)='O') ;
  

	// when CPS_REC_TYPE='O' it's contact name and when CPS_REC_TYPE='F' it's Business name .	
	
fbnv2.Layout_FBN_CP_HIST.Layout_Slim_Clean_Cont Trans_slim(FilingName l) := transform

    string73 ContName         	  := stringlib.StringToUppercase(if(trim(l.NAME_EXT,left,right)<>'',
										Address.CleanPerson73(trim(l.Name,left,right)+trim(l.NAME_EXT,left,right)),Address.CleanPerson73(trim(l.Name,left,right))));	
   
	self.OfficerName			  :=stringlib.StringToUppercase(if(trim(l.NAME_EXT,left,right)<>'',
											trim(l.Name,left,right)+trim(l.NAME_EXT,left,right),trim(l.Name,left,right)));												 													 
	self.title		              := ContName[1..5];
	self.fname	                  := ContName[6..25];
	self.mname	                  := ContName[26..45];
	self.lname		              := ContName[46..65];
	self.name_suffix	      	  := ContName[66..70];
	self.name_score	           	  := ContName[71..73];

	
	string182 ContactAddr         :=stringlib.StringToUppercase(if(trim(l.ADDR_1,left,right) <> '' or
															     trim(l.ADDR_2,left,right)  <> '' or
	  	                                                         trim(l.ADDR_3,left,right) <> '' or
																 trim(l.ADDR_CITY,left,right)  <> '' or
	  	                                                         trim(l.ADDR_ST,left,right) <> '' or
															     trim(l.ADDR_ZIP,left,right)   <> '' ,
															     Address.CleanAddress182(trim(l.ADDR_1,left,right)+' '+trim(l.ADDR_2,left,right)+' '+trim(l.ADDR_3,left,right),
																					trim(trim(l.ADDR_CITY,left,right) + ', ' +
																						 trim(l.ADDR_ST,left,right) + ' ' +
																						 lib_stringlib.stringlib.stringfilter(l.ADDR_ZIP,'0123456789'),left,right)),''));
							
	self.Contact_prim_range    	      := ContactAddr[1..10];
	self.Contact_predir 	      	  := ContactAddr[11..12];
	self.Contact_prim_name 	  	      := ContactAddr[13..40];
	self.Contact_addr_suffix   	      := ContactAddr[41..44];
	self.Contact_postdir 	    	  := ContactAddr[45..46];
	self.Contact_unit_desig 	  	  := ContactAddr[47..56];
	self.Contact_sec_range 	  	      := ContactAddr[57..64];
	self.Contact_p_city_name	  	  := ContactAddr[65..89];
	self.Contact_v_city_name	  	  := ContactAddr[90..114];
	self.Contact_st 			      := if(ContactAddr[115..116] = '',
									  	    ziplib.ZipToState2(ContactAddr[117..121]),
									  	    ContactAddr[115..116]);
	self.Contact_zip5 		      	  := ContactAddr[117..121];
	self.Contact_zip4 		      	  := ContactAddr[122..125];
	self.Contact_cart 		      	  := ContactAddr[126..129];
	self.Contact_cr_sort_sz 	 	  := ContactAddr[130];
	self.Contact_lot 		      	  := ContactAddr[131..134];
	self.Contact_lot_order 	  	      := ContactAddr[135];
	self.Contact_dpbc 		      	  := ContactAddr[136..137];
	self.Contact_chk_digit 	  	      := ContactAddr[138];
	self.Contact_addr_rec_type	 	  := ContactAddr[139..140];
	self.Contact_fips_state	  	      := ContactAddr[141..142];
	self.Contact_fips_county 	  	  := ContactAddr[143..145];
	self.Contact_geo_lat 	    	  := ContactAddr[146..155];
	self.Contact_geo_long 	    	  := ContactAddr[156..166];
	self.Contact_cbsa 		      	  := ContactAddr[167..170];
	self.Contact_geo_blk              := ContactAddr[171..177];
	self.Contact_geo_match 	  	      := ContactAddr[178];
	self.Contact_err_stat 	    	  := ContactAddr[179..182];
	self.CPS_FILE_ST1 	          	  :=trimUpper(l.CPS_FILE_ST1)  ;
	self.CPS_CNTY_NM		  		  :=trimUpper(l.CPS_CNTY_NM)  ;
	self.FILING_NUM1		          :=trim(l.FILING_NUM1,left,right);  
	self.FILING_DTE			          :=stringlib.stringfilter(l.FILING_DTE, '0123456789'); 
	self.INSERT_DTE			          :=stringlib.stringfilter(l.INSERT_DTE, '0123456789'); 
	self.LOCATION_CD1		          :=stringlib.stringfilter(l.LOCATION_CD1, '0123456789');
	self.Officer_phone                :=stringlib.stringfilter(l.PHONE, '0123456789');
	self.CPS_REC_TYPE                 :=trimUpper(l.CPS_REC_TYPE)    	; 
	self.CPS_NAM_TYPE                 :=trimUpper(l.CPS_NAM_TYPE)    	; 
    self					  		  := l;
  end;																 


		clean_FilingName 	 	    := project( FilingName,Trans_slim(left));
	
		export cleaned_FBN_CP_HIST_Contact  :=	clean_FilingName:persist(cluster.cluster_out+'persist::FBNV2::CleanedFBN_Hist_contact');
