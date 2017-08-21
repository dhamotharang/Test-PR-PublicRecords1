import Crim_Common, Address, arrestlogs, lib_stringlib;

d	:= distribute(CRIM.File_MO_Statewide, hash(caseno));

p := d(d.CaseNo <> '' and trim(d.Name,left,right)<>'' and ~regexfind('[0-9]', d.name) and ~regexfind('[a-z]', d.DateFiled));

Crim_Common.Layout_In_Court_Offender tMo(p l) := Transform

	string8     fSlashedMDYtoCYMD(string pDateIn) 
	:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
	+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
	+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

	prep_address					:= stringlib.stringfilter(trim(l.address, left, right),
										' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ,');
	
	prep_state 						:= if(regexfind(',', prep_address, 0)<>'',
										trim(prep_address[length(prep_address)-stringlib.stringfind(stringLib.StringReverse(trim(prep_address, left, right)), ',', 1)+2..length(prep_address)-stringlib.stringfind(stringLib.StringReverse(trim(prep_address, left, right)), ',', 1)+4]),
										'XX');
																	
	prep_city						:= if(regexfind(',', prep_address, 0)<>'',
										prep_address[1..stringlib.stringfind(trim(prep_address, left, right), ',', 1)-1],
										'XX');
	
	string c_4token  				:= if(trim(regexreplace(',', prep_city, ''), left, right)<>'',
										regexreplace(',', prep_city[stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-3)+1..stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-3)+40], ''),
										'XX');
		
	string c_3token  				:= if(trim(regexreplace(',', prep_city, ''), left, right)<>'',
										regexreplace(',', prep_city[stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-2)+1..stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-2)+40], ''),
										'XX');
	
	string c_2token  				:= if(trim(regexreplace(',', prep_city, ''), left, right)<>'',
										regexreplace(',', prep_city[stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-1)+1..stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-1)+40], ''),
										'XX');
	
	string c_1token  				:= if(trim(regexreplace(',', prep_city, ''), left, right)<>'',
										regexreplace(',', prep_city[stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' '))+1..stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' '))+40], ''),
										'XX');
	
	//city list derived from zip
	drvd_city 						:= if(trim(regexreplace(',', l.zip, ''), left, right)<>'',
										trim(regexreplace('[0-9]|,', ziplib.ZipToCities(stringlib.stringfilter(l.zip, '0123456789')[1..5]), ''), left, right),
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
											if(regexfind(',', prep_address, 0)<>'',
											prep_address[1..stringlib.stringfind(prep_address, ',', 1)-1-stringlib.stringfind(StringLib.StringReverse(trim(prep_address, left, right)), ',', 1)-1],
											''));
	
	address2						:= lib_StringLib.StringLib.StringToUpperCase(trim(prsd_city,left,right) + if(trim(prsd_city, left, right) <> '',', ','') + trim(prep_state, left, right) + ' ' + trim(l.zip, left, right)[1..5]);

searchpattern0 := '^(.*)/(.*)/(.*)$';

self.process_date 		:= Crim_Common.Version_Development;
self.offender_key 		:= '1Y' + trim(l.caseno) + hash(trim(l.location) + ' ' + trim(l.court));
self.vendor 			:= '1Y';//NEED TO UPDATE
self.state_origin 		:= 'MO';
self.source_file 		:= '(CV)MO-StatewideCrim';
self.data_type			:= '2';
self.case_number		:= trim(l.caseno);
self.case_court			:= trim(l.location) + ' ' + trim(l.court);
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= fSlashedMDYtoCYMD(l.DateFiled);
self.pty_nm				:= regexreplace(' +,' ,trim(l.Name,left,right), ',');
self.pty_nm_fmt			:= if(regexfind(',', l.name), 'L', 'F');
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
self.dob				:= if(trim(l.dob) > '1910' and trim(l.dob) < '1992', l.dob[1..4], '');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= if(address1<>'' and length(address1)>3,
								regexreplace('WW|XX|YY|ZZ|UNKNOWN| SAINT$', trim(address1, left, right), ''),
								if(regexfind(',', prep_address, 0)='' and length(prep_address)>3,
								regexreplace('WW|XX|YY|ZZ|UNKNOWN', prep_address, ''),
								''));
self.street_address_2	:= if(length(trim(regexreplace('WW|XX|YY|ZZ|UNKNOWN|,', address2, ''), left, right))>0,
								regexreplace('WW|XX|YY|ZZ|UNKNOWN', trim(address2, left, right), ''),
								'');
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

pMO := project(p, tMO(left));

CRIM.Crim_clean(pMO,cleanMO);

dd_MOOut := 
dedup(
sort(cleanMO
									,offender_key,title,fname,mname,lname,name_suffix ,pty_typ,local)
									,offender_key,title,fname,mname,lname,name_suffix ,pty_typ,left,local)									
									;

export Map_MO_StatewideOffender := dd_MOOut(pty_nm <> '')
:PERSIST('~thor_dell400::persist::Criminal_MO_Statewide_Offender')
;