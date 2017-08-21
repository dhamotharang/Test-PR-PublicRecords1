import Crim_Common, Address;

p	:= ArrestLogs.file_CA_LosAngeles;

fLosAngeles := p(trim(p.Last_Name,left,right)<>'Last Name' and
			   trim(p.First_Name,left,right)<>'First Name' and
			   trim(p.Middle_Name,left,right)<>'Middle Name');

Crim_Common.Layout_In_Court_Offender tLosAngeles(fLosAngeles input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= (string)'AG'+(integer)hash(trim(input.Last_Name,all)+trim(input.First_Name,all)+trim(input.Middle_Name,all)+input.Sex+input.case_no+fSlashedMDYtoCYMD(input.DOB)+input.Race+fSlashedMDYtoCYMD(input.Arrest_Dt));
self.vendor				:= 'AG';
self.state_origin		:= 'CA';
self.data_type			:= '5';
self.source_file		:= '(CV)CA-LosAngelesArrest';
self.case_number		:= if(input.case_no <> '9999999999', input.case_no, '');//booking number?
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(input.Dt_Booked) < Crim_Common.Version_In_Arrest_Offender, 
							  fSlashedMDYtoCYMD(input.Dt_Booked),
							  '');
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
self.dob				:= if(fSlashedMDYtoCYMD(input.DOB)[1..2] = '19',
						   fSlashedMDYtoCYMD(input.DOB),
						   '');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= if(StringLib.StringToUpperCase(input.race)<>'P' 
							and StringLib.StringToUpperCase(input.race)<>'F',
							StringLib.StringToUpperCase(input.race),
							'');
self.race_desc			:= MAP(input.race = 'W' => 'White',
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
							   input.race = 'U' => '',
							   '');
self.sex				:= input.sex;
self.hair_color			:= if(trim(input.hair,left,right)='XXX','',input.hair);
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
self.eye_color			:= input.eyes;
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
self.height				:= if(input.height<>'0',
							(string)((integer)input.height[1]*12+(integer)input.height[2..3]),
							'');//converted to inches
self.weight				:= if(input.weight<>'0' and 
							input.weight between '050' and '500',
							input.weight,
							'');
self.party_status		:= '';
self.party_status_desc	:= if(fSlashedMDYtoCYMD(input.Actual_Release_Dt) = '00000000',
							 trim(input.facility,left,right)+(if(input.Grand_Total <> '0.00'
							 and input.Grand_Total <>'NO BAIL',' BOND $'+input.Grand_Total,'')),
							 'RELEASED: '+fSlashedMDYtoCYMD(input.Actual_Release_Dt));
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

pLosAngeles := project(fLosAngeles, tLosAngeles(left));

ArrestLogs.ArrestLogs_clean(pLosAngeles,cleanLosAngeles);

arrOut:= cleanLosAngeles + ArrestLogs.FileAbinitioOffender(vendor='AG');

dd_arrOut := dedup(sort(distribute(arrOut,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,source_file,local)
										,offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Arrestlogs_CA_LosAngeles_Offender');

export map_CA_LosAngelesOffender := dd_arrOut;