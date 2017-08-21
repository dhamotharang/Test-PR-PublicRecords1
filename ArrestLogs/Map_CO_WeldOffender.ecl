import Crim_Common, Address, lib_date;

p	:= ArrestLogs.file_CO_Weld_new;

ArrestLogs.Layout_CO_Weld sWeld(p input) := Transform
self := input;
end;

rWeld := project(p, sWeld(left));

p2	:= ArrestLogs.file_CO_Weld+rWeld;

fWeld := p2(trim(p2.Name,left,right)<>'Name'); 

Crim_Common.Layout_In_Court_Offender tWeld(fWeld input) := Transform
 
self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= (string)'D9'+hash(trim(input.Name,all))+lib_date.Date_MMDDYY_I2(regexreplace('/',input.arrested,''));
self.vendor				:= 'D9';//NEED TO UPDATE
self.state_origin		:= 'CO';
self.data_type			:= '5';
self.source_file		:= '(CV)CO-WeldCtyArr';
self.case_number		:= '';
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if((string)lib_date.Date_MMDDYY_I2(regexreplace('/',input.arrested,'')) < Crim_Common.Version_In_Arrest_Offender
							and lib_date.Date_MMDDYY_I2(regexreplace('/',input.arrested,''))[1..2] in ['19','20'],
							(string)lib_date.Date_MMDDYY_I2(regexreplace('/',input.arrested,'')),'');
self.pty_nm				:= trim(input.Name,left,right);
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
self.dl_num				:= '';
self.dl_state			:= '';
self.citizenship		:= '';
self.dob				:= if(lib_date.Date_MMDDYY_I2(regexreplace('/',input.DOB,''))[1..4] between '1916' and '1989',
							(string)lib_date.Date_MMDDYY_I2(regexreplace('/',input.DOB,'')),'');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= '';
self.sex				:= trim(input.Gender[1],left,right);
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

pWeld := project(fWeld, tWeld(left));

ArrestLogs.ArrestLogs_clean(pWeld,cleanWeld);

//arrOut:= cleanWeld + ArrestLogs.FileAbinitioOffender(vendor='');

dd_arrOut:= dedup(sort(distribute(cleanWeld,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,source_file,local)
										,offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Arrestlogs_CO_Weld_Offender');

export Map_CO_WeldOffender := dd_arrOut;