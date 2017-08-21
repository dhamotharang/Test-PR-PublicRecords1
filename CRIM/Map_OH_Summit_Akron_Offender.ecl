
//Source: Alpharetta-Scrape

import Crim_Common, CRIM, Address, lib_stringlib;

c :=sort(CRIM.File_OH_Summit_Akron.Defendant(trim(def_name, left,right) <> '' and trim(def_id, left, right) <>'DefendantID'), def_id);


dist:= distribute(c, hash32(def_id));


String 		heightToInches(String s) := FUNCTION

	cleanheight 	:= regexreplace('[\\\'|"]', trim(s, all), '');
	height_ft		:=(integer)cleanheight[1..1];
	height_in		:=(integer)cleanheight[2..5];
	return (string)intformat((height_ft*12+height_in), 3, 1);
	
END;

string8     	fSlashedMDYtoCYMD(string pDateIn) 
				:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
				+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
				+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

Crim_Common.Layout_In_Court_Offender tOHOffend(dist input) := Transform

//dob
dob := if(fSlashedMDYtoCYMD(input.dob)[1..8] >= '19000101'  
								and ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)fSlashedMDYtoCYMD(input.dob)[1..4])>=18,
									fSlashedMDYtoCYMD(trim(input.dob,left,right)),'');
									
//FileDate
FileDate := if(fSlashedMDYtoCYMD(input.File_dt) between '19000101' and Crim_Common.Version_Development, fSlashedMDYtoCYMD(input.File_dt),'');  

	self.process_date			:= Crim_Common.Version_Development;
	self.offender_key			:= '4G'+hash(input.def_name)+input.case_num+fSlashedMDYtoCYMD(input.file_dt);	
	self.vendor					:= '4G';
	self.state_origin			:= 'OH';
	self.data_type				:= '2';
	self.source_file			:= '(CP)OH Summit Akron';
	self.case_number			:= input.case_num;
	self.case_court				:= '';
	self.case_name				:= '';
	self.case_type				:= '';
	self.case_type_desc		:= input.case_type;
	self.case_filing_dt		:= FileDate;
	self.pty_nm						:= regexreplace(',', stringlib.stringtouppercase(input.def_name), ''),
	self.pty_nm_fmt				:= 'L';
	self.orig_lname				:= '';
	self.orig_fname				:= '';    
	self.orig_mname				:= '';
	self.orig_name_suffix	:= '';
	self.pty_typ					:= '0';
	self.nitro_flag				:= '';
	self.orig_ssn					:= '';
	self.dle_num					:= '';
	self.fbi_num					:= '';
	self.doc_num					:= '';
	self.ins_num					:= '';
	self.id_num				  	:= '';
	self.dl_num				  	:= input.license_num;
	self.dl_state			  	:= input.lic_st_cd;
	self.citizenship			:= '';
	self.dob					  	:= dob;
	self.dob_alias				:= '';
	self.place_of_birth		:= '';
	self.street_address_1	:= input.street;
	self.street_address_2	:= '';
	self.street_address_3	:= input.city;
	self.street_address_4	:= input.state; 
	self.street_address_5	:= input.zip;
	self.race							:= '';
	self.race_desc				:= input.race;
	self.sex							:= if(trim(input.sex,left,right)[1] in ['F','M'],trim(input.sex,left,right)[1],'');
	self.hair_color				:= '';
	self.hair_color_desc	:= input.hair;
	self.eye_color				:= '';
	self.eye_color_desc		:= input.eye;
	self.skin_color				:= '';
	self.skin_color_desc	:= input.skin;
	self.height						:= if((integer)trim(heightToInches(Input.Height), all) between 36 and 96 and length(trim(heightToInches(Input.Height), all))=2,
                                               '0'+trim(heightToInches(Input.Height),all),
                                                  if((integer)trim(heightToInches(Input.Height),all) between 36 and 96,
                                                     trim(heightToInches(Input.Height),all),''));
	self.weight						:= 	if(input.weight='Undocumented','', if((integer)trim(input.weight,left,right) between 50 and 500 and length(trim(input.weight,left,right))=2,
                                               '0'+trim(input.weight,left,right),
                                                  if((integer)trim(input.weight,left,right) between 50 and 500,
                                                     trim(input.weight,left,right),'')));
	self.party_status			:= '';
	self.party_status_desc:= regexreplace('.',input.case_status, '');
	self.prim_range 			:= ''; 
	self.predir 				  := '';					   
	self.prim_name 				:= '';
	self.addr_suffix 			:= '';
	self.postdir 					:= '';
	self.unit_desig 			:= '';
	self.sec_range 				:= '';
	self.p_city_name 			:= '';
	self.v_city_name 			:= '';
	self.state 						:= '';
	self.zip5 						:= '';
	self.zip4 						:= '';
	self.cart 						:= '';
	self.cr_sort_sz 			:= '';
	self.lot 							:= '';
	self.lot_order 				:= '';
	self.dpbc 						:= '';
	self.chk_digit 				:= '';
	self.rec_type 				:= '';
	self.ace_fips_st			:= '';
	self.ace_fips_county	:= '';
	self.geo_lat 					:= '';
	self.geo_long 				:= '';
	self.msa 							:= '';
	self.geo_blk 					:= '';
	self.geo_match 				:= '';
	self.err_stat 				:= '';
	self.title 						:= '';
	self.fname 						:= '';
	self.mname 						:= '';
	self.lname 						:= '';
	self.name_suffix 			:= '';
	self.cleaning_score 	:= ''; 

end;

pOHOffend := project(dist, tOHOffend(left));

Crim.Crim_clean(pOHOffend,cleanOHOffend);

 fOHOffend := dedup(sort(distribute(cleanOHOffend,hash(offender_key)),  
				            offender_key,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,street_address_1,case_filing_dt,local),
					            offender_key,pty_nm,pty_nm_fmt,pty_typ,dob,street_address_1,local,right): 
					              	 PERSIST('~thor_data400::persist::Crim_OH_Akron_Offender');

export Map_OH_Summit_Akron_Offender := fOHOffend;

