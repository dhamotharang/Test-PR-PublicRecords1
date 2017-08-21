import crim_common, Crim, Address, lib_stringlib;

inf := crim.File_OK_PUSHMATAHA;

new_layout := record
	crim.layout_ok_adair;
	string72 pty_nm;
	string2 pty_typ;
end;	

new_layout NormFile(inf L, INTEGER C) := TRANSFORM
SELF := L;
SELF.pty_nm := choose(C, l.PartyName, l.alias);
SELF.pty_typ := choose(C, '0', '2');
END;

input := NORMALIZE(inf, 2 ,NormFile(LEFT,COUNTER));

//////////////////////////////////////////////////////////////////////////////////

String heightToInches(String s) := FUNCTION
cleanheight := regexreplace('[^0-9]', s, '');
height_ft:=(integer)cleanheight[1..1];
height_in:=(integer)cleanheight[2..5];
return (string)intformat((height_ft*12+height_in), 3, 1);
END;

//////////////////////////////////////////////////////////////////////////////////

Crim_Common.Layout_In_Court_Offender rOK(input l) := Transform
/*
state(string address1) := stringlib.stringtouppercase(trim(address1[length(trim(address1, left, right)) - stringlib.stringfind( StringLib.StringReverse(trim(address1, left, right)), ',', 1)+1..75]));
addrp1(string address1) := stringlib.stringtouppercase(address1[1..25][1.. 25-stringlib.stringfind(StringLib.StringReverse(address1[1..25]), ' ', 1)]);
addrp2(string address1) := stringlib.stringtouppercase(address1[26-stringlib.stringfind(StringLib.StringReverse(address1[1..25]), ' ', 1)..length(trim(address1, left, right)) - stringlib.stringfind( StringLib.StringReverse(trim(address1, left, right)), ',', 1)]);
*/
searchpattern0 := '^(.*)/(.*)/(.*)$';
searchpattern1 := '( (.*)-(.*)-([A-Za-z0-9]) )|( (.*)-(.*)-([A-Za-z0-9]+))|(^(.*)-(.*)-([A-Za-z0-9]+))';
searchpattern2 := '( (.*)/(.*)/([A-Za-z0-9]) )|( (.*)/(.*)/([A-Za-z0-9]+))|(^(.*)/(.*)/([A-Za-z0-9]+))';

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_Development;
self.offender_key		:= '2C'+trim(l.casenumber,left,right)+l.id;
self.vendor				:= '2C';
self.state_origin		:= 'OK';
self.data_type			:= '2';
self.source_file		:= 'OK_PUSHMATAHA_CRIM_COURT';
self.case_number		:= trim(l.casenumber,left,right);
self.case_court			:= '';
self.case_name			:= l.caption;
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(l.casefiled) between '19000101' and Crim_Common.Version_Development,
							fSlashedMDYtoCYMD(l.casefiled),
							'');
self.pty_nm				:= regexreplace('[\\*\\(\\)]', trim(regexreplace('^,' , trim(regexreplace(searchpattern2, regexreplace(searchpattern1, if(l.pty_typ = '0' and stringlib.stringtouppercase(l.partytype) = 'DEFENDANT', l.lastname + ', ' + l.firstname + ' ' + l.middlename + ' ' + l.suffix, 
								if(l.pty_typ = '2' and stringlib.stringtouppercase(l.partytype) = 'DEFENDANT', l.pty_nm, '')), ''), ''), left, right), ''), left, right), '');
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= if(l.pty_typ = '2', '', l.lastname);
self.orig_fname			:= if(l.pty_typ = '2', '', l.firstname);     
self.orig_mname			:= if(l.pty_typ = '2', '', l.middlename);
self.orig_name_suffix	:= if(l.pty_typ = '2', '', l.suffix);
self.pty_typ			:= l.pty_typ;
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
self.dob				:= if(fSlashedMDYtoCYMD(l.birthdate)between '19000101' and (string)((integer)Crim_Common.Version_Development - 16),
							fSlashedMDYtoCYMD(l.birthdate),
							'');
