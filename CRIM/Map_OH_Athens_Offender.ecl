import Crim_Common, CRIM, Address, lib_stringlib, ut;
//Source: Alpharetta-Scrape
		
				
ds_def := crim.File_OH_Athens.File_OH_Athens_Defendant;
ds_alias := crim.File_OH_Athens.File_OH_Athens_Alias;

string8     	fSlashedMDYtoCYMD(string pDateIn) 
				:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
				+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
				+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
				
layout_defendant := RECORD
   ds_def;
   crim.Layout_OH_Ross_Alias -def_id;
	 
END;

layout_defendant   jdef_alias(ds_def L, ds_alias R) := TRANSFORM
   SELF := L;
   SELF := R;
END;

	
		
ds_def_alias				:=JOIN(ds_def, ds_alias 
							, LEFT.def_id  = RIGHT.def_id and
							  LEFT.def_name <> RIGHT.alias
								, jdef_alias(left,right), LEFT OUTER); 

// output(ds_def_alias);

in := ds_def_alias;
new_layout := record
	ds_def_alias;
	string72 pty_nm;
	string2 pty_typ;
	string60 offender_key;
end;	

new_layout NormFile(in L, INTEGER C) := TRANSFORM
SELF := L;
SELF.pty_nm := choose(C, l.Def_Name, l.alias);
SELF.pty_typ := choose(C, '0', '2');
clean_def_name				:= stringlib.stringfilter(stringlib.stringtouppercase(l.def_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
self.offender_key := '3D'+hash(clean_def_name)+l.case_num+fSlashedMDYtoCYMD(l.file_dt);
END;

nDef := NORMALIZE(in, 2 ,NormFile(LEFT,COUNTER));

rDef := nDef(pty_nm <>'');

input	:= dedup(sort(rdef, pty_nm, case_num, file_dt),pty_nm, case_num, file_dt, left); 

d := distribute(input, hash32(def_id));

String 		heightToInches(String s) := FUNCTION

	cleanheight 	:= regexreplace('[\\\'|"]', trim(s, all), '');
	height_ft		:=(integer)cleanheight[1..1];
	height_in		:=(integer)cleanheight[2..5];
	return (string)intformat((height_ft*12+height_in), 3, 1);
	
END;


Crim_Common.Layout_In_Court_Offender tOHOffend(d input) := Transform
	//clean_def_name				:= stringlib.stringfilter(stringlib.stringtouppercase(input.def_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	self.process_date			:= Crim_Common.Version_Development;
	self.offender_key			:= input.offender_key;
	self.vendor					:= '3D';
	self.state_origin			:= 'OH';
	self.data_type				:= '2';
	self.source_file			:= '(CP)OH ATHENS Cnty';
	self.case_number			:= trim(input.case_num,left,right);
	self.case_court				:= '';
	self.case_name				:= '';
	self.case_type				:= input.case_num[3];
	self.case_type_desc			:= '';
	self.case_filing_dt			:= if(fSlashedMDYtoCYMD(input.file_dt)[1..2] between '19' and '20',
								fSlashedMDYtoCYMD(input.file_dt),'');
	self.pty_nm					:= 	map(input.pty_typ = '0' => input.pty_nm, 
								input.pty_typ = '2'=> input.pty_nm, '');
	self.pty_nm_fmt				:= 'L';
	self.orig_lname				:= '';
	self.orig_fname				:= '';    
	self.orig_mname				:= '';
	self.orig_name_suffix		:= '';
	self.pty_typ				:= input.pty_typ;
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
	self.dob					:= if(fSlashedMDYtoCYMD(input.dob)[1..4] between '1900' and '1989' and fSlashedMDYtoCYMD(input.dob)[1..8] <> '19010101',
								fSlashedMDYtoCYMD(input.dob),'');
	self.dob_alias				:= '';
	self.place_of_birth			:= '';
	self.street_address_1		:= trim(input.street,left,right);
	self.street_address_2		:= '';
	self.street_address_3		:= trim(input.city,left,right);
	self.street_address_4		:= trim(input.state,left,right);
	self.street_address_5		:= trim(input.zip,left,right);
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
	self.height					:= if((integer)trim(heightToInches(Input.Height), all) between 36 and 96 and length(trim(heightToInches(Input.Height), all))=2,
							     '0'+trim(heightToInches(Input.Height),all),
							       if((integer)trim(heightToInches(Input.Height),all) between 36 and 96,
							          trim(heightToInches(Input.Height),all),
							               ''));
	self.weight					:= if((integer)trim(input.weight,left,right) between 50 and 500 and length(trim(input.weight,left,right))=2,
								'0'+trim(input.weight,left,right),
									if((integer)trim(input.weight,left,right) between 50 and 500,
										trim(input.weight,left,right),
											''));
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
				offender_key,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,street_address_1,case_filing_dt,local),
					offender_key,pty_nm,pty_nm_fmt,pty_typ,dob,street_address_1,local,right) ;
					 //:PERSIST('~thor_data400::persist::Crim_OH_Athens_Offender');


export Map_OH_Athens_Offender := fOHOffend;
