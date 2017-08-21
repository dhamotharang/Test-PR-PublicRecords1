import Crim_Common, Address;

p	:= ArrestLogs.file_FL_PalmBeach;
   
ArrestLogs.Layout_FL_PalmBeach_new2 sPalmBeach(p input) := Transform
self.Original_Bond := '';
self.Current_Bond := '';
self.Release_Dt := '';
self.Release_Time := '';
self.Other_Agency_Holds := '';
self.Warrant_Num := '';
self.Jacket_Num := '';
self := input;
end;

rPalmBeach := project(p, sPalmBeach(left));

p2 := ArrestLogs.File_FL_PalmBeach_new;

ArrestLogs.Layout_FL_PalmBeach_new2 sPalmBeach2(p2 input) := Transform
self.Release_Dt := '';
self.Release_Time := '';
self.Other_Agency_Holds := '';
self.Warrant_Num := '';
self.Jacket_Num := '';
self := input;
end;

r2PalmBeach := project(p2, sPalmBeach2(left));

p3	:= rPalmBeach+r2PalmBeach+ArrestLogs.file_FL_PalmBeach_new2;

fPalmBeach := p3(trim(p3.Name,left,right)<>'Name' and
			   trim(p3.Race,left,right)<>'Race' and
			   trim(p3.DOB,left,right)<>'DOB');  

Crim_Common.Layout_In_Court_Offender tPalmBeach(fPalmBeach input) := Transform

searchpattern := '^(.*)             (.*)$';

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= 'AM'+trim(input.book_num,left,right)+fSlashedMDYtoCYMD(input.Book_Dt)+input.ID;
self.vendor				:= 'AM';
self.state_origin		:= 'FL';
self.data_type			:= '5';
self.source_file		:= '(CV)FL-PalmBeachArrest';
self.case_number		:= if(input.book_num <> '', input.book_num, '');//booking number?
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(input.Book_Dt) < Crim_Common.Version_In_Arrest_Offender, 
							  fSlashedMDYtoCYMD(input.Book_Dt),
							  '');
self.pty_nm				:= regexreplace(',',input.name,', ');
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
self.street_address_1	:= if(length(stringlib.stringfilterout(trim(input.address,left,right), ' ')) > 5 and
							regexfind('UNKNOW|AT LARGE',StringLib.StringToUpperCase(trim(input.address,left,right)),0)='', 
							regexreplace(' 000 | 0000 | 00000 |\\.|000 0000|\\(HOMELESS\\)|\\(\\)|--|\\`',
							regexfind(searchpattern,StringLib.StringToUpperCase(trim(input.address,left,right)),1),''), 
							'');						
self.street_address_2	:= if(length(regexfind(searchpattern,StringLib.StringToUpperCase(input.address),2))>=4 and 
							regexfind('[A-Z]',regexfind(searchpattern,StringLib.StringToUpperCase(input.address),2)[1],0)<>'',
							regexreplace(' 000 | 0000 | 00000 |\\.|AT LARGE|000 0000|\\(HOMELESS\\)|\\(\\)|--|ATLARGE|REFUSED|'+
							'OUT OF COUNTRY|PBSO @ LARGE|HOMELESS|NONE|NO-DOMICILE|NO LOCAL GIVEN|NO LOCAL ADDRESS|NO LOCAL|NO ADDRESS|H O M E L E S S|ATLARGE|\\`',
							regexfind(searchpattern,StringLib.StringToUpperCase(input.address),2),
							''),'');
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= if(input.race = 'Unknown', '',
						   if(input.race = 'H','Hispanic',
							  input.race));
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

pPalmBeach := project(fPalmBeach, tPalmBeach(left));

pPBFilter  := pPalmBeach(regexfind(' TEST |'+' test |'+'000TEST |'+'000test ', street_address_1)<>(boolean)'TRUE');

ArrestLogs.ArrestLogs_clean(pPBFilter,cleanPalmBeach);
//arrOut:= cleanPalmBeach + ArrestLogs.FileAbinitioOffender(vendor='AM');

dd_arrOut := dedup(sort(distribute(cleanPalmBeach,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,source_file,local)
										,offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Arrestlogs_FL_PalmBeach_Offender');

export map_FL_PalmBeachOffender := dd_arrOut;