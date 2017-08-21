//Source: Alpharetta-Scrape
import Crim_Common, CRIM, Address, lib_stringlib;

ds_def := CRIM.File_TX_Lamar.Defendant;

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
		
integer comma1  		:=  StringLib.StringFind(input.street,',',1);
integer comma2			:=  StringLib.StringFind(input.street,',',2);
integer comma3			:=  StringLib.StringFind(input.street,',',3);	
integer comma4			:=  StringLib.StringFind(input.street,',',4);																															
/*		
varstring street_address_1	:=  IF (comma1 >0 ,input.street[1..comma1-1], '');
varstring street_address_3	:=  IF (comma1 >0 ,IF (comma2 >0 , input.street[comma1+1..comma2 -1], 
									input.street[comma1+1..]), '');
varstring street_address_4  :=  IF (comma2 >0 , IF (comma3 >0 , regexreplace('Texas',input.street, 'Tx')[comma2+1..comma3 -1], 
				                   regexreplace('Texas',input.street, 'Tx')[comma2+1..]),'');
varstring street_address_5  :=  IF (comma3 >0 , IF (comma4 >0 , regexreplace('Texas',input.street, 'Tx')[comma3+1..comma4 -1], 
				                    regexreplace('Texas',input.street, 'Tx')[comma3+1..]),'');
*/	
	clean_def_name				:= stringlib.stringfilter(stringlib.stringtouppercase(input.def_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	self.process_date			:= Crim_Common.Version_Development;
	self.offender_key			:= '3L'+hash(clean_def_name)+input.case_num+fSlashedMDYtoCYMD(input.file_dt);
	self.vendor					:= '3L';
	self.state_origin			:= 'TX';
	self.data_type				:= '2';
	self.source_file			:= '(CP)TX LAMAR Cnty';
	self.case_number			:= input.case_num;
	self.case_court				:= '';
	self.case_name				:= '';
	self.case_type				:= '';
	self.case_type_desc			:= '';
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
	self.id_num					:= '';
	self.dl_num					:= '';
	self.dl_state				:= '';
	self.citizenship			:= '';
	self.dob					:= if(fSlashedMDYtoCYMD(stringlib.stringfindreplace(input.dob, '-', '/')) between '19000101' and Crim_Common.Version_Development,
										fSlashedMDYtoCYMD(stringlib.stringfindreplace(input.dob, '-', '/')),'');
	self.dob_alias				:= '';
	self.place_of_birth			:= '';
	self.street_address_1		:= if(input.city = '' and input.zip = '' and comma1 > 0, trim(input.street[1..comma1 - 1]), trim(input.street));
	self.street_address_2		:= '';
	self.street_address_3		:= if(input.city = '' and input.zip = '' and comma1 > 0, trim(input.street[comma1 + 1.. ]), trim(input.city));
	self.street_address_4		:= trim(input.state); 
	self.street_address_5		:= trim(input.zip);

	/*self.street_address_1		:= if(regexfind('\\*|'+'Unk', input.street) or length(input.street)<4, '',
											if(trim(input.city, all)='' and trim(input.zip)='' and trim(input.state)='' , regexreplace('\\*', input.street,''),
												if(trim(input.street, all)='', trim(regexreplace('\\.', street_address_1, ''), left, right), 
													if(regexfind('\\*|'+'Unk', input.street), '', trim(regexreplace('\\.|'+'\\"|'+',',input.street,''),left,right)))));
	self.street_address_2		:= '';
	self.street_address_3		:=  if(trim(input.city, all)='' and trim(input.zip)='' and trim(input.state)='' , input.city,
										if(trim(input.street, all)='', trim(regexreplace('\\.', street_address_3, ''), left, right), trim(input.city,left,right)));
	self.street_address_4		:= if(trim(input.city, all)='' and trim(input.zip)='' and trim(input.state)='' , input.state,
									if(trim(input.street, all)='', trim(regexreplace('\\.', street_address_4, ''), left, right), 
										if(length(input.state)>2 and regexfind('[A-Za-z]', input.state) or length(input.state) = 2 and stringlib.stringtouppercase(input.state) 
											in ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA','GU','HI','ID','IL','IN','IA','KS','KY','LA','ME','MH','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP','OH','OK','OR','PW','PA','PR','RI','SC','SD','TN','TX','UT','VT','VI','VA','WA','WV','WI','WY','AE','AA','AE','AE','AE','AP'], stringlib.stringtouppercase(trim(input.state,left,right)),''))); 
	self.street_address_5		:= if(trim(input.city, all)='' and trim(input.zip)='' and trim(input.state)='' , input.zip,
									if(trim(input.street, all)='', trim(regexreplace('\\.', street_address_5, ''), left, right), 
										if((length(trim(input.zip,left,right)) = 5 or length(trim(input.zip,left,right)) = 9) and
											regexfind('[1-9]', input.zip), trim(input.zip,left,right),'')));*/
	self.race					:= '';
	self.race_desc				:= if (regexfind('STATE', trim(input.race,left,right)),'',
									MAP(trim(input.race,left, right) = 'Ca' => 'White',
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
										trim(input.race,left,right) ='Un' => '',
										trim(input.race,left,right) ='Or' => '',
										trim(input.race,left,right) ='Ai' => 'Indian',
										trim(input.race,left,right) ='Hi' => 'Hispanic',
										trim(input.race,left,right) ='Bl' => 'Black',
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
				offender_key,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,street_address_1,local),
					offender_key,pty_nm,pty_nm_fmt,pty_typ,dob,street_address_1,local,left)
					 : PERSIST('~thor_data400::persist::Crim_TX_Lamar_Offender');


export Map_TX_Lamar_Offender := fOHOffend;