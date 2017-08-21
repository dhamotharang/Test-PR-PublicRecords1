import crim_common, Crim, Address;

d := crim.File_LA_St_Tammany(Firstname<>'');

Crim_Common.Layout_In_Court_Offender tLAOffend(d input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

string4		fCleanHeight(string pHeight)
:= regexreplace('\'|'+'\"|'+'\\;|'+',|'+'\\.|'+'-|'+'\\*|'+'\\:|'+'\\/',pHeight,'');

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= '2N'+trim(input.docketno,left,right)+fSlashedMDYtoCYMD(trim(input.filedate,left,right))+hash(regexreplace('AKA',input.lastname,'')+' '+regexreplace('AKA|'+',',input.firstname,''));
self.vendor				:= '2N';
self.state_origin		:= 'LA';
self.data_type			:= '2';
self.source_file		:= 'LA St Tammany CRIM CT';
self.case_number		:= trim(input.docketno,left,right);
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(input.filedate)[1..2] between '19' and '20' 
							and fSlashedMDYtoCYMD(input.filedate)<=stringlib.GetDateYYYYMMDD(),
							fSlashedMDYtoCYMD(input.filedate),
							'');
self.pty_nm				:= regexreplace('AKA',input.lastname,'')+' '+regexreplace('AKA|'+',',input.firstname,'');
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= regexreplace('AKA',input.lastname,'');
self.orig_fname			:= regexreplace('AKA|'+',',input.firstname,'');     
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
self.dob				:= if(fSlashedMDYtoCYMD(input.dob)[1..2] between '1900' and '1990',
							fSlashedMDYtoCYMD(input.dob),
							'');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= MAP(input.race = 'W' => 'White',
							input.race ='B' => 'Black',
							input.race ='N' =>'Black',
							input.race ='H' => 'Hispanic', 
							input.race ='M' => 'Hispanic',
							input.race ='I' => 'Indian',
							input.race ='A' => 'Asian',
							input.race ='J' => 'Asian',
							input.race ='C' => 'Asian',
							'');
self.sex				:= if(trim(input.sex,left,right)[1] in ['F','M'],
							trim(input.sex,left,right)[1],
							'');
self.hair_color			:= '';
self.hair_color_desc	:= MAP(input.Hair ='BAL' => 'BALD',
							input.Hair ='BLD' => 'BALD',
							input.Hair ='BALD' => 'BALD',
							input.Hair ='BK' => 'BLACK',
							input.Hair ='BLA' => 'BLACK',
							input.Hair ='BLK' => 'BLACK',
							input.Hair ='BLACK' => 'BLACK',
							input.Hair ='BLK DK' => 'BLACK',
							input.Hair ='BLN' => 'BLOND',
							input.Hair ='BLO' => 'BLOND',
							input.Hair ='BLON' => 'BLOND',
							input.Hair ='BLND' => 'BLOND',
							input.Hair ='BLNDE' => 'BLOND',
							input.Hair ='BLOND' => 'BLOND',
							input.Hair ='BLONDE' => 'BLOND',
							input.Hair ='BONLD' => 'BLOND',
							input.Hair ='BR' => 'BROWN',
							input.Hair ='BRO' => 'BROWN',
							input.Hair ='BRO' => 'BROWN',
							input.Hair ='BRN' => 'BROWN',
							input.Hair ='LT BRN' => 'BROWN',
							input.Hair ='LT BROWN' => 'BROWN',
							input.Hair ='GRA' => 'GREY',
							input.Hair ='GRAY' => 'GREY',
							input.Hair ='GRY' => 'GREY',
							input.Hair ='GREY' => 'GREY',
							input.Hair ='RD' => 'RED',
							input.Hair ='RED' => 'RED',      
							input.Hair ='SDY' => 'SANDY',
							input.Hair ='SANDY' => 'SANDY',
							input.Hair ='WHI' => 'WHITE', 
							input.Hair ='WHT' => 'WHITE',
							input.Hair ='WHITE' => 'WHITE', 
							input.Hair ='XXX' => '' ,'');
