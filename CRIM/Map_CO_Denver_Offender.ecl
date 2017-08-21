import crim_common, Crim, Address;

d := crim.File_CO_Denver;

Crim_Common.Layout_In_Court_Offender tCOOffend(d input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= '1J'+hash(trim(input.case_num,left,right)+trim(input.id,left,right)+fSlashedMDYtoCYMD(input.dob)+regexreplace('AKA',input.firstname,'')+regexreplace('AKA',input.lastname,''));
self.vendor				:= '1J';
self.state_origin		:= 'CO';
self.data_type			:= '2';
self.source_file		:= 'CO DENVER CRIM CT';
self.case_number		:= trim(input.case_num,left,right);
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(input.dt_filed)[1..2] between '19' and '20' and fSlashedMDYtoCYMD(input.dt_filed)[1..8] <> '19010101',
							fSlashedMDYtoCYMD(input.dt_filed),
							'');
self.pty_nm				:= regexreplace('AKA',input.firstname,'')+' '+regexreplace('AKA',input.lastname,'');
self.pty_nm_fmt			:= 'F';
self.orig_lname			:= regexreplace('AKA',input.lastname,'');
self.orig_fname			:= regexreplace('AKA|'+',',input.firstname,'');     
self.orig_mname			:= regexreplace('AKA|'+',|'+'0',input.middlename,'');
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
self.dob				:= if(fSlashedMDYtoCYMD(input.dob)[1..4] between '1900' and '1989' and fSlashedMDYtoCYMD(input.dob)[1..8] <> '19010101',
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
self.race_desc			:= trim(input.race,left,right);
self.sex				:= '';
self.hair_color			:= '';
self.hair_color_desc	:= trim(input.hair,left,right);
self.eye_color			:= '';
self.eye_color_desc		:= trim(input.eyes,left,right);
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= if(trim(input.height,left,right)<>'' and ((integer)trim(input.height,left,right)[1]*12+(integer)trim(input.height,left,right)[2..3]) between 48 and 84,
							(string)((integer)trim(input.height,left,right)[1]*12+(integer)trim(input.height,left,right)[2..3]),
							'');
self.weight				:= if((integer)trim(input.weight,left,right) between 50 and 500 and length(trim(input.weight,left,right))=2,
							'0'+trim(input.weight,left,right),
							if((integer)trim(input.weight,left,right) between 50 and 500,
							trim(input.weight,left,right),
							''));
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

pCOOffend := project(d, tCOOffend(left));

Crim.Crim_clean(pCOOffend,cleanCOOffend);

fCOOffend := dedup(sort(distribute(cleanCOOffend,hash(offender_key)),
										offender_key,case_number,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,local),
										offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Crim_CO_Denver_Offender_Clean');

export Map_CO_Denver_Offender := fCOOffend;