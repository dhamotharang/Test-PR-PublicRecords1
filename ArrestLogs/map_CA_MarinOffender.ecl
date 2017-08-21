import Crim_Common, Address,lib_date;

p	:= ArrestLogs.file_CA_Marin.cmbnd(Charge_Desc <> '');

Crim_Common.Layout_In_Court_Offender tMarin(p input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= 'A1'+input.ID;
self.vendor				:= 'A1';
self.state_origin		:= 'CA';
self.data_type			:= '5';
self.source_file		:= '(CV)CA-MarinArrest';
self.case_number		:= input.case_num;
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= regexreplace('\r',input.Case_Type, '');
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(input.Book_Dt) < Crim_Common.Version_In_Arrest_Offender, 
							fSlashedMDYtoCYMD(input.Book_Dt),
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
self.dob				:= if(fSlashedMDYtoCYMD(input.DOB)[1..4] between '1916' and '1989',
						   fSlashedMDYtoCYMD(input.DOB),
						   '');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= input.address;
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= '';
self.sex				:= if (StringLib.StringToUpperCase(input.sex[1]) in ['M','F'],
                               StringLib.StringToUpperCase(input.sex[1]),'');
							   
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
							   '');
self.eye_color			:= if(input.Eyes in ['BLK','BLU','BRN','BRO','GRN','GRY','HAZ','HZL','MAR','MUL','PNK'],
							input.Eyes,
							'');
self.eye_color_desc		:= MAP(input.Eyes ='BLK' => 'BLACK',
							input.Eyes ='BLU' => 'BLUE',
							input.Eyes ='BRN' => 'BROWN',
							input.Eyes ='BRO' => 'BROWN',
							input.Eyes ='GRN' => 'GREEN',        
							input.Eyes ='GRY' => 'GREY',
							input.Eyes ='HAZ' => 'HAZEL',
							input.Eyes ='HZL' => 'HAZEL',
							input.Eyes ='MAR' => 'MAROON',
							input.Eyes ='MUL' => 'MULTI',
							input.Eyes ='PNK' => 'PINK',
							input.Eyes ='XXX' => '','');
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= if(((integer)regexreplace('\'',input.height,'')[1]*12)+((integer)regexreplace('\'',input.height,'')[3..4]) between 48 and 84,
                            (string)(((integer)regexreplace('\'',input.height,'')[1]*12)+((integer)regexreplace('\'',input.height,'')[3..4])),
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

pMarin := project(p, tMarin(left));

ArrestLogs.ArrestLogs_clean(pMarin,cleanMarin);

arrOut:= cleanMarin + ArrestLogs.FileAbinitioOffender(vendor='A1');

dd_arrOut := dedup(sort(distribute(arrOut,hash(offender_key)),
								offender_key,pty_nm,pty_typ,case_filing_dt,source_file,local)
								,offender_key,pty_nm,pty_typ,local,left): 
								PERSIST('~thor_dell400::persist::Arrestlogs_CA_Marin_Offender');

export map_CA_MarinOffender := dd_arrOut;