import crim_common, Crim, Address;

//Records with no aliases
d1 := crim.File_FL_Marion(FirstName<>'FirstName');

Crim_Common.Layout_In_Court_Offender tFLOffend(d1 input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= '2M'+hash(trim(input.CaseNumber,left,right)+fSlashedMDYtoCYMD(trim(input.FileDate,left,right))+trim(input.LastName,left,right)+trim(input.FirstName,left,right)+trim(input.MiddleName,left,right));
self.vendor				:= '2M';
self.state_origin		:= 'FL';
self.data_type			:= '2';
self.source_file		:= 'FL MARION CRIM CT';
self.case_number		:= trim(input.CaseNumber,left,right);
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(input.FileDate)[1..2] between '19' and '20',
							fSlashedMDYtoCYMD(input.FileDate),
							'');
self.pty_nm				:= trim(input.LastName,left,right)+', '+trim(input.FirstName,left,right)+' '+trim(input.MiddleName,left,right);
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= trim(input.LastName,left,right);
self.orig_fname			:= trim(input.FirstName,left,right);     
self.orig_mname			:= trim(input.MiddleName,left,right);
self.orig_name_suffix	:= '';
self.pty_typ			:= '0';
self.nitro_flag			:= '';
self.orig_ssn			:= '';
self.dle_num			:= '';
self.fbi_num			:= '';
self.doc_num			:= '';
self.ins_num			:= '';
self.id_num				:= '';
self.dl_num				:= '';
self.dl_state			:= '';
self.citizenship		:= '';
self.dob				:= if(((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)fSlashedMDYtoCYMD(input.DateOfBirth)[1..4])>=18,
							regexreplace('\\*\\*\\*\\*', fSlashedMDYtoCYMD(input.DateOfBirth), ''),
							'');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
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
self.party_status_desc	:= '';
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

pFLOffend_no_aliases := project(d1, tFLOffend(left));


//Records with aliases
d2 := crim.File_FL_Marion(FirstName<>'FirstName' and alias<>'');

Crim_Common.Layout_In_Court_Offender tFLOffend2(d2 input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= '2M'+hash(trim(input.CaseNumber,left,right)+fSlashedMDYtoCYMD(trim(input.FileDate,left,right))+trim(input.LastName,left,right)+trim(input.FirstName,left,right)+trim(input.MiddleName,left,right));
self.vendor				:= '2M';
self.state_origin		:= 'FL';
self.data_type			:= '2';
self.source_file		:= 'FL MARION CRIM CT';
self.case_number		:= trim(input.CaseNumber,left,right);
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(input.FileDate)[1..2] between '19' and '20',
							fSlashedMDYtoCYMD(input.FileDate),
							'');
self.pty_nm				:= trim(input.alias,left,right);
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= '';
self.orig_fname			:= '';     
self.orig_mname			:= '';
self.orig_name_suffix	:= '';
self.pty_typ			:= '2';
self.nitro_flag			:= '';
self.orig_ssn			:= '';
self.dle_num			:= '';
self.fbi_num			:= '';
self.doc_num			:= '';
self.ins_num			:= '';
self.id_num				:= '';
self.dl_num				:= '';
self.dl_state			:= '';
self.citizenship		:= '';
self.dob				:= if(((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)fSlashedMDYtoCYMD(input.DateOfBirth)[1..4])>=18,
							regexreplace('\\*\\*\\*\\*', fSlashedMDYtoCYMD(input.DateOfBirth), ''),
							'');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
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
self.party_status_desc	:= '';
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

pFLOffend_aliases := project(d2, tFLOffend2(left));
pFLOffend := pFLOffend_no_aliases + pFLOffend_aliases;

Crim.Crim_clean(pFLOffend,cleanFLOffend);

fFLOffend := dedup(sort(distribute(cleanFLOffend,hash(offender_key)),
										offender_key,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,local),
										offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Crim_FL_Marion_Offender_Clean');

export Map_FL_Marion_Offender := fFLOffend;