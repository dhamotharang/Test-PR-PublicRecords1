import Lib_Stringlib, Standard;

Official_Records.Layout_Moxie_Party tPartyInToOut(Official_Records.Layout_In_Party pInput)
 :=
  transform
	self.Master_Party_Type_Cd	:= map(StringLib.StringFind(StringLib.StringToUpperCase(pInput.entity_type_desc), 'GRANTOR'	,1) > 0 => '1',
									   StringLib.StringFind(StringLib.StringToUpperCase(pInput.entity_type_desc), 'DIRECT'	,1) > 0 => '1',
									   StringLib.StringFind(StringLib.StringToUpperCase(pInput.entity_type_desc), 'FROM '	,1) > 0 => '1',
									   StringLib.StringFind(StringLib.StringToUpperCase(pInput.entity_type_desc), 'GRANTEE'	,1) > 0 => '5',
									   StringLib.StringFind(StringLib.StringToUpperCase(pInput.entity_type_desc), 'REVERSE'	,1) > 0 => '5',
									   StringLib.StringFind(StringLib.StringToUpperCase(pInput.entity_type_desc), 'TO '		,1) > 0 => '5',
									   '9');
	self						:= pInput;
  end
 ;

dInAsOut		:= project(Official_Records.File_In_Party,tPartyInToOut(left));
dInAsOutDist	:= distribute(dInAsOut,hash(vendor,state_origin,county_name,official_record_key));
dInAsOutSorted	:= sort(dInAsOutDist,vendor,state_origin,county_name,official_record_key,doc_instrument_or_clerk_filing_num,doc_filed_dt,doc_type_desc,entity_sequence,entity_type_cd,entity_type_desc,entity_nm,entity_nm_format,entity_dob,entity_ssn,title1,fname1,mname1,lname1,suffix1,pname1_score,cname1,title2,fname2,mname2,lname2,suffix2,pname2_score,cname2,title3,fname3,mname3,lname3,suffix3,pname3_score,cname3,title4,fname4,mname4,lname4,suffix4,pname4_score,cname4,title5,fname5,mname5,lname5,suffix5,pname5_score,cname5,process_date,local);
dInAsOutDeduped := dedup(dInAsOutSorted,vendor,state_origin,county_name,official_record_key,doc_instrument_or_clerk_filing_num,doc_filed_dt,doc_type_desc,entity_sequence,entity_type_cd,entity_type_desc,entity_nm,entity_nm_format,entity_dob,entity_ssn,title1,fname1,mname1,lname1,suffix1,pname1_score,cname1,title2,fname2,mname2,lname2,suffix2,pname2_score,cname2,title3,fname3,mname3,lname3,suffix3,pname3_score,cname3,title4,fname4,mname4,lname4,suffix4,pname4_score,cname4,title5,fname5,mname5,lname5,suffix5,pname5_score,cname5,local);

Standard.Official_Records_Party tPartyInToRoxie(dInAsOutDeduped pInput)
 :=
 transform
  self.process_date		:=	(INTEGER) pInput.process_date;
  self.county_name_origin :=	pInput.county_name;
  self.doc_filed_date	:=	(INTEGER) pInput.doc_filed_dt;
  self.entity_type_code	:= pInput.entity_type_cd;
  self.entity_name		:= pInput.entity_nm;
  self.entity_name_format	:= pInput.entity_nm_format;
  self.dob.dob				:= (INTEGER) pInput.entity_dob;
  self.ssn.ssn				:= pInput.entity_ssn;
  self.pname_1.title	:= pInput.title1;
  self.pname_1.fname 	:= pInput.fname1;
  self.pname_1.mname	:= pInput.mname1;
  self.pname_1.lname	:= pInput.lname1;
  self.pname_1.name_suffix := pInput.suffix1;
  self.pname_1.name_score := pInput.pname1_score;
  self.cname_1			:= pInput.cname1;
  self.pname_2.title	:= pInput.title2;
  self.pname_2.fname 	:= pInput.fname2;
  self.pname_2.mname	:= pInput.mname2;
  self.pname_2.lname	:= pInput.lname2;
  self.pname_2.name_suffix := pInput.suffix2;
  self.pname_2.name_score := pInput.pname2_score;
  self.cname_2			:= pInput.cname2;
  self.pname_3.title	:= pInput.title3;
  self.pname_3.fname 	:= pInput.fname3;
  self.pname_3.mname	:= pInput.mname3;
  self.pname_3.lname	:= pInput.lname3;
  self.pname_3.name_suffix := pInput.suffix3;
  self.pname_3.name_score := pInput.pname3_score;
  self.cname_3			:= pInput.cname3;
  self.pname_4.title	:= pInput.title4;
  self.pname_4.fname 	:= pInput.fname4;
  self.pname_4.mname	:= pInput.mname4;
  self.pname_4.lname	:= pInput.lname4;
  self.pname_4.name_suffix := pInput.suffix4;
  self.pname_4.name_score := pInput.pname4_score;
  self.cname_4			:= pInput.cname4;
  self.pname_5.title	:= pInput.title5;
  self.pname_5.fname 	:= pInput.fname5;
  self.pname_5.mname	:= pInput.mname5;
  self.pname_5.lname	:= pInput.lname5;
  self.pname_5.name_suffix := pInput.suffix5;
  self.pname_5.name_score := pInput.pname5_score;
  self.cname_5			:= pInput.cname5;
  self					:= pInput;
 end
 ;
 
dPartyAsRoxie 	:= project(dInAsOutdeduped, tPartyInToRoxie(left));

export Out_Roxie_Party := output(dPartyAsRoxie,,Official_Records.Name_Roxie_Party_Dev,overwrite);
