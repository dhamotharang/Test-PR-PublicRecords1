import OSHAIR,Business_Header_SS, Census_Data, Lib_AddrClean, lib_stringlib;

export Clean_OSHAIR_data (filedate) := macro

/*	
		Abbreviations of relevance:
		IMIS    - Integrated Management Information System
		DRVD    - Derived file
		b       - Means blank (empty field)
		DCA     - Debt Collection Agency, under contract of OSHA
		FTA     - Failure to Abate
		FAT/CAT - Fatality and/or Catastrophe - definition of catastrophe:
												Federal OSHA: 5 or more hospitalized injuries
												State   OSHA: Definitions vary
		ID      - Identification, usually not purely numeric
		MIS     - Old Management Information System, national office only
		NR/Nr   - Number
		SIC     - Standard Industrial Classification
		NAICS   - North American Industrial Classification System
		SOL     - OSHA SOLicitor, or, Office of an OSHA Solicitor
		State   - Usually identifies that group of approximately twenty-seven (27) states
				  that have their own OSH Haz_Sub plan approved Federal OSHA under authority
				  of the OSHA Act, paragraph 18(b)
		VIO     - Violation - Note that initially violations are alleged.  After certain procedures
				  have been completed, the alleged status is removed.
*/

input_OSHAIR := OSHAIR.File_in_OSHAIR(continuation_flag = ''    // Be sure to filter out all continuation records
                                   or continuation_flag = '1'); // since they are simply duplicate data

city_lookup := OSHAIR.File_City_Lookup;

fips_lookup := Census_Data.File_Fips2County;

layout_cleaned := OSHAIR.layout_OSHAIR_inspection_clean;

layout_cleaned city_added(input_OSHAIR L
                         ,city_lookup  R) := TRANSFORM

   string182 tempAddressReturn := Lib_AddrClean.AddrCleanLib.CleanAddress182(L.Inspected_Site_Street
                                                         , R.City_Name + ' ' 
														 + L.Inspected_Site_State + ' ' 
														 + INTFORMAT((INTEGER)L.Inspected_Site_Zip,5,1));

    self.Prev_Activity_Type_Desc      := OSHAIR.lookup_OSHAIR_Mini.Previous_Activity_lookup(L.Previous_Activity_Type);
	self.Compl_Officer_Job_Title_Desc := OSHAIR.lookup_OSHAIR_Mini.Compliance_Office_Title_lookup(L.Compliance_Officer_Job_Title);
	self.Own_Type_Desc                := OSHAIR.lookup_OSHAIR_Mini.Owner_Type_lookup(L.Owner_Type);
	self.Insp_Type_Desc               := OSHAIR.lookup_OSHAIR_Mini.Inspection_Type_lookup(L.Inspection_Type);
	self.Insp_Scope_Desc              := OSHAIR.lookup_OSHAIR_Mini.Inspection_Scope_lookup(L.Inspection_Scope);
	self.cname                        := lib_stringlib.StringLib.StringToUpperCase(L.Inspected_Site_Name);
	self.Inspected_Site_City_Name     := R.City_Name;
	self.SIC_Code                     := L.SIC_Code;
   	self.prim_range                   := tempAddressReturn[1..10];
	self.predir 	                  := tempAddressReturn[11..12];
	self.prim_name 	  	              := tempAddressReturn[13..40];
	self.addr_suffix  	              := tempAddressReturn[41..44];
	self.postdir 	    	          := tempAddressReturn[45..46];
	self.unit_desig   	              := tempAddressReturn[47..56];
	self.sec_range 	  	              := tempAddressReturn[57..64];
	self.p_city_name  	              := tempAddressReturn[65..89];
	self.v_city_name  	              := tempAddressReturn[90..114];
	self.st 	     		          := tempAddressReturn[115..116];
	self.zip5 		           	      := tempAddressReturn[117..121];
	self.zip4 		    	          := tempAddressReturn[122..125];
	self.cart      		    	      := tempAddressReturn[126..129];
	self.cr_sort_sz        	          := tempAddressReturn[130];
	self.lot 		           	      := tempAddressReturn[131..134];
	self.lot_order 	  	              := tempAddressReturn[135];
	self.dpbc      		    	      := tempAddressReturn[136..137];
	self.chk_digit      	  	      := tempAddressReturn[138];
	self.addr_rec_type  	          := tempAddressReturn[139..140];
	self.fips_state                   := tempAddressReturn[141..142];
	self.fips_county                  := tempAddressReturn[143..145];
	self.geo_lat 	    	          := tempAddressReturn[146..155];
	self.geo_long 	  	              := tempAddressReturn[156..166];
	self.cbsa 		      	          := tempAddressReturn[167..170];
	self.geo_blk   	  	              := tempAddressReturn[171..177];
	self.geo_match 	  	              := tempAddressReturn[178];
	self.err_stat 	  	              := tempAddressReturn[179..182];
    self                              := L;
end;


j_city := JOIN(input_OSHAIR
              ,city_lookup
			  ,left.Inspected_Site_State + INTFORMAT(left.Inspected_Site_City_Code,4,1)  = right.City_Code_ID
			      ,city_added(left,right)
			      ,LEFT OUTER
			      ,LOOKUP);

// layout_cleaned county_added(j_city       L
                           // ,fips_lookup  R) := TRANSFORM
   // self.Inspected_Site_County_Name := R.county_name;
   // self := L;
// end;

// j_county := JOIN(j_city
                // ,fips_lookup
			    // ,          left.Inspected_Site_State             = right.state_code
	         // AND INTFORMAT((INTEGER)left.Inspected_Site_County_Code,3,1)  = right.county_fips
			    // ,county_added(left,right)
			    // ,LEFT OUTER
			    // ,LOOKUP);

BDID_Matchset := ['A'];

Business_Header_SS.MAC_Add_BDID_Flex(j_city
                                    ,BDID_Matchset
									,cname
									,prim_range, prim_name, zip5,sec_range, st,''
									,FEIN_append
									,BDID
									,layout_cleaned
									,true, BDID_Score
									,OSHAIR_bdid_match);

Business_Header_SS.MAC_Add_FEIN_By_BDID(OSHAIR_bdid_match
                                       ,BDID
									   ,FEIN_append
									   ,OSHAIR_out_add_fein);

/* Generate the child dataset files */
OSHAIR.normalize_child_datasets(filedate);

output(distribute(OSHAIR_out_add_fein
                  ,hash32(OSHAIR_out_add_fein.Activity_Number))
	   ,
	   ,'~thor_data400::base::oshair::' + filedate + '::inspection',overwrite);
						  
endmacro;