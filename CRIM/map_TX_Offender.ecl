import crim_common, Crim, Address, lib_stringlib,ut,Crim_Expunctions;

input := crim.File_TX_Statewide.cmbndFile;

//////////////////////////////////////////////////////////////////////////////////

Crim_Common.Layout_In_Court_Offender rTX(input l) := Transform

//---
String heightToInches(String s) := FUNCTION
cleanheight := regexreplace('[^0-9]', s, '');
height_ft:=(integer)cleanheight[1..1];
height_in:=(integer)cleanheight[2..5];
return (string)intformat((height_ft*12+height_in), 3, 1);
END;
//---
string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
//---
string8     getReasonableRange(string newDateIn) 
:=    map((newDateIn[1..2] between '19' and '20') and 
			(newDateIn < ut.GetDate) => newDateIn,'');
//---			
self.process_date		:= Crim_Common.Version_Development;

self.vendor				:= '01';
self.state_origin		:= 'TX';
self.data_type			:= '2';
self.source_file		:= 'TX DEPT OF PUB SFTY';
self.case_number		:= l.cau_nbr;
self.case_court         := map(l.agy_txt[stringlib.stringfind(l.agy_txt,'~',1)+1..40] = 'FOR NCIC 2000 DATA CONVERSION PURPOSES' or
							   l.agy_txt[stringlib.stringfind(l.agy_txt,'~',1)+1..40] = 'ONLY'
										=> ''
										,l.agy_txt[stringlib.stringfind(l.agy_txt,'~',1)+1..40]);
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc 	:= 'Statewide Court';
self.case_filing_dt		:= '';
self.pty_nm 			:= regexreplace(',',l.name_txt,', ');
self.pty_nm_fmt 		:= 'L';
self.orig_lname			:= '';
self.orig_fname			:= '';     
self.orig_mname			:= '';
self.orig_name_suffix	:= '';
self.pty_typ			:= if(l.typ_cod = 'B','0','2');
self.nitro_flag			:= '';
self.orig_ssn			:= '';
self.dle_num			:= '';
self.fbi_num			:= '';
self.doc_num			:= '';
self.ins_num			:= '';
self.id_num				:= l.dps_number;
self.dl_num				:= '';
self.dl_state			:= '';
self.citizenship		:= '';
self.dob				:= if(l.typ_cod = 'B',getReasonableRange(fSlashedMDYtoCYMD(l.dob_dte)),'');
self.dob_alias			:= if(l.typ_cod != 'B',getReasonableRange(fSlashedMDYtoCYMD(l.dob_dte)),'');
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= l.rac_cod;
self.race_desc			:= map(l.rac_cod = 'B' => 'Black',
							   l.rac_cod = 'W' => 'White',
							   l.rac_cod = 'A' => 'Asian',
							   l.rac_cod = 'I' => 'American Indian','');
								
self.sex				:= l.sex_cod;
self.hair_color			:= l.hai_cod;
self.hair_color_desc	:= map(l.hai_cod = 'BLK' => 'Black'
							  ,l.hai_cod = 'BLN' => 'Blond' 
							  ,l.hai_cod = 'BLU' => 'Blue'  
							  ,l.hai_cod = 'BRO' => 'Brown' 
							  ,l.hai_cod = 'GRN' => 'Green'
							  ,l.hai_cod = 'GRY' => 'Gray'  
							  ,l.hai_cod = 'PNK' => 'Pink'  
							  ,l.hai_cod = 'RED' => 'Red'   
							  ,l.hai_cod = 'SDY' => 'Sandy' 
							  ,l.hai_cod = 'WHI' => 'White' ,'');
