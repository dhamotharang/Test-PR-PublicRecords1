import Crim_Common, Address, lib_date;

p	:= ArrestLogs.file_FL_Lake;

fLake := p(trim(p.Name,left,right)<>'name' and
			regexfind('[A-Z]',trim(p.Name,left,right),0)<>'');

Crim_Common.Layout_In_Court_Offender tLake(fLake input) := Transform

searchpattern := '^(.*)/(.*)/(.*)$';
 
self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= 'E8'+(integer)hash(trim(input.Name,left,right)+if((REGEXFIND(searchpattern, input.book_dt_time, 3))[1..2] in ['19','20'],
							REGEXFIND(searchpattern, input.book_dt_time, 3)[1..4]+
							(string)intformat((integer)REGEXFIND(searchpattern, input.book_dt_time, 1), 2, 1)+
							(string)intformat((integer)REGEXFIND(searchpattern, input.book_dt_time, 2), 2, 1),
							''));
self.vendor				:= 'E8';//NEED TO UPDATE
self.state_origin		:= 'FL';
self.data_type			:= '5';
self.source_file		:= '(CV)FL-LakeCtyArr';
self.case_number		:= '';
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if((REGEXFIND(searchpattern, input.book_dt_time, 3))[1..2] in ['19','20']
							and REGEXFIND(searchpattern, input.book_dt_time, 3)[1..4]+
							(string)intformat((integer)REGEXFIND(searchpattern, input.book_dt_time, 1), 2, 1)+
							(string)intformat((integer)REGEXFIND(searchpattern, input.book_dt_time, 2), 2, 1) < Crim_Common.Version_In_Arrest_Offenses,
							REGEXFIND(searchpattern, input.book_dt_time, 3)[1..4]+
							(string)intformat((integer)REGEXFIND(searchpattern, input.book_dt_time, 1), 2, 1)+
							(string)intformat((integer)REGEXFIND(searchpattern, input.book_dt_time, 2), 2, 1),
							'');
self.pty_nm				:= regexreplace('\'', regexreplace(',',trim(input.name,left,right),' '), '');
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
self.dob				:= if(REGEXFIND(searchpattern, input.dob, 3)[1..4] between '1916' and '1989',
							REGEXFIND(searchpattern, input.dob, 3)[1..4]+
							(string)intformat((integer)REGEXFIND(searchpattern, input.dob, 1), 2, 1)+
							(string)intformat((integer)REGEXFIND(searchpattern, input.dob, 2), 2, 1),
							'');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= input.address+' '+input.apartment_num;
self.street_address_2	:= input.city_state_zip;
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= if(StringLib.StringToUppercase(input.ethnicity)[1] 
							in ['W','B','N','O','H','M','I','A','J','C','X','U'] and
							input.ethnicity <>'AMERI',
							StringLib.StringToUppercase(input.ethnicity)[1],
							'');
self.race_desc			:= MAP(input.ethnicity[1] = 'W' => 'White',
							   input.ethnicity[1] = 'B' => 'Black',
							   input.ethnicity[1] = 'N' => 'Black',
							   input.ethnicity[1] = 'O' => '',
							   input.ethnicity[1] = 'H' => 'Hispanic',
							   input.ethnicity[1] = 'M' => 'Hispanic',
							   input.ethnicity[1] = 'I' => 'Indian',
							   input.ethnicity[1] = 'A' => 'Asian',
							   input.ethnicity[1] = 'J' => 'Japanese',
							   input.ethnicity[1] = 'C' => 'Chinese',
							   input.ethnicity[1] = 'X' => '',
							   input.ethnicity[1] = 'U' => '',
							   '');
self.sex				:= if(input.sex[1] in ['F','M'],
							input.sex[1],
							'');
self.hair_color			:= if(trim(input.hair_color,left,right) 
							in ['BAL','BLK','BLN','BRO','GRY','RED','SDY','WHI','UNK'],
							input.hair_color,
							'');
