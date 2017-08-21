import Crim_Common, CRIM, Address, lib_stringlib;
Input_RawFile_Merchant := File_FL_Alachua_Merchant;

Layout_In_Court_Offender_temp := record
  Crim_Common.Layout_In_Court_Offender;
	string Alias1;
	string Alias2;
	string Alias3;
	string aliasdob1;
	string aliasdob2;
	string aliasdob3;
	
end;

dInput_RawFile_Merchant:= distribute(Input_RawFile_Merchant(trim(name) not in FILTER_CONDITIONS), hash(casenumber));
//After combining the data from 2001 to 2010, saw tons of dups
dsInput_RawFile_Merchant := sort(dInput_RawFile_Merchant,DateofArrest,CaseNumber,Name,Alias1,Alias2,Alias3,Addressline1,Addressline2,AddressCity,AddressState,AddressZipCode,
SSN,DOB,DriverLicenseState,DriverLicense,Race,Sex,Height,Weight,HairColor,EyeColor,CourtType,local);
//output(count(dsInput_RawFile_Merchant));
Input_RawFile_Merchant_dedup := dedup(dsInput_RawFile_Merchant,DateofArrest,CaseNumber,Name,Alias1,Alias2,Alias3,Addressline1,Addressline2,AddressCity,AddressState,AddressZipCode,
SSN,DOB,DriverLicenseState,DriverLicense,Race,Sex,Height,Weight,HairColor,EyeColor,CourtType,RIGHT,local);

