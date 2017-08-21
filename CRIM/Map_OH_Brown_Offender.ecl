import crim_common, Crim, Address;

string8     	fSlashedMDYtoCYMD(string pDateIn) 
				:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
				+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
				+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

//join defendant & alias common pleas				
cp_def :=crim.File_OH_Brown.Defendant_CommonPleas;
cp_alias :=crim.File_OH_Brown.Alias_CommonPleas;

layout_cp_defendant := RECORD
   cp_def;
   crim.Layout_OH_Ross_Alias -def_id;
	 
END;

layout_cp_defendant   jcpdef_alias(cp_def L, cp_alias R) := TRANSFORM
 SELF := L;
 SELF := R;
END;
		
cp_def_alias				:=JOIN(cp_def, cp_alias 
							, LEFT.def_id  = RIGHT.def_id and
							  LEFT.def_name <> Right.alias
								, jcpdef_alias(left,right), LEFT OUTER); 

//join defendant & alias municipal														
mun_def :=crim.File_OH_Brown.Defendant_Mun;
mun_alias :=crim.File_OH_Brown.Alias_Mun;

layout_mun_defendant := RECORD
   mun_def;
   crim.Layout_OH_Ross_Alias -def_id;
	 
END;

layout_mun_defendant   jmundef_alias(mun_def L, mun_alias R) := TRANSFORM
 SELF := L;
 SELF := R;
END;
		
mun_def_alias				:=JOIN(mun_def, mun_alias 
							, LEFT.def_id  = RIGHT.def_id and
							  LEFT.def_name <> Right.alias
								, jmundef_alias(left,right), LEFT OUTER); 

//create case_court to identify common pleas record
c :=cp_def_alias;

Layout_OH_Brown_Defendant_append := record
cp_def_alias;
string case_court;
end;

Layout_OH_Brown_Defendant_append pOHOffend(c input) := Transform
self := input;
self.case_court := 'CommonPleas';
end;

preOHOffend1 := project(c, pOHOffend(left));

//create case_court to identify municipal record
d := mun_def_alias	;

Layout_OH_Brown_Defendant_append mOHOffend(d input) := Transform
self := input;
self.case_court := 'Municipal';
end;

preOHOffend2 := project(d, mOHOffend(left));

//join municipal and common pleas files
preConcat := preOHOffend1+preOHOffend2;

//normalize the defendant and alias names
in := preConcat;
new_layout := record
	preConcat;
	string72 pty_nm;
	string2 pty_typ;
	string60 offender_key;
end;	

