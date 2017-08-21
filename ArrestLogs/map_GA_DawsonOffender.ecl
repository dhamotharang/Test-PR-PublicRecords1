import Crim_Common, Address, VersionControl;

p	:= ArrestLogs.file_GA_Dawson;

fDawson := p(trim(p.height,left,right)<>'Height');

Crim_Common.Layout_In_Court_Offender tDawson(fDawson input) := Transform

//DateLastReported        := VersionControl.fGetFilenameVersion('~thor_data400::in::arrlog::ga::Dawson')[1..8] : stored('DateLastReported');

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= (string)'D7'+(integer)hash(trim(input.name,all)+fSlashedMDYtoCYMD(input.DOB)+input.book_num);
self.vendor				:= 'D7';//REMEMBER TO UPDATE
self.state_origin		:= 'GA';
self.data_type			:= '5';
self.source_file		:= '(CV)GA-DawsonCtyArr';
self.case_number		:= '';
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(input.book_date)<>'00000000',
							  fSlashedMDYtoCYMD(input.book_date),'');
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
self.dob				:= if(fSlashedMDYtoCYMD(input.DOB)[1..4] between '1916' and '1989',
						   fSlashedMDYtoCYMD(input.DOB),
						   '');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= if(input.race<>'UNKNOWN',input.race,'');
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
self.skin_color_desc	:= '';
self.height				:= if(((integer)input.height[1]*12)+((integer)input.height[3..4]) between 48 and 84,
							 (string)(((integer)input.height[1]*12)+((integer)input.height[3..4])),
							 '');
self.weight				:= trim(input.weight,left,right);
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

pDawson := project(fDawson, tDawson(left));

ArrestLogs.ArrestLogs_clean(pDawson,cleanDawson);

dd_arrOut :=  dedup(sort(distribute(cleanDawson,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,source_file,local)
										,offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Arrestlogs_GA_Dawson_Offender');

export map_GA_DawsonOffender := dd_arrOut;