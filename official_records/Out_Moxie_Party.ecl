import Lib_Stringlib;

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

export Out_Moxie_Party := output(dInAsOutDeduped,,Official_Records.Name_Moxie_Party_Dev,__compressed__,overwrite);