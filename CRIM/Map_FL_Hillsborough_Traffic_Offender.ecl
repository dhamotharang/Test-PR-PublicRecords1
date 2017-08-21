import crim_common, Crim, Address;

/*Input File*/
df := crim.File_FL_Hillsborough_Traffic;

Crim_Common.Layout_In_Court_Offender tr_df_offender(df input) := Transform

self.process_date		  := Crim_Common.Version_Development;
self.offender_key 		:= '26'+trim(input.Uniform_Case_Number,left,right);
self.vendor				    := '26';
self.state_origin		  := 'FL';
self.data_type			  := '2';
self.source_file		  := 'FL-HILLSBOROUGH-DMV';
self.case_number		  := trim(input.Uniform_Case_Number,left,right);
self.case_court			  := '';
self.case_name			  := '';
self.case_type			  := '';
self.case_type_desc		:= '';
self.case_filing_dt		:= '';
self.pty_nm				    := regexreplace('\\*',input.Defendant_Name, '');
self.pty_nm_fmt			  := 'L';
self.orig_lname			  := '';
self.orig_fname			  := '';     
self.orig_mname			  := '';
self.orig_name_suffix	:= '';
self.pty_typ			    := '0';
self.nitro_flag			  := '';
self.orig_ssn			    := '';
self.dle_num			    := '';
self.fbi_num			    := '';
self.doc_num			    := '';
self.ins_num			    := '';
self.id_num				    := '';
self.dl_num				    := '';
self.dl_state			    := '';
self.citizenship		  := '';
self.dob				      := '';
self.dob_alias			  := '';
self.place_of_birth		:= '';
self.street_address_1	:= regexreplace('\\*',trim(input.Defendant_Address,left,right),'');
self.street_address_2	:= regexreplace('\\*',trim(input.Defendant_City_State,left,right),'');
self.street_address_3	 := regexreplace('\\*',trim(input.Defendant_Zip,left,right),'');
self.street_address_4	 := '';
self.street_address_5	 := '';
self.race				       := '';
self.race_desc			   := '';
self.sex				       := '';
self.hair_color			   := '';
self.hair_color_desc	 := '';
self.eye_color			   := '';
self.eye_color_desc		 := '';
self.skin_color			   := '';
self.skin_color_desc	 := '';
self.height				     := '';
self.weight				     := '';
self.party_status		   := '';
self.party_status_desc := '';
self.prim_range 		   := ''; 
self.predir 			     := '';					   
self.prim_name 			   := '';
self.addr_suffix 		   := '';
self.postdir 			     := '';
self.unit_desig 		   := '';
self.sec_range 			   := '';
self.p_city_name 		   := '';
self.v_city_name 		   := '';
self.state 				     := '';
self.zip5 				     := '';
self.zip4 				     := '';
self.cart 				     := '';
self.cr_sort_sz 		   := '';
self.lot 				       := '';
self.lot_order 			   := '';
self.dpbc 				     := '';
self.chk_digit 			   := '';
self.rec_type 			   := '';
self.ace_fips_st		   := '';
self.ace_fips_county	 := '';
self.geo_lat 			     := '';
self.geo_long 			   := '';
self.msa 				       := '';
self.geo_blk 			     := '';
self.geo_match 			   := '';
self.err_stat 			   := '';
self.title 				     := '';
self.fname 				     := '';
self.mname 				     := '';
self.lname 				     := '';
self.name_suffix 		   := '';
self.cleaning_score 	 := ''; 
end;

proj_df_offender := project(df, tr_df_offender(left));

///////////////////////////////////////////////////////////////////////////////
Crim.Crim_clean(proj_df_offender,clean_df_offender);

sd_df_offender := dedup(sort(distribute(clean_df_offender,hash(offender_key)),
										offender_key,pty_nm,pty_nm_fmt,pty_typ,local),
										offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Crim_FL_Hillsborough_Traffic_Offender_Clean');

export Map_FL_Hillsborough_Traffic_Offender := sd_df_offender;