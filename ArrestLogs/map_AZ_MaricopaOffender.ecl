import Crim_Common, Address;

p	:= Arrestlogs.file_AZ_Maricopa+Arrestlogs.Reformat_AZ_Maricopa_archive;

fMaricopa := p(trim(p.Name,left,right)<>'Name' and
			   trim(p.Name,left,right)<>'MALE' and
			   trim(p.Name,left,right)<>'FEMALE' and
			   trim(p.ID,left,right)<>'ID' and
			   trim(p.Race,left,right)<>'Race' and
			   trim(p.Hair,left,right)<>'Hair' and
			   trim(p.Eye,left,right)<>'Eye' and
			   trim(p.Weight,left,right)<>'Weight');

Crim_Common.Layout_In_Court_Offender tMaricopa(fMaricopa input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

string		fReplace(string pNameIn)
:= 	   regexreplace(' +', pNameIn, ' ');

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= (string)'AQ'+(integer)hash(trim(input.Name,all)+input.Sex[1]+fSlashedMDYtoCYMD(input.DOB)+input.Race[1..30]+fSlashedMDYtoCYMD(input.Date_Booked));
self.vendor				:= 'AQ';
self.state_origin		:= 'AZ';
self.data_type			:= '5';
self.source_file		:= '(CV)AZ-MaricopaArrest';
self.case_number		:= '';//need booking number
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if((integer)length(regexreplace('\\/|\\-',input.Date_Booked,''))=8 and regexfind('[A-Z]',input.Date_Booked,0)='',
							regexreplace('\\/|\\-',input.Date_Booked,'')[5..8]+''+regexreplace('\\/|\\-',input.Date_Booked,'')[1..2]+''+regexreplace('\\/|\\-',input.Date_Booked,'')[3..4],
							'');
self.pty_nm				:= trim(input.Name,left,right);
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
self.id_num				:= input.ID;
self.dl_num				:= '';
self.dl_state			:= '';
self.citizenship		:= '';
self.dob				:= if(fSlashedMDYtoCYMD(regexreplace('\\-',input.dob,'\\/'))[1..2] = '19',
						   fSlashedMDYtoCYMD(regexreplace('\\-',input.dob,'\\/')),
						   '');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= if(length(trim(input.race,left,right))>4 or trim(input.race, all) = 'UNKNOWN',
							regexreplace('UNKNOWN|'+'OTHER',input.Race[1..30],
							''),'');
self.sex				:= if(input.Sex[1] in ['F','M'],input.Sex[1],'');
self.hair_color			:= '';
self.hair_color_desc	:= if(length(trim(input.eye,left,right))>2,
							regexreplace('UNKNOWN OR COMPLETELY BALD|'+ 'UNKNOWN',input.Hair,''),
							'');
self.eye_color			:= '';
self.eye_color_desc		:= if(length(trim(input.eye,left,right))>2,
							regexreplace('UNKNOWN OR COMPLETELY BAL|'+ 'UNKNOWN|'+' D ',input.Eye,''),
							'');
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= if((string)((integer)trim(input.height,left,right)[1]*12+(integer)trim(input.height,left,right)[3..4]) between '48' and '84',
							(string)((integer)trim(input.height,left,right)[1]*12+(integer)trim(input.height,left,right)[3..4]),
							'');
self.weight				:= if((integer)trim(input.weight,left,right) between 50 and 500,
							trim(input.weight,left,right),
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

pMaricopa := project(fMaricopa, tMaricopa(left));

ArrestLogs.ArrestLogs_clean(pMaricopa,cleanMaricopa);

Crim_Common.Layout_In_Court_Offender uMaricopa(Crim_Common.Layout_In_Court_Offender input) := Transform
	self.height := (string)intformat((integer)input.height, 3, 1);
	self.weight := if((integer)trim(input.weight,left,right) between 50 and 500,
							trim(input.weight,left,right),
							''); 
	self.race_desc			:= if(length(trim(input.race_desc,left,right))>4 or trim(input.race_desc, all) = 'UNKNOWN',
							regexreplace('UNKNOWN|'+'OTHER',input.race_desc[1..20],
							''),'');
	self := input;
end;

archMaricopa := project(ArrestLogs.FileAbinitioOffender(vendor='AQ'), uMaricopa(left));

arrOut:= cleanMaricopa + archMaricopa;

export map_AZ_MaricopaOffender := dedup(sort(distribute(arrOut,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,source_file,local)
										,offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Arrestlogs_AZ_Maricopa_Offender');