self.eye_color			:= l.eye_cod;
self.eye_color_desc		:= map(l.eye_cod = 'BLK' => 'Black' 
						  ,l.eye_cod = 'BLU' => 'Blue'  
						  ,l.eye_cod = 'BRO' => 'Brown' 
						  ,l.eye_cod = 'GRN' => 'Green' 
						  ,l.eye_cod = 'GRY' => 'Gray'  
						  ,l.eye_cod = 'HAZ' => 'Hazel' 
						  ,l.eye_cod = 'MAR' => 'Maroon'
						  ,l.eye_cod = 'MUL' => 'Multiple' 
						  ,l.eye_cod = 'PNK' => 'Pink' ,'');
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= heightToInches(l.hgt_qty);
self.weight				:= l.wgt_qty;
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

self.offender_key		:= self.vendor + if(l.dps_number='',l.per_idn,l.dps_number);
end;

refOffender := project(input, rTX(left));

Crim.Crim_clean(refOffender,cleanOffender);

dedOffender := dedup(sort(distribute(cleanOffender,hash(offender_key)),
										offender_key,pty_nm,pty_typ,dob,local),
										offender_key,pty_nm,pty_typ,dob,right,local) 
										;
										
/////////////////////////////////////////////////////////////////////////////////////////
//Remove individuals found in pull ssn file under a different offender key
/////////////////////////////////////////////////////////////////////////////////////////
layout := 
RECORD
string seq;
string offenderkey;
string fname;	
string lname;	
string dob;
end;
//table created by W20090514-142857 prod
tbl := dataset(
[ 
{'1','010206559519760303A','BUBA','HOWARD','19570610'},
{'2','010341224619841020A','STEPHEN','GILBERT','19430428'},
{'3','010341224619841020A','J','GILBERT','19430428'},
{'4','010341224619841020A','STEPHEN','GILBERT','19430428'},
{'5','010206559519760303A','','HOWARD','19570610'},
{'6','010391952520030914A','SHARLET','JACKSON','19690115'},
{'7','010391952520030914A','SHARLET','JACKSON','19690115'},
{'8','010391952520030914A','SHARLET','JOHNSON','19690115'},
{'9','010538295720040416A','HELANDREA','HARRISON','19770801'},
{'10','010538295720040416A','HELANDREA','HARRISON','19770801'},
{'11','010580880819980317A','CHRIS','RUOFF','19781012'},
{'12','010580880819980317A','CHRISTOPHER','RUOFF','19781012'},
{'13','010580880819980317A','CHRIS','RUOFF','19781012'},
{'14','010580880819980317A','CHRISTOPHER','RUOFF','19781012'},
{'15','010583858719970327A','JANET','DAVIS','19650706'},
{'16','010583858719970327A','JANET','DAVIS','19650706'},
{'17','010604442620030228A','JASON','COOPER','19730223'},
{'18','010609734519991020A','PIERRE','JACKSON','19770818'},
{'19','010609734519991020A','PIERRE','JACKSON','19770818'},
{'20','010609734519991020A','PIERRE','JACKSON','19770818'},
{'21','010668636320010511A','ROHIT','MATHEWS','19830204'},
{'22','010681744720030311A','RICHARD','KNOX','19740624'},
{'23','010681744720030311A','RICHARD','KNOX','19740624'},
{'24','010740832120060625A','JAVIER','SANCHEZ','19801203'},
{'25','010740832120041030A','JAVIER','SANCHEZ','19801203'},
{'26','010784469920070125A','LUIS','PIEDRA','19881028'},
{'27','010784469920070125A','LUIS','PIEDRA','19881028'},
{'28','010784469920070125A','X','LUI','19881028'},
{'29','010786906320061226A','JOSEPH','ALLINIECE','19880918'}
   
],layout);

dedOffender trecs(dedOffender L, tbl R) := transform
self := L;
end;

jrecs := join(dedOffender, tbl,
				left.lname = right.lname and
				left.fname = right.fname and 
				left.dob   = right.dob,
				trecs(left,right), left only, lookup);


export Map_TX_Offender :=Crim_Expunctions.fRemoveTXExpunctions(jrecs):PERSIST('~thor_dell400::persist::Crim_TX_Statewide_Offender_Clean');