import Crim_Common, CRIM, Address, lib_stringlib;
//Source: Alpharetta-Scrape
ds_def := CRIM.File_FL_Sarasota.Defendant(def_id <>'SF186933818');

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
	self.offender_key			:= '3M'+hash(clean_def_name)+input.case_num+fSlashedMDYtoCYMD(input.file_dt);
	self.vendor					:= '3M';
	self.state_origin			:= 'FL';
	self.data_type				:= '2';
	self.source_file			:= '(CP)FL SARASOTA County';
	self.case_number			:= input.case_num;
	self.case_court				:= '';
	self.case_name				:= '';
	self.case_type				:= input.case_num[6..7];
	self.case_type_desc			:= input.case_type;
	self.case_filing_dt			:= if(fSlashedMDYtoCYMD(input.file_dt)[1..2] between '19' and '20',
								fSlashedMDYtoCYMD(input.file_dt),'');
	self.pty_nm					:= trim(input.def_name, right, left);
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
	self.id_num					:= '';
	self.dl_num					:= input.license_num;
	self.dl_state				:= input.LIC_ST_CD;
	self.citizenship			:= '';
	self.dob					:= if(fSlashedMDYtoCYMD(input.dob)[1..8] >= '19000101'  
								and ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)fSlashedMDYtoCYMD(input.dob)[1..4])>=18,
									fSlashedMDYtoCYMD(trim(input.dob,left,right)),'');
	self.dob_alias				:= '';
	self.place_of_birth			:= '';
	self.street_address_1		:= trim(input.street,left,right);
	self.street_address_2		:= '';
	self.street_address_3		:= trim(input.city,left,right);
	self.street_address_4		:= if(regexfind('[a-zA-Z]', input.state), stringlib.stringfilterout(regexreplace('[\\*|\\[|\\]|"|\\(|/|\\)|,|/|.\\\\]', trim(input.state,left,right), ''), '0123456789'), '');
	self.street_address_5		:= if(regexfind('[1-9]', input.zip), stringlib.stringfilter(regexreplace('[\\*|"|.\\\\]', trim(input.zip,left,right), ''), '0123456789'), '');
	self.race					:= '';
	self.race_desc				:= MAP(trim(input.race,left, right) = 'White\\Caucasian' => 'White',
									trim(input.race,left,right) ='African American' => 'Black',
										trim(input.race,left,right) ='American Indian' => 'Indian',
											'');
	self.sex					:= if(trim(input.sex,left,right)[1] in ['F','M'],
									trim(input.sex,left,right)[1],
										'');
	self.hair_color				:= '';
	self.hair_color_desc		:= IF(input.hair = 'Undocumented', '', input.hair);
	self.eye_color				:= '';
	self.eye_color_desc			:= IF(input.eye = 'Undocumented', '', input.eye);
	self.skin_color				:= '';
	self.skin_color_desc		:= input.skin;
	self.height					:= if(regexfind('[1-9]', heightToInches(Input.Height)),
									heightToInches(Input.Height), '');
	self.weight					:= regexreplace('\\.|'+'-', trim(input.weight,all), '');
	self.party_status			:= '';
	self.party_status_desc		:= regexreplace('.',input.case_status, '');
	self.prim_range 			:= ''; 
	self.predir 				:= '';					   
	self.prim_name 				:= '';
	self.addr_suffix 			:= '';
	self.postdir 				:= '';
	self.unit_desig 			:= '';
	self.sec_range 				:= '';
	self.p_city_name 			:= '';
	self.v_city_name 			:= '';
	self.state 					:= '';
	self.zip5 					:= '';
	self.zip4 					:= '';
	self.cart 					:= '';
	self.cr_sort_sz 			:= '';
	self.lot 					:= '';
	self.lot_order 				:= '';
	self.dpbc 					:= '';
	self.chk_digit 				:= '';
	self.rec_type 				:= '';
	self.ace_fips_st			:= '';
	self.ace_fips_county		:= '';
	self.geo_lat 				:= '';
	self.geo_long 				:= '';
	self.msa 					:= '';
	self.geo_blk 				:= '';
	self.geo_match 				:= '';
	self.err_stat 				:= '';
	self.title 					:= '';
	self.fname 					:= '';
	self.mname 					:= '';
	self.lname 					:= '';
	self.name_suffix 			:= '';
	self.cleaning_score 		:= ''; 

end;

pOHOffend := project(d, tOHOffend(left));

Crim.Crim_clean(pOHOffend,cleanOHOffend);

fOHOffend := dedup(sort(distribute(cleanOHOffend,hash(offender_key)),
				offender_key,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,street_address_1,local),
					offender_key,pty_nm,pty_nm_fmt,pty_typ,dob,street_address_1,local,left)
					: PERSIST('~thor_data400::persist::Crim_FL_Sarasota_Offender');


export Map_FL_Sarasota_Offender := fOHOffend;

