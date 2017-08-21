import Crim_Common, Address, lib_date;

input1 := ArrestLogs.File_CA_Orange.Original;
input2 := ArrestLogs.File_CA_Orange.New;

cmbndLayout := record
input1;
string	Release_Type;
string	Release_Dt;
end;

cmbndLayout t1(input1 L) := transform
self := L;
self := [];
end;

precs1 := project(input1,t1(left));

cmbndLayout t2(input2 L) := transform
self := L;
self := [];
end;

p := project(input2,t2(left))+precs1;

//p	:= ArrestLogs.file_CA_Orange;

fOrange := p(trim(p.race,left,right)<>'Race' and
			regexfind('[A-Z]',trim(p.race,left,right),0)<>'');

Crim_Common.Layout_In_Court_Offender tOrange(fOrange input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
 
self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= 'E5'+input.ID+fSlashedMDYtoCYMD(regexreplace('-',input.arrest_on[1..10],'/'));
self.vendor				:= 'E5';//NEED TO UPDATE
self.state_origin		:= 'CA';
self.data_type			:= '5';
self.source_file		:= '(CV)CA-OrangeCtyArr';
self.case_number		:= input.case_num;
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= regexreplace('00000000',if(fSlashedMDYtoCYMD(regexreplace('-',input.booked_on,'/')) < Crim_Common.Version_In_Arrest_Offender and
							fSlashedMDYtoCYMD(regexreplace('-',input.booked_on,'/')) <> '0', 
							fSlashedMDYtoCYMD(regexreplace('-',input.booked_on,'/')),
							''),'');
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
self.dob				:= if(fSlashedMDYtoCYMD(regexreplace('-',input.dob[1..10],'/'))[1..4] between '1916' and '1989',
						   fSlashedMDYtoCYMD(regexreplace('-',input.dob[1..10],'/')),
						   '');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= input.race;
self.sex				:= if(input.sex[1] in ['F','M'],
							input.sex[1],
							'');
self.hair_color			:= '';
self.hair_color_desc	:= if(input.hair_color='Unkown/Bald',
							'Unknown/Bald',
							input.hair_color);
self.eye_color			:= '';
self.eye_color_desc		:= input.eye_color;
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= if(((integer)regexreplace('\'',input.height,'')[1]*12)+((integer)regexreplace('\'',input.height,'')[3..4]) between 48 and 84,
                            (string)(((integer)regexreplace('\'',input.height,'')[1]*12)+((integer)regexreplace('\'',input.height,'')[3..4])),
							'');//converted to inches
self.weight				:= regexreplace('lbs.',
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

pOrange := project(fOrange, tOrange(left));

ArrestLogs.ArrestLogs_clean(pOrange,cleanOrange);

//arrOut:= cleanOrange + ArrestLogs.FileAbinitioOffender(vendor='');

dd_arrOut:= dedup(sort(distribute(cleanOrange,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,source_file,local)
										,offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Arrestlogs_CA_Orange_Offender');
										
export Map_CA_OrangeOffender := dd_arrOut;