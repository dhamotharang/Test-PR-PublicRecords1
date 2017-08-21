import crim_common, Crim, Address, lib_stringlib;

inf := crim.File_SC_Greenville(firstname <> 'FirstName' and parytypedescription = 'Defendant');

Crim_Common.Layout_In_Court_Offender rSC(crim.Layout_SC_Greenville l) := Transform

state(string address1) := stringlib.stringtouppercase(trim(address1[length(trim(address1, left, right)) - stringlib.stringfind( StringLib.StringReverse(trim(address1, left, right)), ' SC', 1)+1..75]));
addrp1(string address1) := stringlib.stringtouppercase(address1[1..25][1.. 25-stringlib.stringfind(StringLib.StringReverse(address1[1..25]), ' ', 1)]);
addrp2(string address1) := stringlib.stringtouppercase(address1[26-stringlib.stringfind(StringLib.StringReverse(address1[1..25]), ' ', 1)..length(trim(address1, left, right)) - stringlib.stringfind( StringLib.StringReverse(trim(address1, left, right)), ',', 1)]);
searchpattern0 := '^(.*)/(.*)/(.*)$';

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_Development;
self.offender_key		:= '2Q'+trim(l.casenumber,left,right)+hash32(l.partiesname);
self.vendor				:= '2Q';
self.state_origin		:= 'SC';
self.data_type			:= '2';
self.source_file		:= 'SC_Greenville_CRIM_COURT';
self.case_number		:= trim(l.casenumber,left,right);
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(l.fileddate) between '19000101' and Crim_Common.Version_Development,
							fSlashedMDYtoCYMD(l.fileddate),
							'');
self.pty_nm				:= l.partiesname;
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
self.dob				:= if(fSlashedMDYtoCYMD(l.partiesdob)between '19000101' and (string)((integer)Crim_Common.Version_Development - 160000),
							fSlashedMDYtoCYMD(l.partiesdob),
							'');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= trim(regexreplace(',', addrp1(l.partiesaddress), ''), left, right);
self.street_address_2	:= trim(regexreplace(',|(00000)', addrp2(l.partiesaddress), ''), left, right);
self.street_address_3	:= if(trim(regexreplace(',', state(l.partiesaddress), ''), left, right) = trim(regexreplace(',', addrp1(l.partiesaddress), ''), left, right), '' , trim(regexreplace(',', state(l.partiesaddress), ''), left, right));
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= if(l.partiesrace <> 'Other' and l.partiesrace <> 'unknown' and l.partiesrace <> 'Unknown', l.partiesrace, '');
self.sex				:= stringlib.stringfilter(l.partiessex[1..1], 'FM');
self.hair_color			:= '';
self.hair_color_desc	:= '';
self.eye_color			:= '';
self.eye_color_desc		:= '';
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= '';
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

refOffender := project(inf, rSC(left))(regexfind('[A-Z]', pty_nm) and regexfind('[0-9]', case_number));

Crim.Crim_clean(refOffender,cleanOffender);

dedOffender := dedup(sort(distribute(cleanOffender,hash(offender_key)),
										offender_key,case_number,case_court,pty_nm,pty_nm_fmt,pty_typ,-dob,-street_address_1,local),
										offender_key,pty_nm,dob,local) 
										:PERSIST('~thor_dell400::persist::Crim_SC_Greenville_Offender_Clean')
										;

export Map_sC_Greenville_Offender := dedOffender;