Layout_In_Court_Offender_temp Map_offender_merchant(Input_RawFile_Merchant_dedup L) := Transform
	
             
	self.process_date     := Crim_Common.Version_In_Arrest_Offender;
	self.offender_key			:= Function_Offender_Key_Generator('3UM',L.casenumber,L.dateofarrest);
	self.vendor				    := '3U'; 
	self.state_origin			:= 'FL';
	self.data_type				:= '2';
	self.source_file			:= 'FL_ALACHUA_MERCH_CRM';
	self.case_number			:= trim(L.casenumber);
	self.case_court			  := MAP(L.courttype = 'C' => 'County Court',
	                             L.courttype = 'R' => 'Circuit Court',
															 '');
	self.case_name				:= '';
	self.case_type				:= '';
	self.case_type_desc		:= '';
	
	string v_case_dt      := '';
	self.case_filing_dt		:= '';
	self.pty_nm				    := trim(L.name);
	self.pty_nm_fmt			  := 'L';
	self.orig_lname			  := '';
	self.orig_fname			  := '';    
	self.orig_mname			  := '';
	self.orig_name_suffix	:= '';
	self.pty_typ				  := '0';
	self.nitro_flag			  := '';
	string ssn            := MAP(L.ssn ='000000000' =>'',
	                             L.ssn ='888888888' =>'',
															 L.ssn ='999999999' =>'',
															 length(L.ssn) <9   =>'',L.ssn);
  string extract_ssn    := MAP( regexfind('SSN*[ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+|SS#*[ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+',L.alias1,0) <> '' =>regexfind('SSN*[ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+|SS#*[ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+',L.alias1,0),
	                              regexfind('SSN*[ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+|SS#*[ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+',L.alias2,0) <> '' =>regexfind('SSN*[ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+|SS#*[ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+',L.alias2,0),
																regexfind('SSN*[ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+|SS#*[ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+',L.alias3,0) <> '' =>regexfind('SSN*[ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+|SS#*[ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+',L.alias3,0),
																'');
	self.orig_ssn				  := MAP(ssn <>'' => ssn,
	                             length(trim(stringlib.stringfindreplace(stringlib.stringfindreplace(stringlib.stringfindreplace(
															        extract_ssn,'SSN',''),'SS#',''),'-',''),LEFT,RIGHT))= 9 =>trim(stringlib.stringfindreplace(stringlib.stringfindreplace(stringlib.stringfindreplace(
															        extract_ssn,'SSN',''),'SS#',''),'-',''),LEFT,RIGHT),
																			'');
	self.dle_num				  := '';
	self.fbi_num				  := '';
	self.doc_num				  := '';
	self.ins_num				  := '';
	self.id_num				    := '';
  self.dl_num           := trim(L.driverlicense);
	self.dl_state				  := trim(L.driverlicensestate);
	self.citizenship		  := '';
	string dob            := IF(Function_ParseDate(TRIM(L.DOB,right),'MMDDYYYY') >= '19000101'  and 
	                            ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)Function_ParseDate(TRIM(L.DOB,right),'MMDDYYYY')[1..4])>=18,
									            Function_ParseDate(TRIM(L.DOB,right),'MMDDYYYY'),'');
	self.dob					     := dob;
  string alias_dob1      := trim(stringlib.stringfindreplace(stringlib.stringfindreplace(regexfind('DOB[:]*[ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+',L.alias1,0),'DOB',''),':',''),left,right);
	
	string clean_alias_dob1:= MAP(length(regexfind('(/[0-9]+$)',alias_dob1,0)) = 3 => Function_ParseDate(alias_dob1,'MM/DD/YYDOB'),
	                              length(regexfind('(/[0-9]+$)',alias_dob1,0)) = 5 => Function_ParseDate(alias_dob1,'MM/DD/YYYY'),
	                              length(regexfind('(-[0-9]+$)',alias_dob1,0)) = 3 => Function_ParseDate(alias_dob1,'MM-DD-YYDOB'),
																length(regexfind('(-[0-9]+$)',alias_dob1,0)) = 5 => Function_ParseDate(alias_dob1,'MM-DD-YYYY'),
																regexfind('(-|/)',alias_dob1,0)= '' and length(alias_dob1) = 8 => Function_ParseDate(alias_dob1,'MMDDYYYY'),
																regexfind('(-|/)',alias_dob1,0)= '' and length(alias_dob1) = 6 => Function_ParseDate(alias_dob1,'MMDDYYDOB'),
																'');
	string alias_dob2      := trim(stringlib.stringfindreplace(stringlib.stringfindreplace(regexfind('DOB[:]*[ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+',L.alias2,0),'DOB',''),':',''),left,right);
	string clean_alias_dob2:= MAP(length(regexfind('(/[0-9]+$)',alias_dob2,0)) = 3 => Function_ParseDate(alias_dob2,'MM/DD/YYDOB'),
	                              length(regexfind('(/[0-9]+$)',alias_dob2,0)) = 5 => Function_ParseDate(alias_dob2,'MM/DD/YYYY'),
	                              length(regexfind('(-[0-9]+$)',alias_dob2,0)) = 3 => Function_ParseDate(alias_dob2,'MM-DD-YYDOB'),
																length(regexfind('(-[0-9]+$)',alias_dob2,0)) = 5 => Function_ParseDate(alias_dob2,'MM-DD-YYYY'),
																regexfind('(-|/)',alias_dob2,0)= '' and length(alias_dob2) = 8 => Function_ParseDate(alias_dob2,'MMDDYYYY'),
																regexfind('(-|/)',alias_dob2,0)= '' and length(alias_dob2) = 6 => Function_ParseDate(alias_dob2,'MMDDYYDOB'),
																'');
	string alias_dob3      := trim(stringlib.stringfindreplace(stringlib.stringfindreplace(regexfind('DOB[:]*[ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+',L.alias3,0),'DOB',''),':',''),left,right);
	
	string clean_alias_dob3:= MAP(length(regexfind('(/[0-9]+$)',alias_dob3,0)) = 3 => Function_ParseDate(alias_dob3,'MM/DD/YYDOB'),
	                              length(regexfind('(/[0-9]+$)',alias_dob3,0)) = 5 => Function_ParseDate(alias_dob3,'MM/DD/YYYY'),
	                              length(regexfind('(-[0-9]+$)',alias_dob3,0)) = 3 => Function_ParseDate(alias_dob3,'MM-DD-YYDOB'),
																length(regexfind('(-[0-9]+$)',alias_dob3,0)) = 5 => Function_ParseDate(alias_dob3,'MM-DD-YYYY'),
																regexfind('(-|/)',alias_dob3,0)= '' and length(alias_dob3) = 8 => Function_ParseDate(alias_dob3,'MMDDYYYY'),
																regexfind('(-|/)',alias_dob3,0)= '' and length(alias_dob3) = 6 => Function_ParseDate(alias_dob3,'MMDDYYDOB'),
																'');															

															
	self.place_of_birth	  := '';

	self.street_address_1	:= TRIM(L.addressline1);
	self.street_address_2	:= TRIM(L.addressline2);
	self.street_address_3	:= TRIM(L.addresscity);
  self.street_address_4	:= TRIM(L.addressstate); 
  self.street_address_5	:= TRIM(L.addresszipcode);
	self.race					    := trim(L.sex); //Field is not populated after 2003.Prior to that sex is populated in race field and visa versa 
	self.race_desc		    := MAP (trim(L.sex) ='W' =>	'White (includes Mexicans)',
                                trim(L.sex) ='B' =>	'Black',
                                trim(L.sex) ='O' =>	'Oriental/Asian',
                                trim(L.sex) ='I' =>	'American Indian or Alaskan Native',
                                trim(L.sex) ='N' =>	'Business',
																'');
	self.sex					    := MAP(trim(L.race,all)[1..1] ='M' => 'M',
	                             trim(L.race,all)[1..1] ='F' => 'F', 
															 '');	 //Field is not populated after 2003. 
															 
  string height         := stringlib.stringfindreplace(stringlib.stringfindreplace(stringlib.stringfindreplace(	trim(L.height), '"','0'),'\'','0'),' ','0');
	
  string height2        := MAP((integer)trim(height) = 0 =>'',
	                             length(trim(stringlib.stringfilterout(height,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))) < 3 => '',
															 (integer)trim(height)[2..3] >12 =>'',
	                             trim(height));//Field is not populated after 2003	
  self.height						:= IF(height2 <> '',(string)((integer)height2[1..1]*12+	(integer)height2[2..3]),'');							 
	self.weight           := MAP((integer)trim(L.weight) < 50 =>'',	                                
	                         trim(L.weight));//Field is not populated after 2003
	self.hair_color       := trim(L.haircolor); //Field is not populated after 2003
  self.hair_color_desc  := CASE(L.haircolor, 
	                            'BLD'=>'Bald', 
	                            'BLO'=>'Blonde',
															'BLN'=>'Blonde',
															'BRO'=>'Brown', 
															'BRN'=>'Brown',
															'BLK'=>'Black',
															'RED'=>'Red', 
															'GRY'=>'Gray',
															'');
  self.eye_color        := trim(L.eyeColor); //Field is not populated after 2003
  self.eye_color_desc   := CASE(L.eyeColor,
                              'BRO'=>'Brown',
															'BRN'=>'Brown',
															'BLK'=>'Black',
															'BLU'=>'Blue', 
															'GRN'=>'Green',
															'HAZ'=>'Hazel',
															'');
	self.alias1           := trim(stringlib.stringfindreplace(L.alias1,'DOE, JOHN AKA',''),LEFT,RIGHT);
	self.alias2           := trim(stringlib.stringfindreplace(L.alias2,'DOE, JOHN AKA',''),LEFT,RIGHT);
	self.alias3           := trim(stringlib.stringfindreplace(L.alias3,'DOE, JOHN AKA',''),LEFT,RIGHT);
	
	self.aliasdob1        := IF(clean_alias_dob1 >= '19000101'  and 
	                            ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)clean_alias_dob1[1..4])>=18 and 
															 clean_alias_dob1 <> dob  ,clean_alias_dob1,'');
															 
	self.aliasdob2        := IF(clean_alias_dob2 >= '19000101'  and 
													    ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)clean_alias_dob2[1..4])>=18 and
															 clean_alias_dob2 <> dob  ,clean_alias_dob2,'');
															 
	self.aliasdob3        := IF(clean_alias_dob3 >= '19000101'  and 
	                            ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)clean_alias_dob3[1..4])>=18 and
															 clean_alias_dob3 <> dob ,clean_alias_dob3,'');
															 
  self                  := [];
