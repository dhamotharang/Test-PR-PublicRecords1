import crim_common, Crim, Address;

d := crim.File_OH_Hamilton(trim(Name,left,right)[1] ~in ['','+','.','0','1','2','3','4','5','6','7','8','9','0']);

Crim_Common.Layout_In_Court_Offender tOHOffend(d input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 		:= '1R'+fSlashedMDYtoCYMD(input.filed_dt)+hash(trim(input.name,all)+input.case_num);
self.vendor				:= '1R';
self.state_origin		:= 'OH';
self.data_type			:= '2';
self.source_file		:= 'OH Hamilton CRIM CT';
self.case_number		:= trim(input.case_num,left,right);
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(trim(input.filed_dt,left,right))[1..2] between '19' and '20',
							fSlashedMDYtoCYMD(trim(input.filed_dt,left,right)),
							'');
self.pty_nm				:= regexreplace('AKA',input.name,'');
self.pty_nm_fmt			:= 'F';
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
self.dob				:= if(fSlashedMDYtoCYMD(trim(input.dob,left,right))[1..4] between '1900' and '1989'
							and fSlashedMDYtoCYMD(trim(input.dob,left,right))<>'19010101',
							fSlashedMDYtoCYMD(trim(input.dob,left,right)),
							'');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= MAP(trim(input.race,left,right) = 'WHITE' => 'White',
								trim(input.race,left,right) ='BLACK - AFRICAN AMERICAN' => 'Black',
								trim(input.race,left,right) ='HISPANIC' => 'Hispanic', 
								trim(input.race,left,right) ='M'=> 'Hispanic',
								trim(input.race,left,right) ='INDIAN - NATIVE AMER/ESKIMO' => 'Indian',
								trim(input.race,left,right) ='ASIAN' => 'Asian',
								'');
self.sex				:= if(input.sex[1] in ['F','M'],
							input.sex[1],
							'');
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

pOHOffend := project(d, tOHOffend(left));

Crim.Crim_clean(pOHOffend,cleanOHOffend);

fOHOffend := dedup(sort(distribute(cleanOHOffend,hash(offender_key)),
										offender_key,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,local),
										offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Crim_OH_Hamilton_Offender_Clean');

export Map_OH_Hamilton_Offender := fOHOffend;