//Source: Alpharetta-Scrape

import Crim_Common, CRIM, Address, lib_stringlib;

ds_def := CRIM.File_OH_Pickaway.File_OH_Pickaway_Defendant;

d := distribute(ds_def, hash32(def_id));

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

Crim_Common.Layout_In_Court_Offender tOHOffend(d input) := Transform
		
	clean_def_name				:= stringlib.stringfilter(stringlib.stringtouppercase(input.def_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	self.process_date			:= Crim_Common.Version_Development;
	self.offender_key			:= '3J'+input.case_type[1]+hash(clean_def_name)+input.case_num+fSlashedMDYtoCYMD(input.file_dt);
	self.vendor					:= '3J';
	self.state_origin			:= 'OH';
	self.data_type				:= '2';
	self.source_file			:= '(CP)OH Pickaway Cnty';
	self.case_number			:= input.case_num;
	self.case_court				:= '';
	self.case_name				:= '';
	self.case_type				:= input.case_type[1];
	self.case_type_desc			:= input.case_type;
	self.case_filing_dt			:= if(fSlashedMDYtoCYMD(stringlib.stringfindreplace(input.file_dt, '-', '/')) between '19000101' and Crim_Common.Version_Development,
										fSlashedMDYtoCYMD(stringlib.stringfindreplace(input.file_dt, '-', '/')),'');
	self.pty_nm					:= trim(input.def_name, left);
	self.pty_nm_fmt				:= 'L';
	self.orig_lname				:= '';
	self.orig_fname				:= '';    
	self.orig_mname				:= '';
	self.orig_name_suffix		:= '';
	self.pty_typ				:= '0';
	self.nitro_flag				:= '';
	self.orig_ssn				:= '';
	self.dle_num				:= '';
	self.fbi_num				:= '';
	self.doc_num				:= '';
	self.ins_num				:= '';
	self.id_num				:= '';
	self.dl_num				:= if(input.license_num = 'Confidential', '', input.license_num);
	self.dl_state				:= input.LIC_ST_CD;
	self.citizenship			:= '';
	self.dob					:= if(fSlashedMDYtoCYMD(stringlib.stringfindreplace(input.dob, '-', '/')) between '19000101' and Crim_Common.Version_Development,
								fSlashedMDYtoCYMD(stringlib.stringfindreplace(input.dob, '-', '/')),'');
	self.dob_alias				:= '';
	self.place_of_birth			:= '';
	self.street_address_1		:= if (trim(input.street,left,right) = '0' or 
									trim(input.street,left,right) = '00' or 
									trim(input.street,left,right) = '000' or 
									trim(input.street,left,right) = '0000', '', 
									regexreplace('[\\*|"|`|<<|.\\\\]|---|/|00000|0000000|0000000000|000000000000000|000ooo|ooo', trim(input.street,left,right), ''));
	self.street_address_2		:= '';
	self.street_address_3		:= if(regexfind('[a-zA-Z]', input.city), trim(stringlib.stringfilterout(regexreplace('[\\*|\\[|\\]|"|\\(|/|«|\\)|,|/|`|<|@|>|.\\\\]', input.city, ''), '0123456789'),left, right), '');
		self.street_address_4		:= if(length(input.state)>2 and regexfind('[A-Za-z]', input.state) or length(input.state) = 2 and stringlib.stringtouppercase(input.state) 
								in ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA','GU','HI','ID','IL','IN','IA','KS','KY','LA','ME','MH','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP','OH','OK','OR','PW','PA','PR','RI','SC','SD','TN','TX','UT','VT','VI','VA','WA','WV','WI','WY','AE','AA','AE','AE','AE','AP'], stringlib.stringtouppercase(trim(input.state,left,right)),''); 
	self.street_address_5		:= if((length(trim(input.zip,left,right)) = 5 or length(trim(input.zip,left,right)) = 9) and
							     regexfind('[1-9]', input.zip), trim(input.zip,left,right),'');
	self.race					:= '';
	self.race_desc				:= MAP(trim(input.race,left, right) = 'White\\Caucasian' => 'White',
									trim(input.race,left,right) ='African American' => 'Black',
										trim(input.race,left,right) ='American Indian' => 'Indian',
										trim(input.race,left,right) ='Undocumented' => '',
											trim(input.race,left,right));
	self.sex					:= if(trim(input.sex,left,right)[1] in ['F','M'], trim(input.sex,left,right)[1],'');
	self.hair_color			:= '';
	self.hair_color_desc		:= IF(input.hair = 'Undocumented', '', input.hair);
	self.eye_color				:= '';
	self.eye_color_desc			:= IF(input.eye = 'Undocumented', '', input.eye);
	self.skin_color			:= '';
	self.skin_color_desc		:= input.skin;
	self.height				:= if((integer)trim(heightToInches(Input.Height), all) between 36 and 96 and length(trim(heightToInches(Input.Height), all))=2,
							     '0'+trim(heightToInches(Input.Height),all),
							       if((integer)trim(heightToInches(Input.Height),all) between 36 and 96,
							          trim(heightToInches(Input.Height),all),
							               ''));
	self.weight				:= if((integer)trim(input.weight,left,right) between 50 and 500 and length(trim(input.weight,left,right))=2,
							'0'+trim(input.weight,left,right),
							if((integer)trim(input.weight,left,right) between 50 and 500,
							trim(input.weight,left,right),
							''));
	self.party_status			:= '';
	self.party_status_desc		:= regexreplace('.',input.case_status, '');
	self.prim_range 			:= ''; 
	self.predir 				:= '';					   
	self.prim_name 			:= '';
	self.addr_suffix 			:= '';
	self.postdir 				:= '';
	self.unit_desig 			:= '';
	self.sec_range 			:= '';
	self.p_city_name 			:= '';
	self.v_city_name 			:= '';
	self.state 				:= '';
	self.zip5 				:= '';
	self.zip4 				:= '';
	self.cart 				:= '';
	self.cr_sort_sz 			:= '';
	self.lot 					:= '';
	self.lot_order 			:= '';
	self.dpbc 				:= '';
	self.chk_digit 			:= '';
	self.rec_type 				:= '';
	self.ace_fips_st			:= '';
	self.ace_fips_county		:= '';
	self.geo_lat 				:= '';
	self.geo_long 				:= '';
	self.msa 					:= '';
	self.geo_blk 				:= '';
	self.geo_match 			:= '';
	self.err_stat 				:= '';
	self.title 				:= '';
	self.fname 				:= '';
	self.mname 				:= '';
	self.lname 				:= '';
	self.name_suffix 			:= '';
	self.cleaning_score 		:= ''; 

end;

pOHOffend := project(d, tOHOffend(left));

Crim.Crim_clean(pOHOffend,cleanOHOffend);

fOHOffend := dedup(sort(distribute(cleanOHOffend,hash(offender_key)),
				offender_key,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,street_address_1,local),
					offender_key,pty_nm,pty_nm_fmt,pty_typ,dob,street_address_1,local,left)
					: PERSIST('~thor_data400::persist::Crim_OH_Pickaway_Offender');


export Map_OH_Pickaway_Offender := fOHOffend;