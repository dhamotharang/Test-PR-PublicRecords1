//Source: Alpharetta-Scrape
import Crim_Common, CRIM, Address, lib_stringlib, ut;

string8     	fSlashedMDYtoCYMD(string pDateIn) 
				:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
				+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
				+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
				
				
ds_def := crim.File_SC_Richland.Defendant;
ds_alias := crim.File_SC_Richland.Alias;


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
							  Left.def_name <> RIGHT.alias
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
SELF.pty_nm 		:= choose(C, l.Def_Name, l.alias);
SELF.pty_typ 		:= choose(C, '0', '2');
clean_def_name				:= stringlib.stringfilter(stringlib.stringtouppercase(l.def_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
SELF.offender_key 	:= '3Q'+l.case_type[1]+hash(clean_def_name)+l.case_num+fSlashedMDYtoCYMD(l.file_dt);
END;

nDef := NORMALIZE(in, 2 ,NormFile(LEFT,COUNTER));

input	:= nDef(pty_nm <>'');

d := distribute(input, hash32(def_id));

String 		heightToInches(String s) := FUNCTION

	cleanheight 	:= regexreplace('[\\\'|"]', trim(s, all), '');
	height_ft		:=(integer)cleanheight[1..1];
	height_in		:=(integer)cleanheight[2..5];
	return (string)intformat((height_ft*12+height_in), 3, 1);
	
END;

Crim_Common.Layout_In_Court_Offender tOHOffend(d input) := Transform

addrp1(string address1) := stringlib.stringtouppercase(address1[1..25][1.. 25-stringlib.stringfind(StringLib.StringReverse(address1[1..25]), ' ', 1)]);
addrp2(string address1) := stringlib.stringtouppercase(address1[26-stringlib.stringfind(StringLib.StringReverse(address1[1..25]), ' ', 1)..length(trim(address1, left, right))]);
cleanstate(string address1):= if(regexfind(' [A-Z][A-Z] [A-Z][A-Z]$',address1,0)<>'',regexreplace(' [A-Z][A-Z]$',address1,''),'');
								
	self.process_date			:= Crim_Common.Version_Development;
	self.offender_key			:= input.offender_key;
	self.vendor					:= '3Q';
	self.state_origin			:= 'SC';
	self.data_type				:= '2';
	self.source_file			:= '(CP)SC RICHLAND CNTY';
	self.case_number			:= input.case_num;
	self.case_court				:= '';
	self.case_name				:= '';
	self.case_type				:= input.case_type[1];
	self.case_type_desc			:= input.case_type;
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
	self.street_address_1		:= if(regexfind('UNKNOWN',input.street,0)='' and length(trim(input.street,left,right))>=10,
									trim(addrp1(input.street),left,right),
										'');
	self.street_address_2		:= if(regexfind('UNKNOWN',input.street,0)='',
									trim(addrp2(input.street),left,right),//cleanstate(trim(addrp2(input.street),left,right)),
										'');		
	self.street_address_3		:= '';
	self.street_address_4		:= '';
	self.street_address_5		:= '';
	self.race					:= '';
	self.race_desc				:= MAP(trim(input.race,left, right) = 'Unknown' => '',
									trim(input.race,left,right) ='Other' => '',
									trim(input.race,left,right) ='' => '',
										trim(input.race,left,right));
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
	self.weight					:= if(input.weight='Undocumented', '', trim(input.weight, left, right));
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
			offender_key,case_number,pty_nm,dob,street_address_1,case_filing_dt,local),
				offender_key,case_number,pty_nm,dob,street_address_1,local,right)
					 :PERSIST('~thor_data400::persist::Crim_SC_Richland_Offender');

export Map_SC_Richland_Offender := fOHOffend;