self.eye_color			:= '';
self.eye_color_desc		:= MAP(input.eyes ='BLK' => 'BLACK',
							input.eyes ='BLA' => 'BLACK',
							input.eyes ='BLU' => 'BLUE',
							input.eyes ='BL' => 'BLUE',
							input.eyes ='BLUE' => 'BLUE',
							input.eyes ='BRO' => 'BROWN',
							input.eyes ='BN' => 'BROWN',
							input.eyes ='BR' => 'BROWN',
							input.eyes ='BRWN' => 'BROWN',
							input.eyes ='BRW' => 'BROWN',
							input.eyes ='BRN' => 'BROWN',
							input.eyes ='BROWN' => 'BROWN',
							input.eyes ='GRN' => 'GREEN',
							input.eyes ='GREEN' => 'GREEN',
							input.eyes ='GRY' => 'GREY',
							input.eyes ='GRAY' => 'GREY',
							input.eyes ='HAZ' => 'HAZEL',
							input.eyes ='HZL' => 'HAZEL',
							input.eyes ='HZEL' => 'HAZEL',
							input.eyes ='HAZEL' => 'HAZEL',
							input.eyes ='MAR' => 'MAROON',
							input.eyes ='MUL' => 'MULTI',
							input.eyes ='PNK' => 'PINK',
							input.eyes ='XXX' => '','');
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= if((string)if(regexfind('[A-Z]+',input.height,0)='' and length(trim(fcleanheight(input.height),all))=1,
							((integer)fcleanheight(input.height)[1])*12,
							if(regexfind('[A-Z]+',input.height,0)='' and length(trim(fcleanheight(input.height),all))=2,
							((integer)fcleanheight(input.height)[1])*12+((integer)fcleanheight(input.height)[2]),
							if(regexfind('[A-Z]+',input.height,0)='' and length(trim(fcleanheight(input.height),all))=3 and fcleanheight(input.height)[2]<>'0',
							((integer)fcleanheight(input.height)[1])*12+((integer)fcleanheight(input.height)[2..3]),
							if(regexfind('[A-Z]+',input.height,0)='' and length(trim(fcleanheight(input.height),all))=3 and fcleanheight(input.height)[2]='0',
							((integer)fcleanheight(input.height)[1])*12+((integer)fcleanheight(input.height)[3]),
							(integer)'')))) between '48' and '84',
							(string)if(regexfind('[A-Z]+',input.height,0)='' and length(trim(fcleanheight(input.height),all))=1,
							((integer)fcleanheight(input.height)[1])*12,
							if(regexfind('[A-Z]+',input.height,0)='' and length(trim(fcleanheight(input.height),all))=2,
							((integer)fcleanheight(input.height)[1])*12+((integer)fcleanheight(input.height)[2]),
							if(regexfind('[A-Z]+',input.height,0)='' and length(trim(fcleanheight(input.height),all))=3 and fcleanheight(input.height)[2]<>'0',
							((integer)fcleanheight(input.height)[1])*12+((integer)fcleanheight(input.height)[2..3]),
							if(regexfind('[A-Z]+',input.height,0)='' and length(trim(fcleanheight(input.height),all))=3 and fcleanheight(input.height)[2]='0',
							((integer)fcleanheight(input.height)[1])*12+((integer)fcleanheight(input.height)[3]),
							(integer)'')))),'');
self.weight				:= if(trim(input.weight,left,right)[1]='0'and trim(input.weight,left,right) between '050' and '500',
							trim(input.weight,left,right)[2..3],
							if(trim(input.weight,left,right)[1]<>'0'and trim(input.weight,left,right) between '050' and '500' and regexfind('\'',trim(input.weight,left,right),0)='',
							trim(input.weight,left,right),
							''));
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

pLAOffend := project(d, tLAOffend(left));

Crim.Crim_clean(pLAOffend,cleanLAOffend);

fLAOffend := dedup(sort(distribute(cleanLAOffend,hash(offender_key)),
										offender_key,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,local),
										offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Crim_LA_St_Tammany_Offender_Clean');

export Map_LA_St_Tammany_Offender := fLAOffend;