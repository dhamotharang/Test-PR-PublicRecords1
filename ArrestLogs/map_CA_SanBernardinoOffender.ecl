import Crim_Common, Address;

p	:= ArrestLogs.file_CA_SanBernardino;

fSanBernardino := p(trim(p.Last_Name,left,right)<>'Last Name' and
			   trim(p.First_Name,left,right)<>'First Name' and
			   trim(p.Middle_Name,left,right)<>'Middle Name');

Crim_Common.Layout_In_Court_Offender tSanBernardino(fSanBernardino input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
 
self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= 'A2'+trim(input.Book_Num,left,right);
self.vendor				:= 'A2';
self.state_origin		:= 'CA';
self.data_type			:= '5';
self.source_file		:= '(CV)CA-SanBernardinoCtyArr';
self.case_number		:= '';
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(input.Book_Dt) < Crim_Common.Version_In_Arrest_Offender
							  and fSlashedMDYtoCYMD(input.Book_Dt)[1..2] in ['19','20'],
							  fSlashedMDYtoCYMD(input.Book_Dt),'');
self.pty_nm				:= trim(input.First_Name,left,right)+' '+trim(input.Middle_Name,left,right)+' '+trim(input.Last_Name,left,right);
self.pty_nm_fmt			:= 'F';
self.orig_lname			:= input.Last_Name;
self.orig_fname			:= input.First_Name;
self.orig_mname			:= input.Middle_Name;
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
self.dob				:= fSlashedMDYtoCYMD(input.DOB);
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= input.race;
self.race_desc			:= '';
self.sex				:= input.sex;
self.hair_color			:= input.hair_color;
self.hair_color_desc	:= MAP(input.Hair_Color='BAL' => 'BALD',   
							input.Hair_Color='BLK' => 'BLACK', 
							input.Hair_Color='BLN' => 'BLOND',    
							input.Hair_Color='BRO' => 'BROWN',   
							input.Hair_Color='GRY' => 'GREY',   
							input.Hair_Color='RED' => 'RED',      
							input.Hair_Color='SDY' => 'SANDY', 
							input.Hair_Color='WHI' => 'WHITE', 
							input.Hair_Color='XXX' => '' ,'');
self.eye_color			:= input.eye_color;
self.eye_color_desc		:= MAP(input.eye_color ='BLK' => 'BLACK',
							input.eye_color ='BLU' => 'BLUE',
							input.eye_color ='BRO' => 'BROWN',
							input.eye_color ='GRN' => 'GREEN',        
							input.eye_color ='GRY' => 'GREY',
							input.eye_color ='HAZ' => 'HAZEL',
							input.eye_color ='MAR' => 'MAROON',
							input.eye_color ='MUL' => 'MULTI',
							input.eye_color ='PNK' => 'PINK',
							input.eye_color ='XXX' => '','');
self.skin_color			:= '';
self.skin_color_desc	:= MAP(input.Race='A' => 'ASIAN',
							input.Race='B' => 'BLACK',
							input.Race='I' => 'INDIAN',
							input.Race='W' => 'WHITE',
							input.Race='H' => 'HISPANIC',
							input.Race='O' => 'OTHER', '');
self.height				:= if(((integer)input.height_ft[1]*12)+((integer)input.height_inch[2..3]) between 48 and 84,
                            (string)(((integer)input.height_ft[1]*12)+((integer)input.height_inch[2..3])),
							'');
self.weight				:= if(input.weight<>'0' and 
							input.weight between '050' and '500',
							input.weight,
							'');
self.party_status		:= '';
self.party_status_desc	:= if(input.Release_Dt<>'0' and input.Release_Dt<>'',
							'Released on: '+fSlashedMDYtoCYMD(input.Release_Dt),
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

pSanBernardino := project(fSanBernardino, tSanBernardino(left));

ArrestLogs.ArrestLogs_clean(pSanBernardino,cleanSanBernardino);

arrOut:= cleanSanBernardino + ArrestLogs.FileAbinitioOffender(vendor='A2');

dd_arrOut := dedup(sort(distribute(cleanSanBernardino,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,source_file,local)
										,offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Arrestlogs_CA_SanBernardino_Offender');

export map_CA_SanBernardinoOffender := dd_arrOut;