import Crim_Common, Address;

p	:= file_ID_Canyon(name<>'Name');


Crim_Common.Layout_In_Court_Offender tCanyon(p input) := Transform
 flag_space := Stringlib.StringFind(trim(input.name,right),' ', 2)>0  ;

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= 'F6'+trim(input.ID,left,right);
self.vendor				:= 'F6';
self.state_origin		:= 'ID';
self.data_type			:= '5';
self.source_file		:= '(CV)ID-CanyonArr';
self.case_number		:= '';
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= '';
self.pty_nm				:= input.name;
self.pty_nm_fmt			:= 'F';
self.orig_Lname			:= '';//IF(flag_space,input.name[Stringlib.StringFind(input.name,' ', 2)+1..],input.name[Stringlib.StringFind(input.name,' ', 1)+1..]);
self.orig_fname			:= '';//input.name[1..Stringlib.StringFind(input.name,' ', 1)-1];
self.orig_mname			:= '';//IF(flag_space,input.name[Stringlib.StringFind(input.name,' ', 1)+1..Stringlib.StringFind(input.name,' ', 2)-1],'');
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
self.street_address_1	:= '';
self.street_address_2	:= '';
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


pCanyon := project(p, tCanyon(left));

ArrestLogs.ArrestLogs_clean(pCanyon,cleanCanyon);

dd_arrOut := dedup(sort(distribute(cleanCanyon,hash(offender_key)),
										offender_key,pty_typ,lname,fname,mname,local)
										,offender_key,pty_typ,lname,fname,local,right): 
										PERSIST('~thor_dell400::persist::Arrestlogs_ID_Canyon_Offender');

export map_ID_CanyonOffender := dd_arrOut;