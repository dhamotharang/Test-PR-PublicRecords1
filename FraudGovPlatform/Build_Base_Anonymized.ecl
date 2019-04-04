import FraudShared, Anonymizer, Address,Std,tools;
export Build_Base_Anonymized (
   string pversion,
   dataset(FraudShared.Layouts.Base.Main)  pBaseFile   = FraudShared.Files().Base.Main.Built
) := 
module 

	nodes := thorlib.nodes();	

	CustomerSettings := Files().CustomerSettings;

	empty := dataset([], FraudShared.Layouts.Base.Main);

	Father_Data := if(nothor(STD.File.GetSuperFileSubCount( FraudShared.Filenames().Base.Main.Father )) > 0, FraudShared.Files().Base.Main.Father,empty);
	Demo_Data	:= if(nothor(STD.File.GetSuperFileSubCount( Filenames().Input.DemoData.Sprayed )) > 0, Files().Input.DemoData.Sprayed,empty);

	FatherBaseAndDemo := if(_Flags.UseDemoData, Father_Data + Demo_Data, Father_Data);
	
	anonymize_Records_Never_Anonymized_Before 
		:= join (	distribute(pBaseFile,hash32(record_id)),
					distribute(FatherBaseAndDemo,hash32(record_id)),
					left.record_id = right.record_id,
					transform(FraudShared.Layouts.Base.Main, self := left;),
					left only,
					local);

	anonymize_Only_Anonimized_Sources 
		:= join (	anonymize_Records_Never_Anonymized_Before,
					CustomerSettings(Anonymize_Data = true),
					(unsigned2)left.classification_Permissible_use_access.fdn_file_info_id = (unsigned2)right.fdn_file_info_id, 
					transform(FraudShared.Layouts.Base.Main, self := left;),
					inner,
					LOOKUP);
	
	anonymizePerson :=Anonymizer.mac_AnonymizePerson(anonymize_Only_Anonimized_Sources,raw_first_name,raw_last_name,,,,raw_full_name);
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

	 Fraudshared.Layouts.base.main	TrAddress	(anonymizeAddress2 l) := Transform
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
	
	New_Records_Not_Anonimized 
		:= join(	distribute(pBaseFile,hash32(record_id)),
					anonymize_Only_Anonimized_Sources,
					left.record_id = right.record_id,
					transform(FraudShared.Layouts.Base.Main, self := left;),
					left only,
					local);
										
	Original_Father 
		:= join(	distribute(Father_Data,hash32(record_id)), // Discard Demo Data here, since it will append later and can cause duplicates
					distribute(pBaseFile,hash32(record_id)),
					left.record_id = right.record_id,
					transform(FraudShared.Layouts.Base.Main, self := left;),
					left only,
					local);	
										
	Shared new_base := Original_Father + New_Records_Anonymized + New_Records_Not_Anonimized;

	tools.mac_WriteFile(Filenames(pversion).Base.Main_Anon.New,new_base,Build_Base_File_Anonymized);

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,Build_Base_File_Anonymized
		,output('No Valid version parameter passed, skipping Build_Base_Anonymized atribute')
	);
end;