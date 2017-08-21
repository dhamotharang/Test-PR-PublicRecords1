import Crim_Common, lib_stringlib, Address;
ds_ddcharst := crim.File_CT_DPS.trDDCHARST;
ds_ddchchrg := crim.File_CT_DPS.trDDCHCHRG;

layout_ddchrg_arst := record
		crim.Layout_CT_DPS_DDCHARST;
		crim.Layout_CT_DPS_DDCHCHRG and not [id_spbi, datearst, ts_ddcharst_tybrkr];

END;
layout_ddchrg_arst  jDDChrg_arst(ds_ddcharst L, ds_ddchchrg R) := TRANSFORM
		SELF := L;
		SELF := R;
END;		
		
ds_ddchrg_arst			:=JOIN(ds_ddcharst, ds_ddchchrg
							, LEFT.id_spbi  = RIGHT.id_spbi
							and LEFT.datearst = RIGHT.datearst
							and LEFT.ts_ddcharst_tybrkr = RIGHT.ts_ddcharst_tybrkr
								, jDDChrg_arst(left,right), left outer); 

// output(ds_ddchrg_arst(id_spbi= '000014316'));	

ds_arst := crim.File_CT_DPS.trArrest;;
ds_chrg := crim.File_CT_DPS.trOffense;

layout_chrg_arst := record
		crim.Layout_CT_DPS_Arrest;
		crim.Layout_CT_DPS_Offense and not [id_spbi, id_docket];

END;
layout_chrg_arst  jChrg_arst(ds_arst L, ds_chrg R) := TRANSFORM
		SELF := L;
		SELF := R;
END;		
		
ds_chrg_arst			:=JOIN(ds_arst, ds_chrg
							, LEFT.id_spbi  = RIGHT.id_spbi
							and LEFT.id_docket = RIGHT.id_docket
							, jChrg_arst(left,right), left outer); 
							
// output(ds_chrg_arst(id_spbi= '000014316'));	

input1 := ds_chrg_arst;
input2 := ds_ddchrg_arst;

cmbndArstChrgLayout := record
input1;
	string26	ats_ddcharst_tybrkr;
	string2		dockga;
	string1		dockfac;
	string7		dockseq;
	string1		docksufx;
	//string20	nameacc;
	string15	contrib1;
	string15	contrib2;
	string10	datecort;
	string2		fl_fingerprnt_sup;
	//string10	datechrg;          
	// string15	charge;            
	string20	disp1;             
	string20	disp2; 
end;


cmbndArstChrgLayout t1(input1 L) := transform
self := L;
self := [];
end;

precs1 := project(input1,t1(left));

cmbndArstChrgLayout t2(input2 L) := transform
self := L;
self := [];
end;

precs2 := project(input2,t2(left));

cmbndArstChrgFile := precs1 + precs2;
// output(cmbndArstChrgFile(id_spbi= '000014316'));

ds_cmbnd := cmbndArstChrgFile;

ds_person := crim.File_CT_DPS.trperson;

layout_chrg_arst_person := RECORD
		crim.Layout_CT_DPS_Person.parsed;
		ds_cmbnd;

END;
layout_chrg_arst_person  jChrg_arst_person(ds_person L, ds_cmbnd R) := TRANSFORM
		SELF := L;
		SELF := R;
END;		
		
ds			:=JOIN(ds_person, ds_cmbnd
							, LEFT.pid_spbi  = RIGHT.id_spbi
								, jChrg_arst_person(left,right), left outer); 
// output(choosen(ds(id_spbi='000014316'), 5000));
String 		heightToInches(String s) := FUNCTION

	cleanheight 	:= regexreplace('[\\\'|"]', trim(s, all), '');
	height_ft		:=(integer)cleanheight[1..1];
	height_in		:=(integer)cleanheight[2..5];
	return (string)intformat((height_ft*12+height_in), 3, 1);
	
END;

