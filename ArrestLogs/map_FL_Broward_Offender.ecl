import Crim_Common, Address;

p	:= ArrestLogs.file_FL_Broward;//(regexfind('<a href=', trim(Name,left,right)) <> (boolean)'true');

fBroward := p(trim(p.ID,left,right)<>'ID' and
			   trim(p.Name,left,right)<>'Name' and
			   trim(p.Name,left,right)[1..7]<>'<a href' and
			   trim(p.Race,left,right)<>'Race');
Crim_Common.Layout_In_Court_Offender tBroward(fBroward input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= 'AI'+input.case_num+input.ID;
self.vendor				:= 'AI';
self.state_origin		:= 'FL';
self.data_type			:= '5';
self.source_file		:= '(CV)FL-BrowardArrest';
self.case_number		:= if(trim(input.case_num,left,right) ~in['','.','"','UNFILED','UNASSIGNED'],
							StringLib.StringToUpperCase(input.case_num),
							'');
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(input.Arrest_Dt)[1..2] = '19',
							fSlashedMDYtoCYMD(input.Arrest_Dt),
							'');
self.pty_nm				:= if(trim(input.Name,left,right)<>'',
							trim(input.Name,left,right),
							'');
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
self.race				:= if(trim(input.race,left,right) ~in ['X','U','O'],
							trim(input.race,left,right),
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
self.sex				:= input.sex;
self.hair_color			:= if(trim(input.hair_color,left,right)='UNK' 
							or trim(input.hair_color,left,right)='XXX','',
							trim(input.hair_color,left,right));
self.hair_color_desc	:= MAP(trim(input.hair_color,left,right) = 'BAL' => 'BALD' ,
							trim(input.hair_color,left,right) = 'BLK' => 'BLACK' ,
							trim(input.hair_color,left,right) = 'BLN' => 'BLONDE' ,
							trim(input.hair_color,left,right) = 'BRO' => 'BROWN' ,
							trim(input.hair_color,left,right) = 'GRY' => 'GRAY' ,
							trim(input.hair_color,left,right) = 'RED' => 'RED' ,
							trim(input.hair_color,left,right) = 'SDY' => 'SANDY' ,
							trim(input.hair_color,left,right) = 'WHI' => 'WHITE' , 
							''); 
self.eye_color			:= if(trim(input.eye_color,left,right)='UNK','',
								trim(input.eye_color,left,right));
self.eye_color_desc		:= MAP(trim(input.eye_color,left,right) = 'BLK' => 'BLACK' ,
							trim(input.eye_color,left,right) = 'BLU' => 'BLUE' ,
							trim(input.eye_color,left,right) = 'BRO' => 'BROWN' ,
							trim(input.eye_color,left,right) = 'GRN' => 'GREEN' ,
							trim(input.eye_color,left,right) = 'GRY' => 'GRAY' ,
							trim(input.eye_color,left,right) = 'HAZ' => 'HAZEL' ,
							trim(input.eye_color,left,right) = 'MUL' => 'MULTI COLOR' ,
							trim(input.eye_color,left,right) = 'PNK' => 'PINK' ,
							'');
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= if(((integer)input.height[1]*12)+((integer)input.height[2..3]) between 48 and 84,
							 (string)(((integer)input.height[1]*12)+((integer)input.height[2..3])),
							 '');
self.weight				:= if(trim(input.weight,left,right)<>'0' and 
							trim(input.weight,left,right) between '50' and '500',
							trim(input.weight,left,right),
							'');
self.party_status		:= '';
self.party_status_desc	:= if(trim(input.Expect_Release_Dt,left,right)<>'',
							'EXPECTED RELEASE: '+fSlashedMDYtoCYMD(input.Expect_Release_Dt),'');
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

pBroward := project(fBroward, tBroward(left));

ArrestLogs.ArrestLogs_clean(pBroward,cleanBroward);

arrOut:= cleanBroward;
//+ ArrestLogs.FileAbinitioOffender(vendor='AI'); NOT KEEPING HISTORY

dd_arrOut := dedup(sort(distribute(arrOut,hash(offender_key)),
									offender_key,pty_nm,pty_typ,case_filing_dt,source_file,local)
									,offender_key,pty_nm,pty_typ,local,left): 
									PERSIST('~thor_dell400::persist::Arrestlogs_FL_Broward_Offender');

export map_FL_Broward_Offender := dd_arrOut;