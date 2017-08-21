import Crim_Common, Address, lib_date;

p	:= ArrestLogs.file_CA_Kings.cmbnd;

Crim_Common.Layout_In_Court_Offender tKings(p input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
 
self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= 'E1'+input.id;
self.vendor				:= 'E1';//NEED TO UPDATE
self.state_origin		:= 'CA';
self.data_type			:= '5';
self.source_file		:= '(CV)CA-KingsCtyArr';
self.case_number		:= '';
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if((fSlashedMDYtoCYMD(input.Book_Dt) < Crim_Common.Version_In_Arrest_Offender) and fSlashedMDYtoCYMD(input.Book_Dt) <>'00000000', 
							  fSlashedMDYtoCYMD(input.Book_Dt),
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
self.id_num				:= input.inmate_id;
self.dl_num				:= '';
self.dl_state			:= '';
self.citizenship		:= '';
self.dob				:= if(fSlashedMDYtoCYMD(input.DOB)[1..4] between '1916' and '1989',
						   fSlashedMDYtoCYMD(input.DOB),
						   '');
self.dob_alias			:= '';
self.place_of_birth		:= input.Birth_state;
self.street_address_1	:= '';
self.street_address_2	:= input.resident_city + ' ' +input.resident_state;
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= if(input.race in ['W','B','N','H','M','I','A','J','C'],
							input.race,
							'');
self.race_desc			:= MAP(trim(input.race,left,right)='W' => 'White' , 
							trim(input.race,left,right)='B' => 'Black' , 
							trim(input.race,left,right)='N' => 'Black' , 
							trim(input.race,left,right)='H' => 'Hispanic' , 
							trim(input.race,left,right)='M' => 'Hispanic' ,
							trim(input.race,left,right)='I' => 'Indian' , 
							trim(input.race,left,right)='A' => 'Asian' ,
							trim(input.race,left,right)='J' => 'Japanese' ,
							trim(input.race,left,right)='C' => 'Chinese' , 
							'');
self.sex				:= if(input.Sex in ['F','M'],
							input.sex,
							'');
self.hair_color			:= if(input.hair in ['BAL','BLK','BLN','BRO','GRY','RED','SDY','WHI','XXX'],
							input.hair,
							'');
self.hair_color_desc	:= MAP(input.hair='BAL' => 'BALD',   
							input.hair='BLK' => 'BLACK', 
							input.hair='BLN' => 'BLOND',    
							input.hair='BRO' => 'BROWN',   
							input.hair='GRY' => 'GREY',   
							input.hair='RED' => 'RED',      
							input.hair='SDY' => 'SANDY', 
							input.hair='WHI' => 'WHITE', 
							input.hair='XXX' => '' ,'');
self.eye_color			:= if(input.eyes in ['BLK','BLU','BRO','GRN','GRY','HAZ','MAR','MUL','PNK','XXX'],
							input.eyes,
							'');
self.eye_color_desc		:= MAP(input.eyes ='BLK' => 'BLACK',
							input.eyes ='BLU' => 'BLUE',
							input.eyes ='BRO' => 'BROWN',
							input.eyes ='GRN' => 'GREEN',        
							input.eyes ='GRY' => 'GREY',
							input.eyes ='HAZ' => 'HAZEL',
							input.eyes ='MAR' => 'MAROON',
							input.eyes ='MUL' => 'MULTI',
							input.eyes ='PNK' => 'PINK',
							input.eyes ='XXX' => '','');
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= if(((integer)input.height[1]*12)+((integer)input.height[3..4]) between 48 and 84,
                            (string)(((integer)input.height[1]*12)+((integer)input.height[3..4])),
							'');
self.weight				:= if(regexfind('[0-9]+',input.weight,0)<>'' and input.weight between '050' and '500',
							input.weight,
							'');
self.party_status		:= '';
self.party_status_desc	:= map(input.Release_Dt= '00/00/0000' or input.Release_Dt= '' => '', 'RELEASED '+fSlashedMDYtoCYMD(input.Release_Dt));
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

pKings := project(p, tKings(left));

ArrestLogs.ArrestLogs_clean(pKings,cleanKings);

dd_arrOut:= dedup(sort(distribute(cleanKings(regexfind('[0-9]',pty_nm)=false),hash(offender_key)), //dup records are coming from vendor with id merged in with name W20090812-154906
										offender_key,pty_typ,case_filing_dt,lname,fname,mname,local)
										,offender_key,pty_typ,case_filing_dt,lname,fname,local,right):
										PERSIST('~thor_data400::persist::Arrestlogs_CA_Kings_Offender');

export Map_CA_KingsOffender := dd_arrOut;