Crim_Common.Layout_In_Court_Offender tCtOffend(ds input) := Transform
string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
	self.process_date			:= Crim_Common.Version_Development;
	self.offender_key			:= '4A'+input.id_spbi+input.id_docket;	
	self.vendor					:= '4A';
	self.state_origin			:= 'CT';
	self.data_type				:= '2';
	self.source_file			:= '(CP)CT Dept of Pub Sfty';
	self.case_number			:= '';
	self.case_court				:= '';
	self.case_name				:= '';
	self.case_type				:= if(input.fl_felony='Y', input.cd_off_type_orig, '');
	self.case_type_desc			:= '';
	self.case_filing_dt			:= '';
	self.pty_nm					:= regexreplace('[\\*|\\|{|`|"|\\(|\\)|.\\\\]',regexreplace(',', stringlib.stringtouppercase(input.nameacc),', '), '');
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
	self.dl_num					:= '';
	self.dl_state				:= '';
	self.citizenship			:= '';
	self.dob					:= if(trim(input.dt_birth_arrest, all)='@', '',
								if(stringlib.stringfindreplace(input.dt_birth_arrest, '-', '') between '19000101' and Crim_Common.Version_Development,
									stringlib.stringfindreplace(input.dt_birth_arrest, '-', ''),''));
	self.dob_alias				:= '';
	self.place_of_birth			:= if(trim(input.ad_state_fc_birth, all)= '@', '', input.ad_state_fc_birth);
	self.street_address_1		:= if (input.ad_street1 = 'HOMELESS' or 
									input.ad_street1 = 'XOMELESS' or 
									input.ad_street1 = 'UNNOWN' or 
									input.ad_street1 = 'NO ADDRESS' or
									regexfind('UNKN|'+'UNKO|'+'UNKW', input.ad_street1),'', 
									regexreplace('[\\*|"|`|<<|.\\\\]|---|/|XX|XXXXXX|XXXXXXXXXXXX', input.ad_street1,'')); //'[\\*|"|`|<<|.\\\\]|---|/|XX|XXXXXX|XXXXXXXXXXXX'
	self.street_address_2		:= '';
	self.street_address_3		:= if(regexfind('[0-9]',input.ad_city),'', 
									if(length(trim(input.ad_city,left,right))>1, trim(input.ad_city,left,right),''));
	self.street_address_4		:= if(length(input.ad_state)>2 and regexfind('[A-Za-z]', input.ad_state) or length(input.ad_state) = 2 and stringlib.stringtouppercase(input.ad_state) 
									in ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA','GU','HI','ID','IL','IN','IA','KS','KY','LA','ME','MH','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP','OH','OK','OR','PW','PA','PR','RI','SC','SD','TN','TX','UT','VT','VI','VA','WA','WV','WI','WY','AE','AA','AE','AE','AE','AP'], stringlib.stringtouppercase(trim(input.ad_state,left,right)),''); 
	self.street_address_5		:= if((length(trim(input.ad_zip_town,left,right)) = 5 or length(trim(input.ad_zip_town,left,right)) = 9) and
									regexfind('[1-9]', input.ad_zip_town), trim(input.ad_zip_town,left,right),'');
	self.race					:= if(input.cd_race='U', '',input.cd_race);
	self.race_desc				:= if(input.cd_race='U', '',map(input.cd_race = 'W' => 'WHITE',
																input.cd_race = 'B' => 'BLACK',
																input.cd_race = 'I' => 'INDIAN',
																input.cd_race = 'A' => 'ASIAN',''));
	self.sex					:= if(trim(input.cd_sex,left,right)[1] in ['F','M'],
									trim(input.cd_sex,left,right)[1],
										'');
	self.hair_color				:= if(input.cd_hair = 'XXX', '', input.cd_hair);
	self.hair_color_desc		:= map(input.cd_hair = 'BLK' => 'BLACK', 
										input.cd_hair = 'BRO' => 'BROWN', 
										input.cd_hair = 'GRY' => 'GREY', 
										input.cd_hair = 'RED' => 'RED', 
										input.cd_hair = 'BLN' => 'BLN', 
										input.cd_hair = 'SDY' => 'SANDY',
										input.cd_hair = 'WHI' => 'WHITE',
										input.cd_hair = 'XXX' => '',input.cd_hair);
	self.eye_color				:= if(input.cd_eyes = 'XXX', '', input.cd_eyes);
	self.eye_color_desc			:= map(input.cd_eyes = 'GRY'=> 'GREY',  
										input.cd_eyes = 'HAZ'=> 'HAZEL', 
										input.cd_eyes = 'GRN'=> 'GREEN', 
										input.cd_eyes = 'BLK'=> 'BLACK', 
										input.cd_eyes = 'BRO'=> 'BROWN', 
										input.cd_eyes = 'BLU'=> 'BLUE',
										input.cd_eyes = 'MAR'=> 'MAROON',
										input.cd_eyes = 'XXX'=> '', input.cd_eyes);
	self.skin_color				:= '';
	self.skin_color_desc		:= '';
	self.height					:= if((integer)trim(heightToInches(Input.qt_Height), all) between 36 and 96 and length(trim(heightToInches(Input.qt_height), all))=2,
									'0'+trim(heightToInches(Input.qt_height),all),
										if((integer)trim(heightToInches(Input.qt_height),all) between 36 and 96,
											trim(heightToInches(Input.qt_height),all),
												''));
	self.weight					:= if((integer)trim(input.qt_weight,left,right) between 50 and 500 and length(trim(input.qt_weight,left,right))=2,
									'0'+trim(input.qt_weight,left,right),
										if((integer)trim(input.qt_weight,left,right) between 50 and 500,
											trim(input.qt_weight,left,right),
												''));
	self.party_status			:= '';
	self.party_status_desc		:= '';
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

pCTOffend := project(ds, tCTOffend(left));

Crim.Crim_clean(pCtOffend,cleanCTOffend);

fCTOffend := dedup(sort(distribute(cleanCTOffend,hash(offender_key)),
				offender_key,pty_nm,pty_nm_fmt,pty_typ,dob,street_address_1,case_filing_dt,local),
					offender_key,pty_nm,pty_nm_fmt,pty_typ,dob,street_address_1,case_filing_dt,local,right): 
						PERSIST('~thor_data400::persist::Crim_CT_DPS_Offender');

export Map_CT_DPS_Offender := fCTOffend;