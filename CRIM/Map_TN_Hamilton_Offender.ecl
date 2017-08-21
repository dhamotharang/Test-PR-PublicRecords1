import crim_common, Crim, Address;

d := crim.File_TN_Hamilton(trim(name,left,right)<>'' and regexfind('[0-9][0-9]',name,0)='');

Crim_Common.Layout_In_Court_Offender tTNOffend(d input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= '2U'+trim(input.casenumber,left,right)+fSlashedMDYtoCYMD(input.filing_dt);
self.vendor				:= '2U';
self.state_origin		:= 'TN';
self.data_type			:= '2';
self.source_file		:= 'TN HAMILTON CRIM CT';
self.case_number		:= trim(input.casenumber,left,right);
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(trim(input.filing_dt,left,right))<>'00000000' and 
							fSlashedMDYtoCYMD(trim(input.filing_dt,left,right))>='19' and fSlashedMDYtoCYMD(trim(input.filing_dt,left,right)) <=stringlib.GetDateYYYYMMDD(),
							fSlashedMDYtoCYMD(trim(input.filing_dt,left,right)),
							'');
self.pty_nm				:= trim(input.name,left,right);
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= trim(input.lastname,left,right);
self.orig_fname			:= trim(input.firstname,left,right);     
self.orig_mname			:= regexreplace('AKA|'+'[0-9]+|'+'-',trim(input.middlename,left,right),'');
self.orig_name_suffix	:= trim(input.suffix,left,right);
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
self.dob				:= if(trim(input.dob,left,right)[1..2]>='19' and 
							(integer)stringlib.GetDateYYYYMMDD()[1..4]-(integer)fSlashedMDYtoCYMD(input.dob)[1..4] >=18,
							fSlashedMDYtoCYMD(input.dob),
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

pTNOffend := project(d, tTNOffend(left));

Crim.Crim_clean(pTNOffend,cleanTNOffend);

fOHOffend := dedup(sort(distribute(cleanTNOffend,hash(offender_key)),
										offender_key,case_number,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,local),
										offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Crim_TN_Hamilton_Offender_Clean');

export Map_TN_Hamilton_Offender := fOHOffend;