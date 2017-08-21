import crim_common, Crim, Address, lib_stringlib;

input := crim.File_SC_York(parytypedescription = 'Defendant');

//////////////////////////////////////////////////////////////////////////////////

String heightToInches(String s) := FUNCTION
cleanheight := regexreplace('[^0-9]', s, '');
height_ft:=(integer)cleanheight[1..1];
height_in:=(integer)cleanheight[2..5];
return (string)intformat((height_ft*12+height_in), 3, 1);
END;

//////////////////////////////////////////////////////////////////////////////////

Crim_Common.Layout_In_Court_Offender rOK(input l) := Transform

	prep_address					:= stringlib.stringfilter(trim(StringLib.StringToUpperCase(l.partiesaddress), left, right), ' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ,');

	pzip							:= if((string)stringlib.stringfind(prep_address, regexfind('[0-9]+$', prep_address, 0), 1)<>'',
										prep_address[stringlib.stringfind(prep_address, regexfind('[0-9]+$', prep_address, 0), 1)..length(prep_address)],
										'');
										
	prep_zip						:= if(length(trim(pzip, left, right))>5,
										pzip[1..5],
										pzip);

	pstate							:= prep_address[stringlib.stringfind(prep_address, regexfind('[0-9]+$', prep_address, 0), 1)-3..stringlib.stringfind(prep_address, regexfind('[0-9]+$', prep_address, 0), 1)-1];

	prep_state						:= if(pstate in ['AL','AK','AZ','AR','CA','CO','CT','DE','DC','FL',
													'GA','HI','ID','IL','IN','IA','KS','KY','LA','ME',
													'MD','MA','MI','MN','MS','MO','MT','NE','NV','NH',
													'NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI',
													'SC','SD','TN','TX','UT','VT','VA','WA','WV','WI',
													'WY'],
										pstate,
										'');
	
	prep_city						:= prep_address[1..stringlib.stringfind(prep_address, regexfind('[0-9]+$', prep_address, 0), 1)-5];

	string c_4token  				:= if(trim(prep_city, left, right)<>'',
											prep_city[stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-3)+1..stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-3)+40],
											'XX');
		
	string c_3token  				:= if(trim(prep_city, left, right)<>'',
											prep_city[stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-2)+1..stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-2)+40],
											'XX');
	
	string c_2token  				:= if(trim(prep_city, left, right)<>'',
											prep_city[stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-1)+1..stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-1)+40],
											'XX');
	
	string c_1token  				:= if(trim(prep_city, left, right)<>'',
											prep_city[stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' '))+1..stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' '))+40],
											'XX');
	
	//city list derived from zip
	drvd_city 						:= if(trim(prep_zip, left, right)<>'',
											trim(regexreplace('[0-9]|,', ziplib.ZipToCities(stringlib.stringfilter(prep_zip, '0123456789')[1..5]), ''), left, right),
											'XX');
	
	//city pulled from input address line 1 that exists in derived list
	prsd_city 						:= if(trim(c_4token,left,right)<>'' and drvd_city<>'' and regexfind(trim(c_4token,left,right),drvd_city),
											c_4token,
											if(trim(c_3token,left,right)<>'' and drvd_city<>'' and regexfind(trim(c_3token,left,right),drvd_city),
											c_3token,
											if(trim(c_2token,left,right)<>'' and drvd_city<>'' and regexfind(trim(c_2token,left,right),drvd_city),
											c_2token,
											if(trim(c_1token,left,right)<>'' and drvd_city<>'' and regexfind(trim(c_1token,left,right),drvd_city),
											c_1token,
											''))));
											
	address1 						:= if(prsd_city != '',
											lib_StringLib.StringLib.StringToUpperCase(trim(regexreplace(trim(prsd_city,left,right),prep_city,''),left,right)),
											'');
	
	address2						:= lib_StringLib.StringLib.StringToUpperCase(trim(prsd_city,left,right) + if(trim(prsd_city, left, right) <> '',', ','') + trim(prep_state, left, right) + ' ' + trim(prep_zip, left, right)[1..5]);
	
	searchpattern0 := '^(.*)/(.*)/(.*)$';

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_Development;

self.vendor				:= '2X';
self.state_origin		:= 'SC';
self.data_type			:= '2';
self.source_file		:= 'SC_YORK_CRIM_COURT';
self.case_number		:= trim(l.casenumber,left,right);
self.case_court			:= l.CourtAgency;
self.case_name			:= '';
self.case_type			:= l.casetype;
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(l.fileddate) between '19000101' and Crim_Common.Version_Development,
							fSlashedMDYtoCYMD(l.fileddate),
							'');
self.pty_nm				:= l.name;
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= l.lastname;
self.orig_fname			:= l.firstname;     
self.orig_mname			:= l.middlename;
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
self.street_address_1	:= address1;
self.street_address_2	:= trim(regexreplace('00000|XX,', address2, ''), left, right);
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= regexreplace('Unknown', l.partiesrace, '');
self.sex				:= l.partiessex;
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

self.offender_key		:= '2X'+ l.id + self.case_filing_dt;

end;

refOffender := project(input, rOK(left))(length(trim(pty_nm, left, right)) > 6 and regexfind('[0-9]', case_number) and ~regexfind('NONEFO', trim(stringlib.stringtouppercase(pty_nm), all)));

Crim.Crim_clean(refOffender,cleanOffender);

dedOffender := dedup(sort(distribute(cleanOffender,hash(offender_key)),
										offender_key,case_number,case_court,pty_nm,pty_nm_fmt,pty_typ,-dob,-race,-sex,-street_address_1,local),
										offender_key,pty_nm,local) 
										:PERSIST('~thor_dell400::persist::Crim_SC_YORK_Offender_Clean')
										;

export Map_SC_YORK_Offender := dedOffender;