end;
   


P_FLAM_Offender := PROJECT(Input_RawFile_Merchant_dedup, Map_offender_merchant(left),LOCAL);
//output(P_FLAM_Offender(case_number in ['199914127MMA','200211317MMA']));

crim_common.Layout_In_Court_Offender NormAlias(P_FLAM_Offender L, INTEGER cnt) := TRANSFORM

  //ASSERT( regexreplace('(ADD DOB|DOB|SSN|SS#)*([ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+)',L.Alias1,'') = '' , 'empty alias1');
  string pty_nm					 := MAP(cnt =1 => regexreplace('(AKA[ ]*DOB[:]*|ADD[ ]*DOB[:]*|DOB[:]*|SSN|SS#)*([ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+)',L.pty_nm,''),
	                              
																cnt =2 and 
																regexreplace('(AKA[ ]*DOB[:]*|ADD[ ]*DOB[:]*|DOB[:]*|SSN|SS#)*([ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+)',L.Alias1,'') <> ''=> regexreplace('(AKA[ ]*DOB[:]*|ADD[ ]*DOB[:]*|DOB[:]*|SSN|SS#)*([ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+)',L.Alias1,''),
																
																cnt =2 and 
																L.aliasdob1 <> '' and 
																regexreplace('(AKA[ ]*DOB[:]*|ADD[ ]*DOB[:]*|DOB[:]*|SSN|SS#)*([ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+)',L.Alias1,'') = '' => regexreplace('(AKA[ ]*DOB[:]*|ADD[ ]*DOB[:]*|DOB[:]*|SSN|SS#)*([ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+)',L.pty_nm,''),
																
	                              cnt =3 and
																regexreplace('(AKA[ ]*DOB[:]*|ADD[ ]*DOB[:]*|DOB[:]*|SSN|SS#)*([ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+)',L.Alias2,'') <> ''=> regexreplace('(AKA[ ]*DOB[:]*|ADD[ ]*DOB[:]*|DOB[:]*|SSN|SS#)*([ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+)',L.Alias2,''),
																
																cnt =3 and 
																L.aliasdob2 <> '' and 
																regexreplace('(AKA[ ]*DOB[:]*|ADD[ ]*DOB[:]*|DOB[:]*|SSN|SS#)*([ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+)',L.Alias2,'') = '' => regexreplace('(AKA[ ]*DOB[:]*|ADD[ ]*DOB[:]*|DOB[:]*|SSN|SS#)*([ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+)',L.pty_nm,''),
																
																cnt =4 and 
																regexreplace('(AKA[ ]*DOB[:]*|ADD[ ]*DOB[:]*|DOB[:]*|SSN|SS#)*([ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+)',L.Alias3,'') <> ''=> regexreplace('(AKA[ ]*DOB[:]*|ADD[ ]*DOB[:]*|DOB[:]*|SSN|SS#)*([ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+)',L.Alias3,''),
																
																cnt =4 and 
																L.aliasdob3 <> '' and 
																regexreplace('(AKA[ ]*DOB[:]*|ADD[ ]*DOB[:]*|DOB[:]*|SSN|SS#)*([ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+)',L.Alias3,'') = '' => regexreplace('(AKA[ ]*DOB[:]*|ADD[ ]*DOB[:]*|DOB[:]*|SSN|SS#)*([ ]*[0-9]+[/-]*[0-9]+[/-]*[0-9]+)',L.pty_nm,''),
																'');
																
  SELF.pty_nm			       := IF (trim(pty_nm,left,right) IN ['&',',','AKA','AKA DL #CT','AKA DL H','AKA DOB:','AKA DOB: &','AKA SS#:'],'',trim(pty_nm,left,right));													
																
	self.pty_nm_fmt			   := IF(stringlib.stringfind(pty_nm,',',1)>0,'L','F') ;			
															 
  SELF.pty_typ 					 := IF (cnt =1, L.pty_typ, '2');
	
	self.dob_alias				 := MAP(cnt = 2 => L.aliasdob1,
	                              cnt = 3 => L.aliasdob2,
																cnt = 4 => L.aliasdob3,
																'');
  SELF 									 := L;
	
	
	
