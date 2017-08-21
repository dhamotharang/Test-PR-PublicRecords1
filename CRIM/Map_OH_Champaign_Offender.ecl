import crim_common, Crim, Address;

/*Input File*/
df := CRIM.File_OH_Champaign;


Crim_Common.Layout_In_Court_Offender cr_df_offender(df input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_Development;
//self.offender_key 		:= '1E'+ hash(input.Name, input.DateOfBirth, input.DateFiled);
self.offender_key 		:= '1E'+ input.CaseNumber;
self.vendor				:= '1E';
self.state_origin		:= 'OH';
self.data_type			:= '2';
self.source_file		:= 'OH-ChampaignCrm';
self.case_number		:= trim(input.CaseNumber,left,right);
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(input.DateFiled) < '19600000' or fSlashedMDYtoCYMD(input.DateFiled) < fSlashedMDYtoCYMD(input.DateArrested)
                           or fSlashedMDYtoCYMD(input.DateFiled) > Crim_Common.Version_Development, '', fSlashedMDYtoCYMD(input.DateFiled));
self.pty_nm				:= trim(Stringlib.StringToUpperCase(input.Name),left,right);
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= '';
self.orig_fname			:= '';     
self.orig_mname			:= '';
self.orig_name_suffix	:= '';
self.pty_typ			:= '0';
self.nitro_flag			:= '';
self.orig_ssn			:= '';
self.dle_num			:= '';
self.fbi_num			:= '';
self.doc_num			:= '';
self.ins_num			:= '';
self.id_num				:= '';
self.dl_num				:= trim(input.DriversLicenseNumber, left,right);
self.dl_state			:= trim(input.DriversLicenseState, left,right);
self.citizenship		:= '';
self.dob				:= if(fSlashedMDYtoCYMD(input.DateOfBirth) < '19300000','', fSlashedMDYtoCYMD(input.DateOfBirth));
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= trim(Stringlib.StringToUpperCase(input.Street),left,right);
self.street_address_2	:= trim(Stringlib.StringToUpperCase(input.City),left,right);
self.street_address_3	:= trim(Stringlib.StringToUpperCase(input.State),left,right);
self.street_address_4	:= trim(input.Zip,left,right);
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= '';
self.sex				:= '';
self.hair_color			:= '';
self.hair_color_desc	:= '';
self.eye_color			:= '';
self.eye_color_desc		:= '';
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= '';
self.weight				:= '';
self.party_status		:= '';
self.party_status_desc  := '';
self.prim_range 		:= ''; 
self.predir 			:= '';					   
self.prim_name 			:= '';
self.addr_suffix 		:= '';
self.postdir 			:= '';
self.unit_desig 		:= '';
self.sec_range 			:= '';
self.p_city_name 		:= '';
self.v_city_name 		:= '';
self.state 				:= '';
self.zip5 				:= '';
self.zip4 				:= '';
self.cart 				:= '';
self.cr_sort_sz 		:= '';
self.lot 				:= '';
self.lot_order 			:= '';
self.dpbc 				:= '';
self.chk_digit 			:= '';
self.rec_type 			:= '';
self.ace_fips_st		:= '';
self.ace_fips_county	:= '';
self.geo_lat 			:= '';
self.geo_long 			:= '';
self.msa 				:= '';
self.geo_blk 			:= '';
self.geo_match 			:= '';
self.err_stat 			:= '';
self.title 				:= '';
self.fname 				:= '';
self.mname 				:= '';
self.lname 				:= '';
self.name_suffix 		:= '';
self.cleaning_score 	:= ''; 
end;

proj_df_offender := project(df, cr_df_offender(left));

///////////////////////////////////////////////////////////////////////////////
Crim.Crim_clean(proj_df_offender,clean_df_offender);

sd_df_offender := dedup(sort(distribute(clean_df_offender,hash(offender_key)),
										offender_key,pty_nm,pty_nm_fmt,pty_typ,case_number,case_filing_dt,local),
										offender_key,pty_nm,pty_nm_fmt,pty_typ,case_number,local,left): 
										PERSIST('~thor_dell400::persist::Crim_OH_Champaign_Offender_Clean');

export Map_OH_Champaign_Offender := sd_df_offender;