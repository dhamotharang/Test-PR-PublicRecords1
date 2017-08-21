import Crim_Common, Address, lib_date;

p	:= ArrestLogs.file_GA_Bibb;

fBibb := p(trim(p.Name,left,right)<>'Name' and
			regexfind('[A-Z]',trim(p.Name,left,right),0)<>'');

Crim_Common.Layout_In_Court_Offender tBibb(fBibb input) := Transform

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= 'F1'+hash(trim(input.id[2..9],all)+
							LIB_Date.Date_MMDDYY_I2(regexreplace('-',input.arrest_dt,''))+
							input.name);
self.vendor				:= 'F1';
self.state_origin		:= 'GA';
self.data_type			:= '5';
self.source_file		:= '(CV)GA-BibbCtyArr';
self.case_number		:= '';
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= '';
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
self.dob				:= if(regexreplace('-',input.dob,'')[5..8] between '1916' and '1989',
							regexreplace('-',input.dob,'')[5..8]+
							regexreplace('-',input.dob,'')[1..2]+
							regexreplace('-',input.dob,'')[3..4],
							'');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= input.address;
self.street_address_2	:= input.city_state_zip;
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= input.race;
self.race_desc			:= MAP(input.race = 'W' => 'White',
								input.race ='B' => 'Black',
								input.race ='N' =>'Black',
								input.race ='O' => 'Other', 
								input.race ='H' => 'Hispanic', 
								input.race ='M' => 'Hispanic',
								input.race ='I' => 'Indian',
								input.race ='O' => 'Other',
								input.race ='A' => 'Asian',
								input.race ='J' => 'Japanese',
								input.race ='C' => 'Chinese',
								'');
self.sex				:= if(input.sex[1] in ['F','M'],
							input.sex[1],
							'');
self.hair_color			:= if(input.hair in ['BAL','BLK','BLN','BLO','BRN','BRO','GRY','RED','SDY','WHI'],
							input.hair,
							'');
self.hair_color_desc	:= MAP(input.hair='BAL' => 'BALD',   
							input.hair='BLK' => 'BLACK', 
							input.hair='BLN' => 'BLOND',
							input.hair='BLO' => 'BLOND',
							input.hair='BRO' => 'BROWN',
							input.hair='BRN' => 'BROWN', 
							input.hair='GRY' => 'GREY',   
							input.hair='RED' => 'RED',      
							input.hair='SDY' => 'SANDY', 
							input.hair='WHI' => 'WHITE', 
							input.hair='XXX' => '' ,'');
self.eye_color			:= if(input.eyes in ['BLK','BLU','BRN','BRO','GRN','GRY','HAZ','HZL','MAR','MUL','PNK'],
							input.eyes,
							'');
self.eye_color_desc		:= MAP(input.eyes ='BLK' => 'BLACK',
							input.eyes ='BLU' => 'BLUE',
							input.eyes ='BRN' => 'BROWN',
							input.eyes ='BRO' => 'BROWN',
							input.eyes ='GRN' => 'GREEN',        
							input.eyes ='GRY' => 'GREY',
							input.eyes ='HAZ' => 'HAZEL',
							input.eyes ='HZL' => 'HAZEL',
							input.eyes ='MAR' => 'MAROON',
							input.eyes ='MUL' => 'MULTI',
							input.eyes ='PNK' => 'PINK',
							input.eyes ='XXX' => '','');
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= if((string)((integer)regexreplace('\'|'+'\"',trim(input.height,all),'')[1]*12+(integer)regexreplace('\'|'+'\"',trim(input.height,all),'')[2..3]) between '48' and '84',
                            (string)((integer)regexreplace('\'|'+'\"',trim(input.height,all),'')[1]*12+(integer)regexreplace('\'|'+'\"',trim(input.height,all),'')[2..3]),
							'');
self.weight				:= if(regexreplace('lbs',input.weight,'') between '050' and '500',
							regexreplace('lbs',input.weight,''),
							'');
self.party_status		:= '';
self.party_status_desc	:= trim(input.Still_In_Jail,left,right);
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

pBibb := project(fBibb, tBibb(left));

ArrestLogs.ArrestLogs_clean(pBibb,cleanBibb);

//arrOut:= cleanBibb + ArrestLogs.FileAbinitioOffender(vendor='');

dd_arrOut:= dedup(sort(distribute(cleanBibb,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,party_status_desc,local)
										,offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Arrestlogs_GA_Bibb_Offender');

export Map_GA_BibbOffender := dd_arrOut;