END;
Norm_FLAM_Offender := NORMALIZE(P_FLAM_Offender, 4 ,NormAlias(LEFT,COUNTER),local);
//----------------------------------------------------------------------------------------------------------------------------
// NDR code
//----------------------------------------------------------------------------------------------------------------------------
dInput_RawFile_NDR:= distribute(File_FL_Alachua_NDR(not ln_cnf_nmt_max  in [ '5555555','6666666'] or
                                 ln_cnf_nmt_min  in [ '5555555','6666666'] or
													       ln_comm_ctrl    in [ '5555555','6666666'] or
													       ln_dl_supd_rvkd in [ '5555555','6666666'] or
                                 type_cnfnmt = 'J' or 
																 regexfind(sent_provisions,'([0-9]+)',0) <> ''  ), hash(case_num));
																 
Input_RawFile_NDR := DEDUP(SORT(dInput_RawFile_NDR,RECORD,local),RECORD,local);

Crim_Common.Layout_In_Court_Offender Map_offender_ndr(Input_RawFile_NDR L) := Transform
	
             
	self.process_date     := Crim_Common.Version_In_Arrest_Offender;
	self.offender_key			:= Function_Offender_Key_Generator('3VN',trim(L.case_num),L.arrest_dt);
	self.vendor				    := '3V'; 
	self.state_origin			:= 'FL';
	self.data_type				:= '2';
	self.source_file			:= 'FL_ALACHUA_NDR_CRM';
	self.case_number			:= trim(L.case_num);
	self.case_court			  := '';
	self.case_name				:= '';
	self.case_type				:= '';
	self.case_type_desc		:= '';
	
	string v_case_dt      := '';
	self.case_filing_dt		:= '';
	self.pty_nm				    := trim(L.name);
	self.pty_nm_fmt			  := 'L';
	self.orig_lname			  := '';
	self.orig_fname			  := '';    
	self.orig_mname			  := '';
	self.orig_name_suffix	:= '';
	self.pty_typ				  := '0';
	self.nitro_flag			  := '';
	self.orig_ssn				  := '';
	self.dle_num				  := '';
	self.fbi_num				  := '';
	self.doc_num				  := '';
	self.ins_num				  := '';
	self.id_num				    := '';
  self.dl_num           := '';
	self.dl_state				  := '';
	self.citizenship		  := '';
	self.dob					    := IF(Function_ParseDate(TRIM(L.DOB,right),'MMDDYYYY') >= '19000101'  and 
	                            ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)Function_ParseDate(TRIM(L.DOB,right),'MMDDYYYY')[1..4])>=18,
									            Function_ParseDate(TRIM(L.DOB,right),'MMDDYYYY'),'');
	self.dob_alias				:= '';
	self.place_of_birth	  := '';

	self.street_address_1	:= '';
	self.street_address_2	:= '';
	self.street_address_3	:= '';
  self.street_address_4	:= '';
  self.street_address_5	:= '';
	self.race					    := trim(L.race);//Field is not populated
	self.race_desc		    := MAP (trim(L.race) ='W' =>	'White (includes Mexicans)',
                                trim(L.race) ='B' =>	'Black',
                                trim(L.race) ='O' =>	'Oriental/Asian',
                                trim(L.race) ='I' =>	'American Indian or Alaskan Native',
                                trim(L.race) ='N' =>	'Business',
																'');
 
	self.sex					    := MAP(trim(L.sex,all)[1..1] ='M' => 'M',
	                             trim(L.sex,all)[1..1] ='F' => 'F', '');	 //Field is not populated
  self.height           := '';															
	self.weight           := '';
	self.hair_color       := '';
	self.eye_color        := '';

  self                  := [];
