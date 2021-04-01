import Anonymizer, Address,Std,tools;
export Build_Base_Anonymized (
     string pversion
    ,dataset(FraudGovPlatform.Layouts.Base.Main) pBaseFile   = $.Files().Base.Main_Orig.Built
    ,dataset(FraudGovPlatform.Layouts.Base.Main) Previous_Build = FraudGovPlatform.Files().Base.Main.QA
) := 
module 

	nodes := thorlib.nodes();	
	CustomerSettings := Files().CustomerSettings;

	New_Recs 
		:= join (	distribute(pBaseFile,hash32(record_id)),
					distribute(Previous_Build,hash32(record_id)),
					left.record_id = right.record_id,
					transform(FraudGovPlatform.Layouts.Base.Main, self := left),
					left only,
					local);

	Sources_Anonymized
		:= join (	New_Recs,
					CustomerSettings(Anonymize_Data = true),
					(unsigned2)left.classification_Permissible_use_access.fdn_file_info_id = (unsigned2)right.fdn_file_info_id, 
					transform(FraudGovPlatform.Layouts.Base.Main, self := left;),
					inner,
					LOOKUP);

	anonymizePerson :=Anonymizer.mac_AnonymizePerson(Sources_Anonymized,raw_first_name,raw_last_name,,,,raw_full_name);
	anonymizePerson1 :=Anonymizer.mac_AnonymizePerson(anonymizePerson,,,,ssn,dob,,clean_phones.cell_phone);
	anonymizePerson2 :=Anonymizer.mac_AnonymizePerson(anonymizePerson1,cleaned_name.fname,cleaned_name.lname);
	anonymizePerson3 :=Anonymizer.mac_AnonymizePerson(anonymizePerson2,,,,clean_ssn,clean_dob,,clean_phones.phone_number, Email_Address);
	anonymizePerson4 :=Anonymizer.mac_AnonymizePerson(anonymizePerson3,,,,,,,clean_phones.work_phone);
	anonymizeAddress :=Anonymizer.macAnonymizeAddress(anonymizePerson4,clean_address.prim_range,clean_address.predir,clean_address.prim_name
		,clean_address.addr_suffix,clean_address.postdir,clean_address.unit_desig,clean_address.sec_range,clean_address.p_city_name
		,clean_address.v_city_name,clean_address.st,clean_address.zip,,clean_address.fips_county,clean_address.geo_blk,clean_address.geo_lat,clean_address.geo_long);
	anonymizeAddress2 :=Anonymizer.macAnonymizeAddress(anonymizeAddress,additional_address.clean_address.prim_range,additional_address.clean_address.predir
		,additional_address.clean_address.prim_name,additional_address.clean_address.addr_suffix,additional_address.clean_address.postdir
		,additional_address.clean_address.unit_desig,additional_address.clean_address.sec_range,additional_address.clean_address.p_city_name
		,additional_address.clean_address.v_city_name,additional_address.clean_address.st,additional_address.clean_address.zip,,additional_address.clean_address.fips_county
		,additional_address.clean_address.geo_blk,additional_address.clean_address.geo_lat,additional_address.clean_address.geo_long);	

	 FraudGovPlatform.Layouts.base.main	TrAddress	(anonymizeAddress2 l) := Transform
											CAstreet1 := ut.CleanSpacesAndUpper(trim(l.clean_address.prim_range)+' '+
												trim(l.clean_address.predir) +' '+
												trim(l.clean_address.prim_name)+' '+
												trim(l.clean_address.addr_suffix)+' '+
												trim(l.clean_address.postdir));
											CAstreet2 := ut.CleanSpacesAndUpper(trim(l.clean_address.unit_desig)+' '+
												trim(l.clean_address.sec_range));
											ACAstreet1 := ut.CleanSpacesAndUpper(trim(l.additional_address.clean_address.prim_range)+' '+
												trim(l.additional_address.clean_address.predir) +' '+
												trim(l.additional_address.clean_address.prim_name)+' '+
												trim(l.additional_address.clean_address.addr_suffix)+' '+
												trim(l.additional_address.clean_address.postdir));
											ACAstreet2 := ut.CleanSpacesAndUpper(trim(l.additional_address.clean_address.unit_desig)+' '+
												trim(l.additional_address.clean_address.sec_range));
											self.street_1 := CAstreet1;
											self.street_2 := CAstreet2;
											self.city := l.clean_address.p_city_name;
											self.state := l.clean_address.st;
											self.zip := l.clean_address.zip;
											self.clean_zip := l.clean_address.zip;
											self.address_1 := CAstreet1 +' '+CAstreet2;
											self.address_2 := if(l.clean_address.p_city_name<>'',trim(l.clean_address.p_city_name)+ ', ','')+
												trim(l.clean_address.st) +' '+trim(l.clean_address.zip);
											self.additional_address.street_1 := ACAstreet1;
											self.additional_address.street_2 := ACAstreet2;
											self.additional_address.city := l.additional_address.clean_address.p_city_name;
											self.additional_address.state := l.additional_address.clean_address.st;
											self.additional_address.zip := l.additional_address.clean_address.zip;
											self.additional_address.address_1 := ACAstreet1 +' '+ACAstreet2;
											self.additional_address.address_2 := if(l.additional_address.clean_address.p_city_name<>'',
												trim(l.additional_address.clean_address.p_city_name)+', ','')+
												trim(l.clean_address.st) +' '+trim(l.clean_address.zip);
											self.phone_number	:= l.clean_phones.phone_number;
											self.cell_phone	:= l.clean_phones.cell_phone;
											self.work_phone	:= l.clean_phones.work_phone;
											self:=l ;
											end;

	New_Records_Anonymized	:= Project(anonymizeAddress2,TrAddress(left), local);

	New_Records_Not_Anonymized 
		:= join(	New_Recs,
					Sources_Anonymized,
					left.record_id = right.record_id,
					transform(FraudGovPlatform.Layouts.Base.Main, self := left;),
					left only,
					local);

	Old_Recs
		:= join (	distribute(pBaseFile,hash32(record_id)),
					distribute(Previous_Build,hash32(record_id)),
					left.record_id = right.record_id,
					transform(FraudGovPlatform.Layouts.Base.Main,self.did:=left.did,self.did_score:=left.did_score, self := right),
					inner,
					local);

	//Add demo data GRP-5144, 5276
	Demo_main := FraudGovPlatform.fn_demodata_refresh(pVersion);
	
	MergeRecs := FraudGovPlatform.fn_dedup_main( Old_Recs + New_Records_Anonymized + New_Records_Not_Anonymized + Demo_main );

	tools.mac_WriteFile(FraudGovPlatform.Filenames(pversion).Base.Main.New,MergeRecs,Build_Base_File_Anonymized);

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
				Build_Base_File_Anonymized,
				FraudGovPlatform.Promote(pversion).buildfiles.New2Built)
		,output('No Valid version parameter passed, skipping Build_Base_Anonymized atribute')
	);
end;