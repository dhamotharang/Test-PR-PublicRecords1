//Source: Alpharetta-Scrape
import Crim_Common, CRIM, Address, lib_stringlib;

ds_def := CRIM.File_TX_Grayson.Defendant;

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
	
//Name Clean
integer brace1  		:=  StringLib.StringFind(input.def_name,'(',1);
integer brace2			:=  StringLib.StringFind(input.def_name,')',1);
									
varstring name1		:=  IF (brace1 >0 and brace2>0,input.def_name[brace1..brace2], '');
varstring name2		:=  IF (brace1>0 and brace2=0 ,input.def_name[brace1..], '');

trimName1				:= trim(name1, left, right);
trimName2				:= trim(name2, left, right);
cleanName 				:= if(trimname1<>'', stringlib.stringfindreplace(input.def_name, trimname1, ''), 
							if(trimname2<>'', stringlib.stringfindreplace(input.def_name, trimname2, ''), input.def_name));
integer brace3			:= StringLib.StringFind(cleanname,'(',1);				
varstring Name3			:= IF (brace3>0, cleanname[brace3..], '');	
moreCleanedName			:= if(Name3 <> '', stringlib.stringfindreplace(cleanname, Name3, ''), CleanName);

//Weight Clean

Cweight := regexreplace('\\.|'+'-', trim(input.weight,all),'');

	clean_def_name				:= stringlib.stringfilter(stringlib.stringtouppercase(input.def_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	self.process_date			:= Crim_Common.Version_Development;
	self.offender_key			:= '3K'+hash(clean_def_name)+input.case_num+fSlashedMDYtoCYMD(input.file_dt);
	self.vendor					:= '3K';
	self.state_origin			:= 'TX';
	self.data_type				:= '2';
	self.source_file			:= '(CP)TX Grayson Cnty';
	self.case_number			:= input.case_num;
	self.case_court				:= '';
	self.case_name				:= '';
	self.case_type				:= '';
	self.case_type_desc			:= '';
	self.case_filing_dt			:= if(fSlashedMDYtoCYMD(stringlib.stringfindreplace(input.file_dt, '-', '/')) between '19000101' and Crim_Common.Version_Development,
								fSlashedMDYtoCYMD(stringlib.stringfindreplace(input.file_dt, '-', '/')),'');
	self.pty_nm					:= trim(regexreplace('\\.', moreCleanedName,''), right, left);
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
	self.street_address_3		:= if(regexfind('[a-zA-Z]', input.city), stringlib.stringfilterout(regexreplace('[\\*|\\[|\\]|"|\\(|/|\\)|,|/|`|<|@|>|.\\\\]', trim(input.city,left,right), ''), '0123456789'), '');
	self.street_address_4		:= if(regexfind('[a-zA-Z]', input.state), stringlib.stringfilterout(regexreplace('[\\*|\\[|\\]|"|\\(|/|\\)|,|/|`|<|>|.\\\\]', trim(input.state,left,right), ''), '0123456789'), '');
	self.street_address_5		:= if(regexfind('[1-9]', input.zip), stringlib.stringfilter(regexreplace('[\\*|"|.\\\\]', trim(input.zip,left,right), ''), '0123456789'), '');
	self.race					:= '';
	self.race_desc				:= if (regexfind('STATE', trim(input.race,left,right)),'',
								MAP(trim(input.race,left, right) = 'White\\Caucasian' => 'White',
								trim(input.race,left,right) ='African American' => 'Black',
								trim(input.race,left,right) ='American Indian' => 'Indian',
								trim(input.race,left,right) ='B' => 'Black',
								trim(input.race,left,right) ='C' => 'White',
								trim(input.race,left,right) ='H' => 'Hispanic',
								trim(input.race,left,right) ='M' => 'Hispanic',
								trim(input.race,left,right) ='N' => 'Indian',
								trim(input.race,left,right) ='W' => 'White',
								trim(input.race,left,right) ='S' => 'Hispanic',
								trim(input.race,left,right) ='U' => '',
								trim(input.race,left,right) ='O' => '',
								trim(input.race,left,right) ='2' => '',
								trim(input.race,left,right) ='X' => '',
								trim(input.race,left,right) ='' => '',
							        trim(input.race,left,right)));
	self.sex					:= if(trim(input.sex,left,right)[1] in ['F','M'], trim(input.sex,left,right)[1],'');
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
	self.weight					:= if((integer)Cweight between 50 and 500 and length(trim(input.weight,left,right))=2,'0'+Cweight, 
									if((integer)Cweight between 50 and 500, Cweight,''));
	
	// self.weight					:= IF (input.weight = 'Undocumented', '', regexreplace('\\.|'+'-', trim(input.weight,all), ''));
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
				offender_key,pty_nm,pty_typ,dob,street_address_1,case_filing_dt,local),
					offender_key,pty_nm,pty_typ,dob,street_address_1,local,right)
					: PERSIST('~thor_data400::persist::Crim_TX_Grayson_Offender');


export Map_TX_Grayson_Offender := fOHOffend;