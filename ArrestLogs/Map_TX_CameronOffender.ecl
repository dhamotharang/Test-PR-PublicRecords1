import Crim_Common, Address, lib_date;

p	:= ArrestLogs.file_TX_Cameron;

fCameron := p(trim(p.Name,left,right)<>'Name' and
			regexfind('[A-Z]',trim(p.Name,left,right),0)<>'');

Crim_Common.Layout_In_Court_Offender tCameron(fCameron input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= 'F2'+trim(input.Book_Num,left,right)+fSlashedMDYtoCYMD(input.Book_Dt);
self.vendor				:= 'F2';
self.state_origin		:= 'TX';
self.data_type			:= '5';
self.source_file		:= '(CV)TX-CameronCtyArr';
self.case_number		:= '';
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if((fSlashedMDYtoCYMD(input.book_dt) < Crim_Common.Version_In_Arrest_Offender) 
							and fSlashedMDYtoCYMD(input.book_dt)[1..2] between '19' and '20',
							fSlashedMDYtoCYMD(input.book_dt),
							'');
self.pty_nm				:= trim(input.name,left,right);
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
self.dob				:= fSlashedMDYtoCYMD(input.dob);
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= if(input.race<>'UNKNOWN',
							input.race,
							'');
self.sex				:= if(input.sex[1] in ['F','M'],
							input.sex[1],
							'');
self.hair_color			:= if(input.hair_color in ['BAL','BLK','BLN','BLO','BRN','BRO','GRY','RED','SDY','WHI'],
							input.hair_color,
							'');
self.hair_color_desc	:= MAP(input.hair_color='BAL' => 'BALD',   
							input.hair_color='BLK' => 'BLACK', 
							input.hair_color='BLN' => 'BLOND',
							input.hair_color='BLO' => 'BLOND',
							input.hair_color='BRO' => 'BROWN',
							input.hair_color='BRN' => 'BROWN', 
							input.hair_color='GRY' => 'GREY',   
							input.hair_color='RED' => 'RED',      
							input.hair_color='SDY' => 'SANDY', 
							input.hair_color='WHI' => 'WHITE', 
							input.hair_color='XXX' => '' ,'');
self.eye_color			:= if(input.eye_color in ['BLK','BLU','BRN','BRO','GRN','GRY','HAZ','HZL','MAR','MUL','PNK'],
							input.eye_color,
							'');
self.eye_color_desc		:= MAP(input.eye_color ='BLK' => 'BLACK',
							input.eye_color ='BLU' => 'BLUE',
							input.eye_color ='BRN' => 'BROWN',
							input.eye_color ='BRO' => 'BROWN',
							input.eye_color ='GRN' => 'GREEN',        
							input.eye_color ='GRY' => 'GREY',
							input.eye_color ='HAZ' => 'HAZEL',
							input.eye_color ='HZL' => 'HAZEL',
							input.eye_color ='MAR' => 'MAROON',
							input.eye_color ='MUL' => 'MULTI',
							input.eye_color ='PNK' => 'PINK',
							input.eye_color ='XXX' => '','');
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= if((string)((integer)regexreplace('\'|'+'\"',trim(input.height,all),'')[1]*12+(integer)regexreplace('\'|'+'\"',trim(input.height,all),'')[2..3]) between '48' and '84',
                            (string)((integer)regexreplace('\'|'+'\"',trim(input.height,all),'')[1]*12+(integer)regexreplace('\'|'+'\"',trim(input.height,all),'')[2..3]),
							'');
self.weight				:= if(regexreplace('lbs',input.weight,'') between '050' and '500',
							regexreplace('lbs',input.weight,''),
							'');
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

pCameron := project(fCameron, tCameron(left));

ArrestLogs.ArrestLogs_clean(pCameron,cleanCameron);

//arrOut:= cleanCameron + ArrestLogs.FileAbinitioOffender(vendor='');

dd_arrOut:= dedup(sort(distribute(cleanCameron,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,party_status_desc,local)
										,offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Arrestlogs_TX_Cameron_Offender');

export Map_TX_CameronOffender := dd_arrOut;