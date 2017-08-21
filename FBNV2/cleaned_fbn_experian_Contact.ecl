
import lib_stringlib,Address;

trimUpper(string s) := function
		  return trim(stringlib.StringToUppercase(s),left,right);
		  end;
		  
  FilingName	:=	File_fbn_experian_in(trimUpper(Name_type)='O');
  

	// when Name_type='O' it's contact name and when Name_type='B' it's Business name .	
	
 Layout_fbn_experian.Layout_Slim_Clean_cont Trans_slim(FilingName l) := transform

    string73 ContName         	  := stringlib.StringToUppercase(Address.CleanPerson73(trim(l.Name,left,right)));	
	self.OfficerName			  := trimUpper(trim(l.Name,left,right));												 													 
	self.title		              := ContName[1..5];
	self.fname	                  := ContName[6..25];
	self.mname	                  := ContName[26..45];
	self.lname		              := ContName[46..65];
	self.name_suffix	      	  := ContName[66..70];
	self.name_score	           	  := ContName[71..73];
	string182 ContactAddr         := stringlib.StringToUppercase(if(trim(l.address,left,right) <> '' or
																 trim(l.city,left,right)  <> '' or
	  	                                                         trim(l.state,left,right) <> '' or
															     trim(l.zip_code,left,right)   <> '' ,
															     Address.CleanAddress182(trim(l.address,left,right),
																					trim(trim(l.city,left,right) + ', ' +
																						 trim(l.state,left,right) + ' ' +
																						 lib_stringlib.stringlib.stringfilter(l.zip_code,'0123456789'),left,right)),''));
							
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
	self.Filing_Number		          :=trim(l.Filing_Number,left,right);  
	self.Filing_Date			      :=stringlib.stringfilter(l.Filing_Date, '0123456789'); 
	self.Insert_Date			      :=stringlib.stringfilter(l.Insert_Date, '0123456789');
	self.Officer_phone                :=stringlib.stringfilter(l.telephone, '0123456789');
	self.Name_type                    :=trimUpper(l.Name_type)    	; 
	self.Name_Code                    :=trimUpper(l.Name_Code)    	; 
	self.Record_Code                  :=trimUpper(l.Record_Code)    	; 
	self.Location_Code                :=trim(l.Location_Code,left,right); 
    self					  		  := l;
  end;											

		Clean_AllStates	 	          := project( FilingName,Trans_slim(left));
		export cleaned_fbn_experian_Contact   :=Clean_AllStates	:persist(cluster.cluster_out+'persist::FBNV2::CleanedFBN_Experian_Contact');
