IMPORT crim_common, Crim, Address, ut;

ds := crim.file_fl_lake_traffic;

Crim_Common.Layout_In_Court_Offender tr_ds_offender(ds dInput) := Transform
UpperFName						:= ut.CleanSpacesAndUpper(dInput.fname);
UpperLName						:= ut.CleanSpacesAndUpper(dInput.lname);
UpperMName						:= ut.CleanSpacesAndUpper(dInput.mname);
UpperSuffix						:= ut.CleanSpacesAndUpper(dInput.suffix);
ClnDate								:= ut.date_slashed_MMDDYYYY_to_YYYYMMDD(dInput.filing_date);
self.process_date		  := Crim_Common.Version_Development;
self.offender_key 		:= '63'+hash(UpperFName,UpperLName,UpperMName)+ClnDate;
self.vendor				    := '63';
self.state_origin		  := 'FL';
self.data_type			  := '2';
self.source_file		  := 'FL-LAKE_CTY_TRAFFIC';
self.case_number		  := '';
self.case_court			  := '';
self.case_name			  := '';
self.case_type			  := '';
self.case_type_desc		:= '';
self.case_filing_dt		:= ClnDate;
self.pty_nm				    := StringLib.StringCleanSpaces(UpperFName+' '+UpperMName+' '+UpperLName+' '+UpperSuffix);
self.pty_nm_fmt			  := 'F';
self.orig_lname			  := UpperLName;
self.orig_fname			  := UpperFName;     
self.orig_mname			  := UpperMName;
self.orig_name_suffix	:= UpperSuffix;
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
self.street_address_1	:= ut.CleanSpacesAndUpper(dInput.Address1);
self.street_address_2	:= IF(length(trim(dInput.Address2,left,right)) = 1, '', ut.CleanSpacesAndUpper(dInput.Address2));
self.street_address_3	:= ut.CleanSpacesAndUpper(dInput.city); 
self.street_address_4	:= ut.CleanSpacesAndUpper(dInput.state);
self.street_address_5	:= IF(trim(dInput.zip,left,right) = '' and length(trim(dInput.blank2,left,right)) = 4 and length(trim(dInput.Address2,left,right)) = 1,
													trim(dInput.Address2,left,right)+trim(dInput.blank2,left,right),trim(dInput.zip,left,right));
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

proj_ds_offender := project(ds, tr_ds_offender(left));

Crim.Crim_clean(proj_ds_offender,clean_ds_offender);

sd_ds_offender := dedup(sort(distribute(clean_ds_offender,hash(offender_key)),
										offender_key,pty_nm,pty_nm_fmt,pty_typ,local),
										RECORD,local): 
										PERSIST('~thor_dell400::persist::Crim_FL_Lake_Traffic_Offender_Clean');


EXPORT Map_FL_Lake_Traffic_Offender := sd_ds_offender;