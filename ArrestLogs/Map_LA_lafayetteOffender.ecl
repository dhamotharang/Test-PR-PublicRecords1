import Crim_Common, Address;

p	:= file_LA_lafayette(name<>'Name');

Crim_Common.Layout_In_Court_Offender tada(p input) := Transform
self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= 'F8'+HASH(trim(input.ID,left,right));
self.vendor				:= 'F8';
self.state_origin		:= 'LA';
self.data_type			:= '5';
self.source_file		:= '(CV)LA-LAFAYETTEArr';
self.case_filing_dt     := '';
self.case_number		:= '';
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.pty_nm				:= input.name;
self.pty_nm_fmt			:= 'L';
self.orig_fname			:= '';
self.orig_lname			:= '';
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
self.dl_num				:= '';
self.dl_state			:= '';
self.citizenship		:= '';
self.dob				:= '';
self.dob_alias			:= ''; 
self.place_of_birth		:= '';
self.street_address_1	:= IF(LENGTH(trim(REGEXREPLACE('^[0]+|[0]+$',input.address,''),left,right))>4,REGEXREPLACE('^0+|[0]+$',input.address,''),''); 
self.street_address_2	:= IF(input.city_state[1]<'A', '',input.city_state);
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:='' ;
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


pada := project(p, tada(left));

ArrestLogs.ArrestLogs_clean(pada,cleanada);

dd_arrOut := dedup(sort(distribute(cleanada,hash(offender_key)),
								   offender_key,pty_nm,street_address_1,street_address_2,local)
									,offender_key,pty_nm,street_address_1,street_address_2,local): 
									PERSIST('~thor_dell400::persist::Arrestlogs_la_lafayette_Offender');

export map_la_lafayetteOffender := dd_arrOut;