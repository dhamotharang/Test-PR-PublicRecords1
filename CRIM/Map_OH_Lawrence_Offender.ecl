//Source: Alpharetta-Scrape

import crim_common, Crim, Address;

c :=crim.File_OH_Lawrence.File_OH_Lawrence_Defendant_CommonPleas;

Layout_OH_Lawrence_Defendant_append := record
Crim.Layout_OH_Ross_Defendant;
string case_court;
end;

Layout_OH_Lawrence_Defendant_append pOHOffend(c input) := Transform
self := input;
self.case_court := 'CommonPleas';
end;

preOHOffend1 := project(c, pOHOffend(left));

d := crim.File_OH_Lawrence.File_OH_Lawrence_Defendant_Mun;

Layout_OH_Lawrence_Defendant_append mOHOffend(d input) := Transform
self := input;
self.case_court := 'Municipal';
end;

preOHOffend2 := project(d, mOHOffend(left));

input := preOHOffend1+preOHOffend2;
// Alias file had more garbage like business names, addresses etc. than meaningful names 
// so it has been decided to not use it for now.
// ds_alias := crim.File_OH_Lawrence_Alias.File_OH_Lawrence_Alias_Mun;


// layout_defendant := RECORD
   // preConcat;
   // crim.Layout_OH_Ross_Alias -def_id;
	 
// END;

// layout_defendant   jdef_alias(preConcat L, ds_alias R) := TRANSFORM
   // SELF := L;
   // SELF := R;
// END;

	
		
// ds_def_alias				:=JOIN(preConcat, ds_alias 
							// , LEFT.def_id  = RIGHT.def_id
								// , jdef_alias(left,right), LEFT OUTER); 

// output(ds_def_alias);

// in := ds_def_alias;
// new_layout := record
	// ds_def_alias;
	// string72 pty_nm;
	// string2 pty_typ;
// end;	

// new_layout NormFile(in L, INTEGER C) := TRANSFORM
// SELF := L;
// SELF.pty_nm := choose(C, l.Def_Name, l.alias);
// SELF.pty_typ := choose(C, '0', '2');
// END;

// nDef := NORMALIZE(in, 2 ,NormFile(LEFT,COUNTER));
// input	:= nDef(pty_nm <>'');
// dis:= distribute(input, hash32(def_id));

dOffend:= distribute(input, hash32(def_id));

			
				
Crim_Common.Layout_In_Court_Offender tOHOffend(dOffend input) := Transform

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
		
	clean_def_name				:= stringlib.stringfilter(stringlib.stringtouppercase(input.def_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	self.process_date			:= Crim_Common.Version_Development;
	self.offender_key			:= '3I'+if(input.case_court = 'Municipal', 'M', 'S')
									   +input.case_type[1]+hash(clean_def_name)+input.case_num+fSlashedMDYtoCYMD(input.file_dt);	
	self.vendor					:= '3I';
	self.state_origin			:= 'OH';
	self.data_type				:= '2';
	self.source_file			:= '(CP)OH Lawrence Cnty';
	self.case_number			:= input.case_num;
	self.case_court				:= input.case_court;
	self.case_name				:= '';
	self.case_type				:= input.case_type[1];
	self.case_type_desc			:= input.case_type;
	self.case_filing_dt			:= map(fSlashedMDYtoCYMD(input.file_dt)[1..2] between '19' and '20' 
									and fSlashedMDYtoCYMD(stringlib.stringfindreplace(input.file_dt, '-', '/'))<Crim_Common.Version_Development =>
									fSlashedMDYtoCYMD(stringlib.stringfindreplace(input.file_dt, '-', '/')),'');
	self.pty_nm					:= 	regexreplace('[\\*|"|.\\\\]', input.def_name, '');
								
	self.pty_nm_fmt			 	:= 'L';
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
	self.dl_num					:= if(input.license_num ='Confidential', '', input.license_num);
	self.dl_state				:= input.LIC_ST_CD;
	self.citizenship			:= '';
	self.dob					:= if(fSlashedMDYtoCYMD(input.dob)[1..4] between '1900' and '1989' and fSlashedMDYtoCYMD(input.dob)[1..8] <> '19010101',
									fSlashedMDYtoCYMD(stringlib.stringfindreplace(input.dob, '-', '/')),'');
	self.dob_alias				:= '';
	self.place_of_birth			:= '';
	self.street_address_1		:= regexreplace('[\\*|"|.\\\\]|---|0|00|000|0000|00000|0000000|0000000000|00000000000|000ooo|ooo', trim(input.street,left,right), '');
	self.street_address_2		:= '';
	self.street_address_3		:= regexreplace('[\\*|"|.\\\\]|---|999|0|00|000|0000|00000|0000000|0000000000|00000000000|000ooo', trim(input.city,left,right), '');
	self.street_address_4		:= if(regexfind('[a-zA-Z]', input.state), stringlib.stringfilterout(regexreplace('[\\*|\\[|\\]|"|\\(|/|\\)|,|.\\\\]', trim(input.state,left,right), ''), '0123456789'), '');
	self.street_address_5		:= if(regexfind('[1-9]', input.zip), stringlib.stringfilter(regexreplace('[\\*|"|.\\\\]', trim(input.zip,left,right), ''), '0123456789'), '');
	self.race					:= '';
	self.race_desc				:= MAP(trim(input.race,left, right) = 'White\\Caucasian' => 'White',
									trim(input.race,left,right) ='African American' => 'Black',
										trim(input.race,left,right) ='American Indian' => 'Indian',
										trim(input.race,left,right) ='Spanish' => 'Spanish',
										trim(input.race,left,right) ='Japanese' => 'Asian',
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
	self.height				:= if((integer)trim(heightToInches(Input.Height), all) between 36 and 96 and length(trim(heightToInches(Input.Height), all))=2,
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

pOHOffender := project(dOffend, tOHOffend(left));

Crim.Crim_clean(pOHOffender,cleanOHOffend);

fOHOffend := dedup(sort(distribute(cleanOHOffend,hash(offender_key)),
			offender_key,case_number,pty_nm,dob,street_address_1,case_filing_dt,local),
				offender_key,case_number,pty_nm,dob,street_address_1,local,right)
					:PERSIST('~thor_data400::persist::Crim_OH_Lawrence_Offender');
export Map_OH_Lawrence_Offender := fOHOffend;
