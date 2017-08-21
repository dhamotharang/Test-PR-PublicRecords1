//Source: Alpharetta-Scrape
import Crim_Common, CRIM, Address, lib_stringlib;

ds_def := CRIM.File_TX_Tom_Greene.Defendant;
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


Crim_Common.Layout_In_Court_Offender tTXOffend(d input, unsigned cnt) := Transform
integer Aka  		:=  StringLib.StringFind(input.def_name,' Aka',1);
									
varstring name1		:=  IF (Aka >0,input.def_name[1..Aka], input.def_name);
varstring name2		:=  IF (Aka >0,input.def_name[Aka..], '');

truName				:= trim(name1, left, right);
akaName				:= trim(name2, left, right);

cleanAddress := if (regexfind('\\*|'+'Tran|'+'Unk', input.street), '', input.street);
moreclnAddress := regexreplace('Bad Address|'+'Mail Returned|'+'\\(|\\)', cleanAddress, '');


addrp1(string address1) := stringlib.stringtouppercase(address1[1..25][1.. 25-stringlib.stringfind(StringLib.StringReverse(address1[1..25]), ' ', 1)]);
addrp2(string address1) := stringlib.stringtouppercase(address1[26-stringlib.stringfind(StringLib.StringReverse(address1[1..25]), ' ', 1)..length(trim(address1, left, right))]);
cleanstate(string address1):= if(regexfind(' [A-Z][A-Z] [A-Z][A-Z]$',address1,0)<>'',regexreplace(' [A-Z][A-Z]$',address1,''),'');

//Weight Clean
Cweight := regexreplace('\\.|'+'-', trim(input.weight,all),'');

	clean_def_name				:= stringlib.stringfilter(stringlib.stringtouppercase(input.def_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	self.process_date			:= Crim_Common.Version_Development;
	self.offender_key			:= '4H'+hash(clean_def_name)+input.case_num+fSlashedMDYtoCYMD(input.file_dt);
	self.vendor					:= '4H';
	self.state_origin			:= 'TX';
	self.data_type				:= '2';
	self.source_file			:= '(CP)TX Tom Greene Cnty';
	self.case_number			:= input.case_num;
	self.case_court				:= '';
	self.case_name				:= '';
	self.case_type				:= '';
	self.case_type_desc			:= '';
	self.case_filing_dt			:= if(fSlashedMDYtoCYMD(input.file_dt) between '19000101' and Crim_Common.Version_Development,
								fSlashedMDYtoCYMD(input.file_dt),'');
	self.pty_nm					:= choose(cnt,stringlib.stringtouppercase(truName),
									trim(regexreplace('AKA ',stringlib.stringtouppercase(akaName),''),left,right));
	self.pty_nm_fmt				:= 'L';
	self.orig_lname				:= '';
	self.orig_fname				:= '';    
	self.orig_mname				:= '';
	self.orig_name_suffix		:= '';
	self.pty_typ				:= choose(cnt,'0','2');
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
	self.dob					:= if((fSlashedMDYtoCYMD(input.dob) between '19000101' and Crim_Common.Version_Development) and 
	                         (integer)Crim_Common.Version_Development[1..4] - (integer)fSlashedMDYtoCYMD(input.dob)[1..4] >=18 ,
								           fSlashedMDYtoCYMD(input.dob),'');
	self.dob_alias				:= '';
	self.place_of_birth			:= '';
	self.street_address_1		:= if(regexfind('UNKNOWN',moreclnAddress,0)='' and length(trim(moreclnAddress,left,right))>=10,
									trim(addrp1(moreclnAddress),left,right),
										'');
	self.street_address_2		:= if(regexfind('UNKNOWN',moreclnAddress,0)='',
									trim(addrp2(moreclnAddress),left,right),//cleanstate(trim(addrp2(input.street),left,right)),
										'');	
	self.street_address_3		:= '';
	self.street_address_4		:= '';
	self.street_address_5		:= '';
	self.race					:= '';
	self.race_desc				:= if (regexfind('STATE', trim(input.race,left,right)),'',
								MAP(trim(input.race,left, right) = 'White' => 'White',
								trim(input.race,left,right) ='American' => 'American',
								trim(input.race,left,right) ='Asian' => 'Asian',
								trim(input.race,left,right) ='Black' => 'Black',
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
							        ''));
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

nTXOffend := normalize(d, 2, tTXOffend(left, counter));
outfile := nTXOffend(trim(pty_nm, left, right)<>'');

Crim.Crim_clean(outfile,cleanTXOffend);

fTXOffend := dedup(sort(distribute(cleanTXOffend,hash(offender_key)),
				offender_key,pty_nm,pty_typ,dob,street_address_1,case_filing_dt,local),
					offender_key,pty_nm,pty_typ,dob,street_address_1,local,right)
					: PERSIST('~thor_data400::persist::Crim_TX_Tom_Greene_Offender')
					;
export Map_TX_Tom_Greene_Offender := fTXOffend;