self.dob_alias			:= '';
self.place_of_birth		:= '';
/*
self.street_address_1	:= trim(regexreplace('XX+|xx+', if(~regexfind('[A-W]', addrp1(l.address)) , '',trim(regexreplace(',', addrp1(l.address), ''), left, right)), ''), left);
self.street_address_2	:= trim(stringlib.stringfilterout(if(regexfind('(OKLAHOMA)|(ALABAMA)|(ALASKA)|(AMERICAN SAMOA)|(ARIZONA)|(ARKANSAS)|(CALIFORNIA)|(COLORADO)|(CONNECTICUT)|(DELAWARE)|(DISTRICT OF COLUMBIA)|(FEDERATED STATES OF MICRONESIA)|(FLORIDA)|(GEORGIA)|(GUAM)|(HAWAII)|(IDAHO)|(ILLINOIS)|(INDIANA)|(IOWA)|(KANSAS)|(KENTUCKY)|(LOUISIANA)|(MAINE)|(MARSHALL ISLANDS)|(MARYLAND)|(MASSACHUSETTS)|(MICHIGAN)|(MINNESOTA)|(MISSISSIPPI)|(MISSOURI)|(MONTANA)|(NEBRASKA)|(NEVADA)|(NEW HAMPSHIRE)|(NEW JERSEY)|(NEW MEXICO)|(NEW YORK)|(NORTH CAROLINA)|(NORTH DAKOTA)|(NORTHERN MARIANA ISLANDS)|(OHIO)|(PUSHMATAHA)|(OREGON)|(PALAU)|(PENNSYLVANIA)|(PUERTO RICO)|(RHODE ISLAND)|(SOUTH CAROLINA)|(SOUTH DAKOTA)|(TENNESSEE)|(TEXAS)|(UTAH)|(VERMONT)|(VIRGIN ISLANDS)|(VIRGINIA)|(WASHINGTON)|(WEST VIRGINIA)|(WISCONSIN)|(WYOMING)', state(l.address)), state(l.address), ''), ','), left, right);
self.street_address_3	:= '';
 if(trim(regexreplace(',', state(l.address), ''), left, right) = trim(regexreplace(',', addrp1(l.address), ''), left, right), '' , trim(regexreplace(',', state(l.address), ''), left, right));
*/
self.street_address_1	:= l.Address_1;
self.street_address_2	:= l.Address_2;
self.street_address_3	:= l.City + ' ' + l.State + ' ' + l.Zip;
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= if(l.race <> 'unknown' and l.race <> 'Unknown', l.race, '');
self.sex				:= stringlib.stringfilter(l.sex[1..1], 'FM');
self.hair_color			:= '';
self.hair_color_desc	:= l.hair;
self.eye_color			:= '';
self.eye_color_desc		:= if(l.eyes <> 'unknown' and l.eyes <> 'Unknown', l.eyes, '');
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= if(heightToInches(l.height) > '000' and heightToInches(l.height) < '084', heightToInches(l.height), '');
self.weight				:= if((string)intformat((integer)l.weight, 3, 1) between '050' and '400', (string)intformat((integer)l.weight, 3, 1), '');
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

refOffender := project(input, rOK(left))(pty_nm <> '' and ~regexfind('MERGE', pty_nm) and regexfind('[0-9]', case_number) and ~regexfind('NONEFO', trim(stringlib.stringtouppercase(pty_nm), all)));

Crim.Crim_clean(refOffender,cleanOffender);

dedOffender := dedup(sort(distribute(cleanOffender,hash(offender_key)),
										offender_key,case_number,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,-street_address_1,local),
										offender_key,pty_nm,dob,local) 
										:PERSIST('~thor_dell400::persist::Crim_OK_PUSHMATAHA_Offender_Clean')
										;

export Map_OK_PUSHMATAHA_Offender := dedOffender;