end;

P_FLAN_Offender := PROJECT(Input_RawFile_NDR, Map_offender_ndr(left),LOCAL);

SFLAN_Offender     := sort(P_FLAN_Offender,RECORD,local);

Crim_Common.Layout_In_Court_Offender tr(SFLAN_Offender L,SFLAN_Offender R) := TRANSFORM
 SELF := R;
 END;


rFLAN_Offender := ROLLUP(SFLAN_Offender, tr(LEFT, RIGHT), WHOLE RECORD, EXCEPT RACE,RACE_DESC,SEX);


//Crim.Crim_clean(Fil_FLAM_Offender,clean_FLAM_Offender);


//FLAM_Offender_dedup:= dedup(SFLAM_Offender,RECORD,local);

//---------------------------------------------------------------------------------------------------------------------------

Fil_FLAC_Offender  := Norm_FLAM_Offender(pty_nm <> '')+ RFLAN_Offender(pty_nm <> '');


Crim.Crim_clean(Fil_FLAC_Offender,clean_FLAC_Offender);
//output(clean_FLAC_Offender(case_number ='200302741MMA'));
SFLAC_Offender     := sort(clean_FLAC_Offender,offender_key,lname,fname,mname,name_suffix,Case_Number,orig_ssn,DOB,dob_alias,dl_state,dl_num,
                                               Race,Sex,Height,Weight,hair_color,Eye_color,case_court,																							 
                                               prim_range, predir, addr_suffix, postdir, unit_desig, sec_range, zip5,pty_typ);
																					 
																							 
FLAC_Offender_dedup:= dedup(SFLAC_Offender, offender_key,lname,fname,mname,name_suffix,Case_Number,orig_ssn,DOB,dob_alias,dl_state,dl_num,
                                               Race,Sex,Height,Weight,hair_color,Eye_color,case_court,																							 
                                               prim_range, predir, addr_suffix, postdir, unit_desig, sec_range, zip5,LEFT); 




export Map_FL_Alachua_Offender := FLAC_Offender_dedup : persist ('~thor_dell400::persist::Crim_FL_Alachua_Offender');
