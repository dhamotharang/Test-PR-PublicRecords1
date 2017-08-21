import Crim_Common, Address, lib_date;

p	:= ArrestLogs.file_FL_Martin;

fMartin := p(trim(p.Name,left,right)<>'name' and
			regexfind('[A-Z]',trim(p.Name,left,right),0)<>'');

Crim_Common.Layout_In_Court_Offender tMartin(fMartin input) := Transform
 
self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= (string)'E7'+(integer)(hash(trim(input.Name,left,right)+trim(input.Book_Num,left,right)+(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.Book_Dt,''))));
self.vendor				:= 'E7';//NEED TO UPDATE
self.state_origin		:= 'FL';
self.data_type			:= '5';
self.source_file		:= '(CV)FL-MartinCtyArr';
self.case_number		:= '';
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if((string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.Book_Dt,''))<>'0',
							if((string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.Book_Dt,'')) < Crim_Common.Version_In_Arrest_Offender and
							  length(input.Book_Dt)>2, 
							  (string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.Book_Dt,'')),
							  ''),
							'');
self.pty_nm				:= regexreplace(',',trim(input.name,left,right),' ');
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
self.dob				:=  if((string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.dob,''))[1..4] between '1916' and '1989',
						   (string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.dob,'')),
						   '');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= input.address;
self.street_address_2	:= input.city_state_zip;
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= if(StringLib.StringToUppercase(input.race)[1] 
							in ['W','B','N','O','H','M','I','A','J','C','X','U'] and
							input.race <>'AMERI',
							StringLib.StringToUppercase(input.race)[1],
							'');
self.race_desc			:= MAP(input.race[1] = 'W' => 'White',
							   input.race[1] = 'B' => 'Black',
							   input.race[1] = 'N' => 'Black',
							   input.race[1] = 'O' => '',
							   input.race[1] = 'H' => 'Hispanic',
							   input.race[1] = 'M' => 'Hispanic',
							   input.race[1] = 'I' => 'Indian',
							   input.race[1] = 'A' => 'Asian',
							   input.race[1] = 'J' => 'Japanese',
							   input.race[1] = 'C' => 'Chinese',
							   input.race[1] = 'X' => '',
							   input.race[1] = 'U' => '',
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

pMartin := project(fMartin, tMartin(left));

ArrestLogs.ArrestLogs_clean(pMartin,cleanMartin);

//arrOut:= cleanMartin + ArrestLogs.FileAbinitioOffender(vendor='');

dd_arrOut:= dedup(sort(distribute(cleanMartin,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,source_file,local)
										,offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Arrestlogs_FL_Martin_Offender');
										
export map_FL_MartinOffender := dd_arrOut;