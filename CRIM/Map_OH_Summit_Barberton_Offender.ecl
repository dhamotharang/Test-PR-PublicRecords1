

import Crim_Common, Address, lib_stringlib, _validate;

// Datasets needed to map the offender data
ds_offender := CRIM.File_oh_summit_barberton(regexfind('EXPUNGE', StringLib.StringToUpperCase(defendantname), 0)='');

string8     	fSlashedMDYtoCYMD(string pDateIn) 
				:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
				+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
				+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);


String 		heightToInches(String s) := FUNCTION

	cleanheight 	:= regexreplace('[\\\'|"]', trim(s, all), '');
	height_ft		:=(integer)cleanheight[1..1];
	height_in		:=(integer)cleanheight[2..5];
	return (string)intformat((height_ft*12+height_in), 3, 1);
	
END;


Crim_Common.Layout_In_Court_Offender tOHBAOffender(ds_offender input) := Transform

//dob
dob := if(fSlashedMDYtoCYMD(input.DateOfBirth)[1..8] >= '19000101'  
								and ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)fSlashedMDYtoCYMD(input.DateOfBirth)[1..4])>=18,
									fSlashedMDYtoCYMD(trim(input.DateOfBirth,left,right)),'');
//FileDate
FileDate := if(fSlashedMDYtoCYMD(input.FileDate) between '19000101' and Crim_Common.Version_Development, fSlashedMDYtoCYMD(input.FileDate),'');  


	self.process_date				:= Crim_Common.Version_Development;
	self.offender_key				:= '4F' + trim(input.casenum) + FileDate;    
	self.vendor					  	:= '4F';
	self.state_origin				:= 'OH';
	self.data_type					:= '2';
	self.source_file				:= '(CP)OHSummitBarberto';
	self.case_number				:= input.casenum;
	self.case_court					:= '';
	self.case_name					:= '';
	self.case_type					:= '';
	self.case_type_desc			:= '';
	self.case_filing_dt			:= FileDate;
  self.pty_nm				   		:= regexreplace(',', stringlib.stringtouppercase(input.defendantname), ''),
	self.pty_nm_fmt					:= 'L';
	self.orig_lname					:= '';
	self.orig_fname					:= '';    
	self.orig_mname					:= '';
	self.orig_name_suffix		:= '';
	self.pty_typ						:= '0';
	self.nitro_flag					:= '';
	self.orig_ssn						:= regexreplace('-',regexreplace('Confidential',input.socialsecurity, ''),'');     
	self.dle_num						:= '';
	self.fbi_num						:= '';
	self.doc_num						:= '';
	self.ins_num						:= '';
	self.id_num							:= '';
	self.dl_num							:= '';
	self.dl_state						:= '';
	self.citizenship				:= '';
	self.dob								:= dob;
	self.dob_alias					:= '';
	self.place_of_birth			:= '';
	self.street_address_1		:= trim(input.address,left,right);
	self.street_address_2		:= '';
	self.street_address_3		:= input.city;
	self.street_address_4		:= input.state; 
	self.street_address_5		:= input.zip;
	self.race								:= '';
	self.race_desc					:= regexreplace('Undocumented',input.race, '');    
	self.sex								:= case(input.sex,'Male' => 'M', 'Female'=> 'F', ''); // CodesV3
	self.hair_color					:= '';
	self.hair_color_desc		:= regexreplace('Undocumented',input.haircolor, '');
	self.eye_color					:= '';
	self.eye_color_desc			:= regexreplace('Undocumented',input.eyecolor, '');
	self.skin_color					:= '';
	self.skin_color_desc		:= '';
	self.height							:= if((integer)trim(heightToInches(Input.Height), all) between 36 and 96 and length(trim(heightToInches(Input.Height), all))=2,
                                       '0'+trim(heightToInches(Input.Height),all),
                                         if((integer)trim(heightToInches(Input.Height),all) between 36 and 96,
                                            trim(heightToInches(Input.Height),all),''));
	self.weight							:= if(input.weight='Undocumented','', if((integer)trim(input.weight,left,right) between 50 and 500 and length(trim(input.weight,left,right))=2,
                                          '0'+trim(input.weight,left,right),
                                             if((integer)trim(input.weight,left,right) between 50 and 500,
                                               trim(input.weight,left,right),'')));
	self.party_status				:= '';
	self.party_status_desc	:= '';
	self.prim_range 				:= ''; 
	self.predir 						:= '';					   
	self.prim_name 					:= '';
	self.addr_suffix 				:= '';
	self.postdir 						:= '';
	self.unit_desig 				:= '';
	self.sec_range 					:= '';
	self.p_city_name 				:= '';
	self.v_city_name 				:= '';
	self.state 							:= '';
	self.zip5 							:= '';
	self.zip4 							:= '';
	self.cart 							:= '';
	self.cr_sort_sz 				:= '';
	self.lot 								:= '';
	self.lot_order 					:= '';
	self.dpbc 							:= '';
	self.chk_digit 					:= '';
	self.rec_type 					:= '';
	self.ace_fips_st				:= '';
	self.ace_fips_county		:= '';
	self.geo_lat 						:= '';
	self.geo_long 					:= '';
	self.msa 								:= '';
	self.geo_blk 						:= '';
	self.geo_match 					:= '';
	self.err_stat 					:= '';
	self.title 							:= '';
	self.fname 							:= '';
	self.mname 							:= '';
	self.lname 							:= '';
	self.name_suffix 				:= '';
	self.cleaning_score 		:= ''; 

end;


pOHBarbertonOffender := project(ds_offender,tOHBAOffender(left));

Crim.Crim_clean(pOHBarbertonOffender,cleanOHOffend);

ds_TOHBarbertonCrimOffenderOut := dedup(sort(distribute(cleanOHOffend,hash(offender_key)),
										offender_key,case_number,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,-street_address_1,local),
										offender_key,pty_nm,dob,local) : PERSIST('~thor_dell400::persist::Crim_OH_Barberton_Offender_Clean');  

export Map_OH_Summit_Barberton_Offender := ds_TOHBarbertonCrimOffenderOut;