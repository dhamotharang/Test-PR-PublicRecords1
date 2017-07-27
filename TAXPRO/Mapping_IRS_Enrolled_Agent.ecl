
dIn:=File_IRS_Enrolled_Agent_In;

layout.Taxpro_Base Trans(dIn PInput,unsigned8 c)
 :=TRANSFORM
		SELF.dt_last_seen        	  := (INTEGER)pInput.date_last_reported;
		SELF.dt_first_seen	     	  := (INTEGER)pInput.date_first_reported;
		SELF.dt_vendor_first_reported := (INTEGER)pInput.date_first_reported;
		SELF.dt_vendor_last_reported  := (INTEGER)pInput.date_LAST_reported;
		self.tmsid                    := 'E'+c;
		SELF.source                   := 'Enrolled_Agent';
		SELF.company			 	  := '';	
		SELF.occupation		          := '';	
		SELF.title			 		  := pInput.pName[1..5];
		SELF.fname			 		  := pInput.pName[6..25];
		SELF.mname			 		  := pInput.pName[26..45];
		SELF.lname			 		  := pInput.pName[46..65];
		SELF.name_suffix	          := pInput.pName[66..70];
		SELF.name_score	 		      := pInput.pName[71..73];
		SELF.prim_range	 		      := pInput.clean_address[1..10];
		SELF.predir	 		      	  := pInput.clean_address[11..12];
		SELF.prim_name	 		      := pInput.clean_address[13..40];
		SELF.suffix	 		          := pInput.clean_address[41..44];
		SELF.postdir	 		      := pInput.clean_address[45..46];
		SELF.unit_desig	 		      := pInput.clean_address[47..56];
		SELF.sec_range	 		      := pInput.clean_address[57..64];
		SELF.p_city_name	 		  := pInput.clean_address[65..89];
		SELF.v_city_name	 		  := pInput.clean_address[90..114];
		SELF.st 					  := pInput.clean_address[115..116];
		SELF.zip5 					  := pInput.clean_address[117..121];
		SELF.zip4 					  := pInput.clean_address[122..125];
		SELF.cart 					  := pInput.clean_address[126..129];
		SELF.cr_sort_sz	 		      := pInput.clean_address[130];
		SELF.lot 					  := pInput.clean_address[131..134];
		SELF.lot_order	 		      := pInput.clean_address[135];
		SELF.dpbc 					  := pInput.clean_address[136..137];
		SELF.chk_digit	 		      := pInput.clean_address[138];
		SELF.rec_type				  := pInput.clean_address[139..140];
		SELF.ace_fips_st	 		  := pInput.clean_address[141..142];
		SELF.ace_fips_county		  := pInput.clean_address[143..145];
		SELF.geo_lat	 		      := pInput.clean_address[146..155];
		SELF.geo_long	 		      := pInput.clean_address[156..166];
		SELF.msa 					  := pInput.clean_address[167..170];
		SELF.geo_blk	 		      := pInput.clean_address[171..177];
		SELF.geo_match	 		      := pInput.clean_address[178];
		SELF.err_stat	 		      := pInput.clean_address[179..182];
		SELF.county					  := pInput.clean_address[143..145];
		SELF					 	  := pInput;
  END;
  
dOut:=PROJECT(dIn,trans(left,counter)): persist('persist::Taxpro::IRS_Enrolled_agent');

export Mapping_IRS_Enrolled_Agent := dOut;