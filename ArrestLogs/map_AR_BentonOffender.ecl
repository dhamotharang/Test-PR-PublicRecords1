import Crim_Common, Address;

d:= ArrestLogs.file_AR_Benton((ID) <> 'ID');

fBenton:= d(trim(d.LastName,left,right)<>'Last Name' and
			   trim(d.FirstName,left,right)<>'First Name' and
			   trim(d.MiddleName,left,right)<>'Middle Name');

Crim_Common.Layout_In_Court_Offender tBenton(fBenton input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
 
self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= 'AU'+input.ID+input.Offense_Date;
self.vendor				:= 'AU';
self.state_origin		:= 'AR';
self.data_type			:= '5';
self.source_file		:= 'AR-Benton_CO';
self.case_number		:= '';
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(input.Admit_Date) < Crim_Common.Version_In_Arrest_Offender
							  and fSlashedMDYtoCYMD(input.Admit_Date)[1..2] in ['19','20'],
							  fSlashedMDYtoCYMD(input.Admit_Date),
							  if(fSlashedMDYtoCYMD(input.MiddleName)[1..2] in ['19','20'],
							  fSlashedMDYtoCYMD(input.MiddleName),''));
self.pty_nm				:= StringLib.StringToUpperCase(trim(input.FirstName,left,right)+' '+trim(input.MiddleName,left,right)+' '+trim(input.LastName,left,right));
self.pty_nm_fmt			:= 'F';
self.orig_lname			:= input.lastname;
self.orig_fname			:= input.firstname;
self.orig_mname			:= regexreplace('[0-9]|'+ '/',input.MiddleName,'');
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
self.street_address_1	:= if(length(input.address)>1 and regexfind(':|'+'UNKNOWN|'+'UNKN|'+'UKNOWN|'+'UNK',input.address,0)='',
							input.address,
							'');
self.street_address_2	:= '';
self.street_address_3	:= trim(input.city,left,right);
self.street_address_4	:= trim(input.state,left,right);
self.street_address_5	:= trim(input.Zipcode,left,right);
self.race				:= StringLib.StringToUpperCase(input.race);
							
self.race_desc :=MAP(input.race = 'W' => 'White',
							   input.race = 'B' => 'Black',
							   input.race = 'N' => 'Black',
							   input.race = 'O' => 'Other',
							   input.race = 'H' => 'Hispanic',
							   input.race = 'M' => 'Hispanic',
							   input.race = 'I' => 'Indian',
							   input.race = 'A' => 'Asian',
							   input.race = 'J' => 'Japanese',
							   input.race = 'C' => 'Chinese',
							   input.race = 'X' => '',
							   input.race = 'U' => '','');
self.sex				:= if(trim(input.sex,left,right) in ['F','M'],
							trim(input.sex,left,right),
							'');

self.hair_color			:= if(trim(input.hair,left,right) in ['BAL','BLK','BLN','BLU',
							'BRO','GRE','GRY','RED','UNK','WHI','XXX'],
							trim(input.hair,left,right),'');

self.hair_color_desc	:= MAP(input.Hair = 'BAL' => 'BALD',
							   input.Hair = 'BLK' => 'BLACK',
							   input.Hair = 'BLN' => 'BLONDE',
							   input.Hair = 'BLU' => 'BLUE',
							   input.Hair = 'BRO' => 'BROWN',
							   input.Hair = 'GRE' => 'GREEN',
							   input.Hair = 'GRY' => 'GRAY',
							   input.Hair = 'WHI' => 'WHITE',
							   input.Hair = 'UNK' => '',
							   input.Hair = 'XXX' => '',
							   input.hair = 'RED' => 'RED','');
							   
self.eye_color			:= if(trim(input.eyes,left,right) in ['BLK','BLU','BRO',
							'GRN','HAZ'],
							trim(input.eyes,left,right),
							'');
self.eye_color_desc		:= MAP(input.eyes = 'BLK' => 'Black',
							   input.eyes = 'BLU' => 'Blue',
							   input.eyes = 'BRO' => 'Brown',
							   input.eyes = 'GRN' => 'Green',
							   input.eyes = 'HAZ' => 'Hazel','');
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= if(((integer)regexreplace('\'',input.height,'')[1]*12)+((integer)regexreplace('\'',input.height,'')[3..4]) between 48 and 84,
                            (string)(((integer)regexreplace('\'',input.height,'')[1]*12)+((integer)regexreplace('\'',input.height,'')[3..4])),
							'');
self.weight				:= if(input.weight<>'0' and 
							input.weight between '050' and '500',
							input.weight,
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

pBenton := project(fBenton, tBenton(left));

//refOffender := project(inf, rSC(left))(regexfind('[A-Z]', pty_nm) and regexfind('[0-9]', case_number));


ArrestLogs.ArrestLogs_clean(pBenton ,cleanBenton);

arrOut:= cleanBenton(pty_nm<>'') + ArrestLogs.FileAbinitioOffender(vendor='AU');

dd_arrOut:= dedup(sort(distribute(arrOut,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,local)
										,offender_key,pty_nm,pty_typ,case_filing_dt,local,left): 
										PERSIST('~thor_dell400::persist::Arrestlogs_AL_Benton_Offender');

export map_AR_BentonOffender:= dd_arrOut;