self.hair_color_desc	:= MAP(input.hair_color = 'BAL' => 'BALD',
							   input.hair_color = 'BLK' => 'BLACK',
							   input.hair_color = 'BLN' => 'BLONDE',
							   input.hair_color = 'BRO' => 'BROWN',
							   input.hair_color = 'GRY' => 'GRAY',
							   input.hair_color = 'RED' => 'RED',
							   input.hair_color = 'SDY' => 'SANDY',
							   input.hair_color = 'WHI' => 'WHITE',
							   input.hair_color = 'UNK' => '',
							   input.hair_color = 'XXX' => '',
							   '');
self.eye_color			:= if(trim(input.eye_color,left,right)
							in['BLK','BLU','BRO','GRN','GRY','HAZ','MUL','PNK','UNK'],
							input.eye_color,
							'');
self.eye_color_desc		:= MAP(input.eye_color = 'BLK' => 'BLACK',
							   input.eye_color = 'BLU' => 'BLUE',
							   input.eye_color = 'BRO' => 'BROWN',
							   input.eye_color = 'GRN' => 'GREEN',
							   input.eye_color = 'GRY' => 'GRAY',
							   input.eye_color = 'HAZ' => 'HAZEL',
							   input.eye_color = 'MUL' => 'MULTI COLOR',
							   input.eye_color = 'PNK' => 'PINK',
							   input.eye_color = 'UNK' => '',
							   '');
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= if((string)if(regexfind('\"',input.height,0)<>'' and regexfind('\'',input.height,0)='',
								regexreplace('\"',input.height,''),
							if(regexfind('\'',input.height,0)<>'' and regexfind('\"',input.height,0)<>'',
								(string)((integer)regexreplace('\'',input.height,'')[1]*12+(integer)regexreplace('\'',input.height,'')[2..3]),
							if(regexfind('\'',input.height,0)<>'' and regexfind('\"',input.height,0)='',
								(string)((integer)regexreplace('\'',input.height,'')[1]*12),
							if(regexfind('\'',input.height,0)='' and regexfind('\"',input.height,0)='',
								(string)((integer)input.height[1]*12+(integer)input.height[2..3]),'')))) between '48' and '84',
							(string)if(regexfind('\"',input.height,0)<>'' and regexfind('\'',input.height,0)='',
								regexreplace('\"',input.height,''),
							if(regexfind('\'',input.height,0)<>'' and regexfind('\"',input.height,0)<>'',
								(string)((integer)regexreplace('\'',input.height,'')[1]*12+(integer)regexreplace('\'',input.height,'')[2..3]),
							if(regexfind('\'',input.height,0)<>'' and regexfind('\"',input.height,0)='',
								(string)((integer)regexreplace('\'',input.height,'')[1]*12),
							if(regexfind('\'',input.height,0)='' and regexfind('\"',input.height,0)='',
								(string)((integer)input.height[1]*12+(integer)input.height[2..3]),'')))),
							'');
self.weight				:= if(regexreplace('lbs',input.weight,'') between '050' and '500',
							regexreplace('lbs',input.weight,''),
							'');
self.party_status		:= '';
self.party_status_desc	:= if((REGEXFIND(searchpattern, input.release_dt_time, 3))[1..2] in ['19','20'],
							'Release Dt: '+REGEXFIND(searchpattern, input.release_dt_time, 3)[1..4]+
							(string)intformat((integer)REGEXFIND(searchpattern, input.release_dt_time, 1), 2, 1)+
							(string)intformat((integer)REGEXFIND(searchpattern, input.release_dt_time, 2), 2, 1),
							'');
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

pLake := project(fLake, tLake(left));

ArrestLogs.ArrestLogs_clean(pLake,cleanLake);

//arrOut:= cleanLake + ArrestLogs.FileAbinitioOffender(vendor='');

dd_arrOut:= dedup(sort(distribute(cleanLake,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,source_file,local)
										,offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Arrestlogs_FL_Lake_Offender');
										
export map_FL_LakeOffender := dd_arrOut;