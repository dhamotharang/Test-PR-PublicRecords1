import Crim_Common, Address, lib_date,ut;

fFresno	:= ArrestLogs.file_CA_Fresno.cmbnd;

Crim_Common.Layout_In_Court_Offender tFresno(fFresno input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

string8     getReasonableRange(string newDateIn) 
:=    map((newDateIn[1..2] between '19' and '20') and 
			(newDateIn < ut.GetDate) => newDateIn,'');
			

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= 'E4'+trim(input.Book_Num,left,right)+(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.Book_Dt,''));
self.vendor				:= 'E4';//NEED TO UPDATE
self.state_origin		:= 'CA';
self.data_type			:= '5';
self.source_file		:= '(CV)CA-FresnoCtyArr';
self.case_number		:= '';
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= map(length(input.book_dt) = 8 =>
							if((string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.Book_Dt,''))<>'0',
							if((string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.Book_Dt,'')) < Crim_Common.Version_In_Arrest_Offender and
							  length(input.Book_Dt)>2, 
							  (string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.Book_Dt,'')),
							  ''),'')
							,length(input.book_dt) = 10 =>
							  getReasonableRange(fSlashedMDYtoCYMD(input.book_dt))
							  ,'');
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
self.dob 				:= map(length(input.dob) = 8 =>
								if((string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.dob,''))[1..4] between '1916' and '1989',
								 (string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.dob,'')),'')
							  ,length(input.dob) = 10 =>
							  getReasonableRange(fSlashedMDYtoCYMD(input.dob))
							  ,'');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= if(StringLib.StringToUpperCase(input.race)[1] 
							in ['W','B','N','O','H','M','I','A','J','C','X','U'] and
							input.race <>'AMERI',
							StringLib.StringToUpperCase(input.race)[1],
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
self.hair_color			:= if(trim(input.hair,left,right) 
							in ['BAL','BLK','BLN','BRO','GRY','RED','SDY','WHI','UNK','XXX'],
							input.hair,
							'');
self.hair_color_desc	:= MAP(input.Hair = 'BAL' => 'BALD',
							   input.Hair = 'BLK' => 'BLACK',
							   input.Hair = 'BLN' => 'BLONDE',
							   input.Hair = 'BRO' => 'BROWN',
							   input.Hair = 'GRY' => 'GRAY',
							   input.Hair = 'RED' => 'RED',
							   input.Hair = 'SDY' => 'SANDY',
							   input.Hair = 'WHI' => 'WHITE',
							   input.Hair = 'UNK' => '',
							   input.Hair = 'XXX' => '',
							   input.Hair);
self.eye_color			:= if(trim(input.eyes,left,right)
							in['BLK','BLU','BRO','GRN','GRY','HAZ','MUL','PNK','UNK'],
							input.eyes,
							'');
self.eye_color_desc		:= MAP(input.Eyes = 'BLK' => 'BLACK',
							   input.Eyes = 'BLU' => 'BLUE',
							   input.Eyes = 'BRO' => 'BROWN',
							   input.Eyes = 'GRN' => 'GREEN',
							   input.Eyes = 'GRY' => 'GRAY',
							   input.Eyes = 'HAZ' => 'HAZEL',
							   input.Eyes = 'MUL' => 'MULTI COLOR',
							   input.Eyes = 'PNK' => 'PINK',
							   input.Eyes = 'UNK' => '',
							   '');
self.skin_color			:= '';
self.skin_color_desc	:= '';
height := stringlib.stringfilter(input.height,'0123456789');
self.height				:= if(if(regexfind('[0-9]+',height,0)<>'',height,'')<>'' and 
							((integer)if(regexfind('[0-9]+',height,0)<>'',height,'')[1]*12+(integer)if(regexfind('[0-9]+',height,0)<>'',height,'')[2..3]) between 48 and 84,
							(string)((integer)if(regexfind('[0-9]+',height,0)<>'',height,'')[1]*12+(integer)if(regexfind('[0-9]+',height,0)<>'',height,'')[2..3]),
							'');//converted to inches
self.weight				:= if(regexfind('\'',input.weight,0)='' and 
							input.weight between '050' and '500',
							input.weight,
							'');
self.party_status		:= '';
release_date			:= regexreplace('\r',input.release_date,'');
self.party_status_desc	:= if(Release_Date <> '','RELEASED '+ map(length(release_date) = 8 =>
																if((string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',release_date,''))<>'0',
																if((string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',release_date,'')) < Crim_Common.Version_In_Arrest_Offender and
																length(release_date)>2, 
																(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',release_date,'')),
																''),'')
																,length(release_date) = 10 =>
																getReasonableRange(fSlashedMDYtoCYMD(release_date))
																,''),'');
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

pFresno := project(fFresno, tFresno(left));

ArrestLogs.ArrestLogs_clean(pFresno,cleanFresno);

dd_arrOut:= dedup(sort(distribute(cleanFresno,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,source_file,local)
										,offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Arrestlogs_CA_Fresno_Offender');
										
export Map_CA_FresnoOffender := dd_arrOut;