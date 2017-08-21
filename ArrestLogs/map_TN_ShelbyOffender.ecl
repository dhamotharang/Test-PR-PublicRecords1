import Crim_Common, Address;

p	:= ArrestLogs.file_TN_Shelby;

bShelby := p(regexfind('Warning</B>|'+'Warning :', p.Name)<>(boolean)'true');

fShelby := bShelby(trim(p.ID,left,right)<>'ID' and
			   trim(p.Name,left,right)<>'Name' and 
			   trim(p.Name,left,right)<>'LAST FIRST' and
			   trim(p.Booked,left,right)<>'Booked');

Crim_Common.Layout_In_Court_Offender tShelby(fShelby input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= (string)'A6'+(integer)hash(input.booked+input.RNI_Num);
						   /*An RNI number is supposed to be a unique number that has been linked via fingerprints to the individual*/
self.vendor				:= 'A6';
self.state_origin		:= 'TN';
self.data_type			:= '5';
self.source_file		:= '(CV)TN-ShelbyArrest';
self.case_number		:= '';//if(input.case_no <> '9999999999', input.case_no, '');//booking number?
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(if(trim(input.booked,left,right)<>'' and trim(input.booked,left,right)<>'0',
								if(trim(input.booked[1..3],left,right) = 'Jan', '01/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Feb', '02/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Mar', '03/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Apr', '04/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'May', '05/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Jun', '06/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Jul', '07/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Aug', '08/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Sep', '09/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Oct', '10/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Nov', '11/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Dec', '12/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'), '')))))))))))),''))[1..3] <> '000',						
								fSlashedMDYtoCYMD(if(trim(input.booked,left,right)<>'' and trim(input.booked,left,right)<>'0',
								if(trim(input.booked[1..3],left,right) = 'Jan', '01/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Feb', '02/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Mar', '03/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Apr', '04/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'May', '05/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Jun', '06/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Jul', '07/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Aug', '08/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Sep', '09/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Oct', '10/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Nov', '11/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Dec', '12/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'), '')))))))))))),'')),
								'');
self.pty_nm				:= trim(input.Name,left,right);
self.pty_nm_fmt			:= 'F';
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
self.dob				:= '';						   
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= '';
self.sex				:= '';
self.hair_color			:= '';
self.hair_color_desc	:= '';
self.eye_color			:= '';
self.eye_color_desc		:= '';
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= '';//converted to inches
self.weight				:= '';
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

pShelby := project(fShelby, tShelby(left));

ArrestLogs.ArrestLogs_clean(pShelby,cleanShelby);

arrOut:= cleanShelby + ArrestLogs.FileAbinitioOffender(vendor='A6');

dd_arrOut := dedup(sort(distribute(arrOut,hash(offender_key)),
									offender_key,pty_nm,pty_typ,case_filing_dt,source_file,local)
									,offender_key,pty_nm,pty_typ,local,left): 
									PERSIST('~thor_dell400::persist::Arrestlogs_TN_Shelby_Offender');

export map_TN_ShelbyOffender := dd_arrOut;
				
