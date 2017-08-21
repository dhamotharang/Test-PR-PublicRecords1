//Source: Alpharetta-Scrape
import Crim_Common, CRIM, Address, lib_stringlib, ut;

ds_def := crim.File_LA_EBatonRouge.Defendant(DEF_ID != 'DefendantID');
ds_alias := crim.File_LA_EBatonRouge.Alias(DEF_ID != 'DefendantID');

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
							, LEFT.def_id  = RIGHT.def_id
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
self.offender_key := '3N'+hash(clean_def_name)+l.case_num+fSlashedMDYtoCYMD(l.file_dt);
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

Crim_Common.Layout_In_Court_Offender tLAOffend(d input) := Transform
		
	self.process_date:= Crim_Common.Version_In_Arrest_Offender;
	self.offender_key			:= input.offender_key; //'3N'+hash(trim(input.def_id,left,right)+input.case_num+input.file_dt);
	self.vendor				:= '3N';
	self.state_origin			:= 'LA';
	self.data_type				:= '2';
	self.source_file			:= '(CP)LA EBATONROUGE CRIM CT';
	self.case_number			:= trim(input.case_num,left,right);
	self.case_court			:= '';
	self.case_name				:= '';
	self.case_type				:= trim(input.case_type, left, right)[1..2];
	self.case_type_desc			:= trim(regexreplace('-',input.case_type[3..], ''), left, right);
	self.case_filing_dt			:= if(fSlashedMDYtoCYMD(input.file_dt)[1..2] between '19' and '20',
								fSlashedMDYtoCYMD(input.file_dt),'');
	self.pty_nm				:= map(input.pty_typ = '0' => input.pty_nm, 
								input.pty_typ = '2'=> input.pty_nm, '');
	self.pty_nm_fmt			:= 'L';
	self.orig_lname			:= '';
	self.orig_fname			:= '';    
	self.orig_mname			:= '';
	self.orig_name_suffix		:= '';
	self.pty_typ				:= input.pty_typ;
	self.nitro_flag			:= '';
	self.orig_ssn				:= '';
	self.dle_num				:= '';
	self.fbi_num				:= '';
	self.doc_num				:= '';
	self.ins_num				:= '';
	self.id_num				:= '';
	self.dl_num				:= input.license_num;
	self.dl_state				:= input.LIC_ST_CD;
	self.citizenship			:= '';
	self.dob					:= if(fSlashedMDYtoCYMD(input.dob)[1..4] between '1900' and '1989' and fSlashedMDYtoCYMD(input.dob)[1..8] <> '19010101',
								fSlashedMDYtoCYMD(input.dob),'');
	self.dob_alias				:= '';
	self.place_of_birth			:= '';
	self.street_address_1		:= if(input.street='UNKNOWN', '',trim(input.street,left,right));
	self.street_address_2		:= '';
	self.street_address_3		:= trim(input.city,left,right);
	self.street_address_4		:= if(length(input.state)>2 and regexfind('[A-Za-z]', input.state) or length(input.state) = 2 and stringlib.stringtouppercase(input.state) 
								in ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA','GU','HI','ID','IL','IN','IA','KS','KY','LA','ME','MH','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP','OH','OK','OR','PW','PA','PR','RI','SC','SD','TN','TX','UT','VT','VI','VA','WA','WV','WI','WY','AE','AA','AE','AE','AE','AP'], stringlib.stringtouppercase(trim(input.state,left,right)),''); 
	self.street_address_5		:= if((length(trim(input.zip,left,right)) = 5 or length(trim(input.zip,left,right)) = 9) and
							     regexfind('[1-9]', input.zip), trim(input.zip,left,right),'');
	self.race					:= input.race;
	self.race_desc				:= MAP(trim(input.race,left, right) = 'A' => 'Asian',
									trim(input.race,left,right) ='B' => 'Black',
									trim(input.race,left,right) ='AI' => 'Indian',
									trim(input.race,left,right) ='AP' => 'Asian',
									trim(input.race,left,right) ='H' => 'Hispanic',
									trim(input.race,left,right) ='W' => 'White',
									trim(input.race,left,right) ='O' => 'Other',
											'');
	self.sex					:= if(trim(input.sex,left,right)[1] in ['F','M'],
									trim(input.sex,left,right)[1],
										'');
	self.hair_color			:= input.hair;
	self.hair_color_desc		:= IF(input.hair = 'Undocumented', '', input.hair);
	self.eye_color				:= '';
	self.eye_color_desc			:= IF(input.eye = 'Undocumented', '', input.eye);
	self.skin_color			:= input.skin;
	self.skin_color_desc		:= input.skin;
	self.height				:= if(regexfind('[1-9]', heightToInches(Input.Height)),
									heightToInches(Input.Height), '');
	self.weight				:= if(input.weight='Undocumented', '', trim(input.weight, left, right));
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

pLAOffend := project(d, tLAOffend(left));

Crim.Crim_clean(pLAOffend,cleanLAOffend);

fLAOffend := dedup(sort(distribute(cleanLAOffend,hash(offender_key)),
			offender_key,case_number,pty_nm,dob,case_filing_dt, local),
				offender_key,case_number,pty_nm,dob,case_filing_dt, local,right)
					 :PERSIST('~thor_data400::persist::Crim_LA_EBatonRouge_Offender');


export Map_LA_EBatonRouge_Offender := fLAOffend;