new_layout NormFile(in L, INTEGER C) := TRANSFORM
SELF := L;
SELF.pty_nm := choose(C, l.Def_Name, l.alias);
SELF.pty_typ := choose(C, '0', '2');
clean_def_name				:= stringlib.stringfilter(stringlib.stringtouppercase(l.def_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
self.offender_key := hash(clean_def_name)+l.case_num+fSlashedMDYtoCYMD(l.file_dt);
END;

nDef := NORMALIZE(in, 2 ,NormFile(LEFT,COUNTER));
input	:= nDef(pty_nm <>'');
dis:= distribute(input, hash32(def_id));

			
				
Crim_Common.Layout_In_Court_Offender tOHOffend(dis input) := Transform

String 		heightToInches(String s) := FUNCTION

	cleanheight 	:= regexreplace('[\\\'|"]', trim(s, all), '');
	height_ft		:=(integer)cleanheight[1..1];
	height_in		:=(integer)cleanheight[2..5];
	return (string)intformat((height_ft*12+height_in), 3, 1);
	
END;


	integer brace1  		:=  StringLib.StringFind(input.pty_nm,'(',1);
	varstring clean_pty_nm	:=  IF (brace1 >0 ,input.pty_nm[1..brace1-1], input.pty_nm);
	
	clean_def_name				:= stringlib.stringfilter(stringlib.stringtouppercase(input.pty_nm),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	self.process_date			:= Crim_Common.Version_Development;
	self.offender_key			:= if(input.case_court = 'Municipal', '3F', '4D')+if(input.case_court = 'Municipal', 'M', 'S')
									    +input.case_type[1]+input.offender_key;	
	self.vendor					:= if(input.case_court = 'Municipal', '3F', '4D');
	self.state_origin			:= 'OH';
	self.data_type				:= '2';
	self.source_file			:= if(input.case_court = 'Municipal','(CP)OH BROWN MUN', '(CP)OH BROWN CPLEAS');
	self.case_number			:= input.case_num;
	self.case_court				:= input.case_court;
	self.case_name				:= '';
	self.case_type				:= input.case_type[1];
	self.case_type_desc			:= input.case_type;
	self.case_filing_dt			:= map(fSlashedMDYtoCYMD(input.file_dt)[1..2] between '19' and '20' 
									and fSlashedMDYtoCYMD(stringlib.stringfindreplace(input.file_dt, '-', '/'))<Crim_Common.Version_Development =>
										fSlashedMDYtoCYMD(stringlib.stringfindreplace(input.file_dt, '-', '/')),'');
	self.pty_nm					:= 	map(input.pty_typ = '0' => regexreplace('[\\*|"|.\\\\]', clean_pty_nm, ''),
								input.pty_typ = '2'=> regexreplace('[\\*|"|.\\\\]', clean_pty_nm, ''), '');
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
	self.dl_num					:= if(input.license_num ='Confidential', '', input.license_num);
	self.dl_state				:= input.LIC_ST_CD;
	self.citizenship			:= '';
	self.dob					:= if(fSlashedMDYtoCYMD(input.dob)[1..4] between '1900' and '1989' and fSlashedMDYtoCYMD(input.dob)[1..8] <> '19010101',
								fSlashedMDYtoCYMD(stringlib.stringfindreplace(input.dob, '-', '/')),'');
	self.dob_alias				:= '';
	self.place_of_birth			:= '';
	self.street_address_1		:= if(input.street = 'Unknown', '',regexreplace('[\\*|"|`|.\\\\]', trim(input.street,left,right), ''));
	self.street_address_2		:= '';
	self.street_address_3		:= trim(regexreplace('[\\*|"|,|.\\\\]', input.city, ''),left, right);
	self.street_address_4		:= if(length(input.state)>2 and regexfind('[A-Za-z]', input.state) or length(input.state) = 2 and stringlib.stringtouppercase(input.state) 
								in ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA','GU','HI','ID','IL','IN','IA','KS','KY','LA','ME','MH','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP','OH','OK','OR','PW','PA','PR','RI','SC','SD','TN','TX','UT','VT','VI','VA','WA','WV','WI','WY','AE','AA','AE','AE','AE','AP'], 
									stringlib.stringtouppercase(trim(stringlib.stringfilterout(regexreplace('[\\*|\\[|\\]|"|`|\\(|/|\\)|,|.\\\\]', trim(input.state,left,right), ''), '0123456789'),left,right)),'');
	self.street_address_5		:= if((length(trim(input.zip,left,right)) = 5 or length(trim(input.zip,left,right)) = 9) and
							     regexfind('[1-9]', input.zip), stringlib.stringfilter(regexreplace('[\\*|"|`|.\\\\]', trim(input.zip,left,right), ''), '0123456789'),'');
	self.race					:= '';
	self.race_desc				:= MAP(trim(input.race,left, right) = 'White\\Caucasian' => 'White',
									trim(input.race,left,right) ='African American' => 'Black',
										trim(input.race,left,right) ='American Indian' => 'Indian',
										trim(input.race,left,right) ='Spanish' => 'Spanish',
										trim(input.race,left,right) ='Japanese' => 'Asian',
										trim(input.race,left,right) ='Undocumented' => '',
											trim(input.race,left, right));
	self.sex					:= if(trim(input.sex,left,right)[1] in ['F','M'],
									trim(input.sex,left,right)[1],
										'');
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

pOHOffender := project(dis, tOHOffend(left));

Crim.Crim_clean(pOHOffender,cleanOHOffend);

fOHOffend := dedup(sort(distribute(cleanOHOffend,hash(offender_key)),
			offender_key,case_number,pty_nm,dob,street_address_1,case_filing_dt,local),
				offender_key,case_number,pty_nm,dob,street_address_1,local,right)
					 :PERSIST('~thor_data400::persist::Crim_OH_Brown_Offender');
export Map_OH_Brown_Offender := fOHOffend;
