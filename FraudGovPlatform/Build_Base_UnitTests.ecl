IMPORT _Validate,Std,ut,tools,Data_Services;
EXPORT Build_Base_UnitTests(
	string pversion,
	string pversion_previous = ''
) := 
module


	v := STD.File.GetSuperFileSubName('~fraudgov::base::qa::main', 1);
	qa_version  := (string)STD.Str.SplitWords(v,'::')[3]:independent;

	vVersion_previous := 
		if (pversion_previous = '', 
			qa_version,
			pversion_previous );


	pBaseMainFile := FraudGovPlatform.Files(pversion).Base.Main.New;
	pPreviousMain := FraudGovPlatform.Files(vVersion_previous).Base.Main.New;


	FirstRinID := FraudGovPlatform.Constants().FirstRinID;

	with_pii_1 := pBaseMainFile
		(   did >= FirstRinID 
		and
			(	cleaned_name.fname !='' and cleaned_name.lname !='' and 
				_Validate.Date.fIsValid(clean_dob) and 
				(unsigned)clean_dob <= (unsigned)(STRING8)Std.Date.Today() and	clean_dob != '' and clean_dob != '00000000' and
				(length(STD.Str.CleanSpaces(clean_ssn))=9 and regexfind('^[0-9]*$',STD.Str.CleanSpaces(clean_ssn)) =true ))
		);

	st1 := sort(with_pii_1, cleaned_name.fname, cleaned_name.lname, clean_dob, clean_ssn, did);
	dst1 := dedup(st1, cleaned_name.fname, cleaned_name.lname, clean_dob, clean_ssn, did);
	tdst1 := table(dst1, {cleaned_name.fname, cleaned_name.lname, clean_dob, clean_ssn, did, cnt := count(group)}, cleaned_name.fname, cleaned_name.lname, clean_dob, clean_ssn, did , merge);


	with_pii_2 := pBaseMainFile
		(   did >= FirstRinID 
		and
			(	cleaned_name.fname !='' and 
				cleaned_name.lname !='' and 
				_Validate.Date.fIsValid(clean_dob) and 
				(unsigned)clean_dob <= (unsigned)(STRING8)Std.Date.Today() and	
				clean_dob != '' and clean_dob != '00000000' and 
				clean_address.prim_range != '' 
				and clean_address.prim_name != '' 
				and clean_address.v_city_name != '' 
				and clean_address.st != ''
			)
		);

	st2 := sort(with_pii_2, cleaned_name.fname, cleaned_name.lname, clean_dob, clean_address.prim_range,clean_address.prim_name,clean_address.v_city_name,clean_address.st,  did);
	dst2 := dedup(st2, cleaned_name.fname, cleaned_name.lname, clean_dob, clean_address.prim_range,clean_address.prim_name,clean_address.v_city_name,clean_address.st, did);
	tdst2 := table(dst2, {cleaned_name.fname, cleaned_name.lname, clean_dob, clean_address.prim_range,clean_address.prim_name,clean_address.v_city_name,clean_address.st, did, cnt := count(group)}, cleaned_name.fname, cleaned_name.lname, clean_dob, clean_address.prim_range,clean_address.prim_name,clean_address.v_city_name,clean_address.st, did , merge);


	with_pii_3 := pBaseMainFile
		(   did >= FirstRinID 
		and
			(	cleaned_name.fname !='' and 
				cleaned_name.lname !='' and 
				_Validate.Date.fIsValid(clean_dob) and 
				(unsigned)clean_dob <= (unsigned)(STRING8)Std.Date.Today() and	
				clean_dob != '' and clean_dob != '00000000' and 
				clean_address.prim_range != '' 
				and clean_address.prim_name != ''
				and clean_address.zip != ''
			)				
		);

	st3 := sort(with_pii_3, cleaned_name.fname, cleaned_name.lname, clean_dob, clean_address.prim_range,clean_address.prim_name,clean_address.zip,  did);
	dst3 := dedup(st3, cleaned_name.fname, cleaned_name.lname, clean_dob, clean_address.prim_range,clean_address.prim_name,clean_address.zip, did);
	tdst3 := table(dst3, {cleaned_name.fname, cleaned_name.lname, clean_dob, clean_address.prim_range,clean_address.prim_name,clean_address.zip, did, cnt := count(group)}, cleaned_name.fname, cleaned_name.lname, clean_dob, clean_address.prim_range,clean_address.prim_name,clean_address.zip, did , merge);


	with_pii_4 := pBaseMainFile
		(   did < FirstRinID 
		and
			(	cleaned_name.fname !='' and 
				cleaned_name.lname !='' and 
				(length(STD.Str.CleanSpaces(clean_ssn))=9 and 
				regexfind('^[0-9]*$',STD.Str.CleanSpaces(clean_ssn)) =true ))
		);

	st4 := sort(with_pii_4, cleaned_name.fname, cleaned_name.lname, clean_ssn, did);
	dst4 := dedup(st4, cleaned_name.fname, cleaned_name.lname, clean_ssn, did);
	tdst4 := table(dst4, {cleaned_name.fname, cleaned_name.lname, clean_ssn,did, cnt := count(group)}, 
		cleaned_name.fname, cleaned_name.lname, clean_ssn, did , merge);


	with_pii_5 := pBaseMainFile
		(   did < FirstRinID 
		and
			(	cleaned_name.fname !='' and 
				cleaned_name.lname !='' and 
				_Validate.Date.fIsValid(clean_dob) and 
				(unsigned)clean_dob <= (unsigned)(STRING8)Std.Date.Today() and	
				clean_dob != '' and clean_dob != '00000000' and
				( clean_phones.phone_number <> '' ) 				
			)				
		);		

	st5 := sort(with_pii_5, cleaned_name.fname, cleaned_name.lname, clean_dob,clean_phones.phone_number, did);
	dst5 := dedup(st5, cleaned_name.fname, cleaned_name.lname, clean_dob, clean_phones.phone_number,did);
	tdst5 := table(dst5, {cleaned_name.fname, cleaned_name.lname, clean_dob,clean_phones.phone_number,did, cnt := count(group)}, 
		cleaned_name.fname, cleaned_name.lname, clean_dob,clean_phones.phone_number, did , merge);		

	with_pii_6 := pBaseMainFile
		(   did < FirstRinID 
		and
			(	cleaned_name.fname !='' and 
				cleaned_name.lname !='' and 
				_Validate.Date.fIsValid(clean_dob) and 
				(unsigned)clean_dob <= (unsigned)(STRING8)Std.Date.Today() and	
				clean_dob != '' and clean_dob != '00000000' and
				clean_phones.cell_phone <> '' 		
			)				
		);	

	st6 := sort(with_pii_6, cleaned_name.fname, cleaned_name.lname, clean_dob,clean_phones.cell_phone, did);
	dst6 := dedup(st6, cleaned_name.fname, cleaned_name.lname, clean_dob, clean_phones.cell_phone,did);
	tdst6 := table(dst6, {cleaned_name.fname, cleaned_name.lname, clean_dob,clean_phones.cell_phone,did, cnt := count(group)}, 
		cleaned_name.fname, cleaned_name.lname, clean_dob,clean_phones.cell_phone, did , merge);				


	with_pii_7 := pBaseMainFile
		(   did < FirstRinID 
		and
			(	cleaned_name.fname !='' and 
				cleaned_name.lname !='' and 
				clean_address.prim_range != '' and 
				clean_address.prim_name != '' and 
				clean_address.v_city_name != '' and 
				clean_address.st != ''
			)				
		);		


	st7 := sort(with_pii_7, cleaned_name.fname, cleaned_name.lname, clean_address.prim_range,clean_address.prim_name, clean_address.v_city_name, clean_address.st , did);
	dst7 := dedup(st7, cleaned_name.fname, cleaned_name.lname, clean_address.prim_range,clean_address.prim_name, clean_address.v_city_name, clean_address.st,did);
	tdst7 := table(dst7, {cleaned_name.fname, cleaned_name.lname, clean_address.prim_range,clean_address.prim_name, clean_address.v_city_name, clean_address.st,did, cnt := count(group)}, 
		cleaned_name.fname, cleaned_name.lname, clean_address.prim_range,clean_address.prim_name, clean_address.v_city_name, clean_address.st, did , merge);


	with_pii_8 := pBaseMainFile
		(   did < FirstRinID 
		and
			(	cleaned_name.fname !='' and 
				cleaned_name.lname !='' and 
				clean_address.prim_range != '' and 
				clean_address.prim_name != '' and 
				clean_address.zip != ''
			)				
		);		

	st8 := sort(with_pii_8, cleaned_name.fname, cleaned_name.lname, clean_address.prim_range,clean_address.prim_name, clean_address.zip , did);
	dst8 := dedup(st8, cleaned_name.fname, cleaned_name.lname, clean_address.prim_range,clean_address.prim_name,clean_address.zip,did);
	tdst8 := table(dst8, {cleaned_name.fname, cleaned_name.lname, clean_address.prim_range,clean_address.prim_name,clean_address.zip,did, cnt := count(group)}, 
		cleaned_name.fname, cleaned_name.lname, clean_address.prim_range,clean_address.prim_name,clean_address.zip, did , merge);

	//check that we don't lose DIDs from previous file -  use a 1% treshld for RINIDs

	dPreviousMain := distribute(pPreviousMain, hash32(record_id));
	dBaseMainFile  := distribute(pBaseMainFile, hash32(record_id));

	newRecords := join(dPreviousMain, dBaseMainFile, left.record_id = right.record_id, right only, local);	
	oldRecords := join(dPreviousMain, dBaseMainFile, left.record_id = right.record_id, inner, local);	

	updatedRinIDs := join(dPreviousMain, dBaseMainFile, left.record_id = right.record_id and left.did != right.did and left.did >= FirstRinID, local);	
	
	a := COUNT(dPreviousMain);
	b := COUNT(updatedRinIDs);
	c := (b/a)*100;	

	updatedLexids := join(dPreviousMain, dBaseMainFile, left.record_id = right.record_id and left.did != right.did and left.did > 0 and left.did < FirstRinID, local);	
	e := COUNT(updatedLexids);

	missingRecords 
			:= JOIN(	dPreviousMain, 
						dBaseMainFile,
						ut.CleanSpacesandUpper(left.Customer_ID)= ut.CleanSpacesandUpper(right.Customer_ID) and
						ut.CleanSpacesandUpper(left.Sub_Customer_ID)= ut.CleanSpacesandUpper(right.Sub_Customer_ID) and
						ut.CleanSpacesandUpper(left.Vendor_ID)= ut.CleanSpacesandUpper(right.Vendor_ID) and
						ut.CleanSpacesandUpper(left.offender_key)= ut.CleanSpacesandUpper(right.offender_key) and
						ut.CleanSpacesandUpper(left.Sub_Sub_Customer_ID)= ut.CleanSpacesandUpper(right.Sub_Sub_Customer_ID) and
						ut.CleanSpacesandUpper(left.Customer_Event_ID)= ut.CleanSpacesandUpper(right.Customer_Event_ID) and
						ut.CleanSpacesandUpper(left.Sub_Customer_Event_ID)= ut.CleanSpacesandUpper(right.Sub_Customer_Event_ID) and
						ut.CleanSpacesandUpper(left.Sub_Sub_Customer_Event_ID)= ut.CleanSpacesandUpper(right.Sub_Sub_Customer_Event_ID) and
						ut.CleanSpacesandUpper(left.LN_Product_ID)= ut.CleanSpacesandUpper(right.LN_Product_ID) and
						ut.CleanSpacesandUpper(left.LN_Sub_Product_ID)= ut.CleanSpacesandUpper(right.LN_Sub_Product_ID) and
						ut.CleanSpacesandUpper(left.LN_Sub_Sub_Product_ID)= ut.CleanSpacesandUpper(right.LN_Sub_Sub_Product_ID) and
						ut.CleanSpacesandUpper(left.LN_Product_Key)= ut.CleanSpacesandUpper(right.LN_Product_Key) and
						ut.CleanSpacesandUpper(left.LN_Report_Date)= ut.CleanSpacesandUpper(right.LN_Report_Date) and
						ut.CleanSpacesandUpper(left.LN_Report_Time)= ut.CleanSpacesandUpper(right.LN_Report_Time) and
						ut.CleanSpacesandUpper(left.Reported_Date)= ut.CleanSpacesandUpper(right.Reported_Date) and
						ut.CleanSpacesandUpper(left.Reported_Time)= ut.CleanSpacesandUpper(right.Reported_Time) and
						ut.CleanSpacesandUpper(left.Event_Date)= ut.CleanSpacesandUpper(right.Event_Date) and
						ut.CleanSpacesandUpper(left.Event_End_Date)= ut.CleanSpacesandUpper(right.Event_End_Date) and
						ut.CleanSpacesandUpper(left.Event_Location)= ut.CleanSpacesandUpper(right.Event_Location) and
						ut.CleanSpacesandUpper(left.Event_Type_1)= ut.CleanSpacesandUpper(right.Event_Type_1) and
						ut.CleanSpacesandUpper(left.Event_Type_2)= ut.CleanSpacesandUpper(right.Event_Type_2) and
						ut.CleanSpacesandUpper(left.Event_Type_3)= ut.CleanSpacesandUpper(right.Event_Type_3) and
						ut.CleanSpacesandUpper(left.Household_ID)= ut.CleanSpacesandUpper(right.Household_ID) and
						ut.CleanSpacesandUpper(left.Reason_Description)= ut.CleanSpacesandUpper(right.Reason_Description) and
						ut.CleanSpacesandUpper(left.Investigation_Referral_Case_ID)= ut.CleanSpacesandUpper(right.Investigation_Referral_Case_ID) and
						ut.CleanSpacesandUpper(left.Investigation_Referral_Date_Opened)= ut.CleanSpacesandUpper(right.Investigation_Referral_Date_Opened) and
						ut.CleanSpacesandUpper(left.Investigation_Referral_Date_Closed)= ut.CleanSpacesandUpper(right.Investigation_Referral_Date_Closed) and
						ut.CleanSpacesandUpper(left.Customer_Fraud_Code_1)= ut.CleanSpacesandUpper(right.Customer_Fraud_Code_1) and
						ut.CleanSpacesandUpper(left.Customer_Fraud_Code_2)= ut.CleanSpacesandUpper(right.Customer_Fraud_Code_2) and
						ut.CleanSpacesandUpper(left.Type_of_Referral)= ut.CleanSpacesandUpper(right.Type_of_Referral) and
						ut.CleanSpacesandUpper(left.Referral_Reason)= ut.CleanSpacesandUpper(right.Referral_Reason) and
						ut.CleanSpacesandUpper(left.Disposition)= ut.CleanSpacesandUpper(right.Disposition) and
						ut.CleanSpacesandUpper(left.Mitigated)= ut.CleanSpacesandUpper(right.Mitigated) and
						ut.CleanSpacesandUpper(left.Mitigated_Amount)= ut.CleanSpacesandUpper(right.Mitigated_Amount) and
						ut.CleanSpacesandUpper(left.External_Referral_or_CaseNumber)= ut.CleanSpacesandUpper(right.External_Referral_or_CaseNumber) and
						ut.CleanSpacesandUpper(left.Fraud_Point_Score)= ut.CleanSpacesandUpper(right.Fraud_Point_Score) and
						ut.CleanSpacesandUpper(left.Customer_Person_ID)= ut.CleanSpacesandUpper(right.Customer_Person_ID) and
						ut.CleanSpacesandUpper(left.raw_title)= ut.CleanSpacesandUpper(right.raw_title) and
						ut.CleanSpacesandUpper(left.raw_First_Name)= ut.CleanSpacesandUpper(right.raw_First_Name) and
						ut.CleanSpacesandUpper(left.raw_Middle_Name)= ut.CleanSpacesandUpper(right.raw_Middle_Name) and
						ut.CleanSpacesandUpper(left.raw_Last_Name)= ut.CleanSpacesandUpper(right.raw_Last_Name) and
						ut.CleanSpacesandUpper(left.raw_Orig_Suffix)= ut.CleanSpacesandUpper(right.raw_Orig_Suffix) and
						ut.CleanSpacesandUpper(left.raw_Full_name)= ut.CleanSpacesandUpper(right.raw_Full_name) and
						ut.CleanSpacesandUpper(left.SSN)= ut.CleanSpacesandUpper(right.SSN) and
						ut.CleanSpacesandUpper(left.DOB)= ut.CleanSpacesandUpper(right.DOB) and
						ut.CleanSpacesandUpper(left.Drivers_License)= ut.CleanSpacesandUpper(right.Drivers_License) and
						ut.CleanSpacesandUpper(left.Drivers_License_State)= ut.CleanSpacesandUpper(right.Drivers_License_State) and
						ut.CleanSpacesandUpper(left.Person_Date)= ut.CleanSpacesandUpper(right.Person_Date) and
						ut.CleanSpacesandUpper(left.Name_Type)= ut.CleanSpacesandUpper(right.Name_Type) and
						ut.CleanSpacesandUpper(left.income)= ut.CleanSpacesandUpper(right.income) and
						ut.CleanSpacesandUpper(left.own_or_rent)= ut.CleanSpacesandUpper(right.own_or_rent) and
						left.Rawlinkid =  right.Rawlinkid and
						ut.CleanSpacesandUpper(left.Street_1)= ut.CleanSpacesandUpper(right.Street_1) and
						ut.CleanSpacesandUpper(left.Street_2)= ut.CleanSpacesandUpper(right.Street_2) and
						ut.CleanSpacesandUpper(left.City)= ut.CleanSpacesandUpper(right.City) and
						ut.CleanSpacesandUpper(left.State)= ut.CleanSpacesandUpper(right.State) and
						ut.CleanSpacesandUpper(left.Zip)= ut.CleanSpacesandUpper(right.Zip) and
						ut.CleanSpacesandUpper(left.GPS_coordinates)= ut.CleanSpacesandUpper(right.GPS_coordinates) and
						ut.CleanSpacesandUpper(left.Address_Date)= ut.CleanSpacesandUpper(right.Address_Date) and
						ut.CleanSpacesandUpper(left.Address_Type)= ut.CleanSpacesandUpper(right.Address_Type) and
						left.Appended_Provider_ID = right.Appended_Provider_ID and
						left.lnpid = right.lnpid and
						ut.CleanSpacesandUpper(left.Business_Name)= ut.CleanSpacesandUpper(right.Business_Name) and
						ut.CleanSpacesandUpper(left.TIN)= ut.CleanSpacesandUpper(right.TIN) and
						ut.CleanSpacesandUpper(left.FEIN)= ut.CleanSpacesandUpper(right.FEIN) and
						ut.CleanSpacesandUpper(left.NPI)= ut.CleanSpacesandUpper(right.NPI) and
						ut.CleanSpacesandUpper(left.Business_Type_1)= ut.CleanSpacesandUpper(right.Business_Type_1) and
						ut.CleanSpacesandUpper(left.Business_Type_2)= ut.CleanSpacesandUpper(right.Business_Type_2) and
						ut.CleanSpacesandUpper(left.Business_Date)= ut.CleanSpacesandUpper(right.Business_Date) and
						ut.CleanSpacesandUpper(left.phone_number)= ut.CleanSpacesandUpper(right.phone_number ) and
						ut.CleanSpacesandUpper(left.cell_phone)= ut.CleanSpacesandUpper(right.cell_phone) and
						ut.CleanSpacesandUpper(left.Work_phone)= ut.CleanSpacesandUpper(right.Work_phone ) and
						ut.CleanSpacesandUpper(left.Contact_Type)= ut.CleanSpacesandUpper(right.Contact_Type) and
						ut.CleanSpacesandUpper(left.Contact_Date)= ut.CleanSpacesandUpper(right.Contact_Date) and
						ut.CleanSpacesandUpper(left.Carrier)= ut.CleanSpacesandUpper(right.Carrier) and
						ut.CleanSpacesandUpper(left.Contact_Location)= ut.CleanSpacesandUpper(right.Contact_Location) and
						ut.CleanSpacesandUpper(left.Contact)= ut.CleanSpacesandUpper(right.Contact) and
						ut.CleanSpacesandUpper(left.Call_records)= ut.CleanSpacesandUpper(right.Call_records) and
						ut.CleanSpacesandUpper(left.In_service)= ut.CleanSpacesandUpper(right.In_service) and
						ut.CleanSpacesandUpper(left.Email_Address)= ut.CleanSpacesandUpper(right.Email_Address) and
						ut.CleanSpacesandUpper(left.Email_Address_Type)= ut.CleanSpacesandUpper(right.Email_Address_Type) and
						ut.CleanSpacesandUpper(left.Email_Date)= ut.CleanSpacesandUpper(right.Email_Date) and
						ut.CleanSpacesandUpper(left.Host)= ut.CleanSpacesandUpper(right.Host) and
						ut.CleanSpacesandUpper(left.Alias)= ut.CleanSpacesandUpper(right.Alias) and
						ut.CleanSpacesandUpper(left.Location)= ut.CleanSpacesandUpper(right.Location) and
						ut.CleanSpacesandUpper(left.IP_Address)= ut.CleanSpacesandUpper(right.IP_Address) and
						ut.CleanSpacesandUpper(left.IP_Address_Date)= ut.CleanSpacesandUpper(right.IP_Address_Date) and
						ut.CleanSpacesandUpper(left.Version)= ut.CleanSpacesandUpper(right.Version) and
						ut.CleanSpacesandUpper(left.Class)= ut.CleanSpacesandUpper(right.Class) and
						ut.CleanSpacesandUpper(left.Subnet_mask)= ut.CleanSpacesandUpper(right.Subnet_mask) and
						ut.CleanSpacesandUpper(left.Reserved)= ut.CleanSpacesandUpper(right.Reserved) and
						ut.CleanSpacesandUpper(left.ISP)= ut.CleanSpacesandUpper(right.ISP) and
						ut.CleanSpacesandUpper(left.Device_ID)= ut.CleanSpacesandUpper(right.Device_ID) and
						ut.CleanSpacesandUpper(left.Device_Date)= ut.CleanSpacesandUpper(right.Device_Date) and
						ut.CleanSpacesandUpper(left.Unique_number)= ut.CleanSpacesandUpper(right.Unique_number) and
						ut.CleanSpacesandUpper(left.MAC_Address)= ut.CleanSpacesandUpper(right.MAC_Address) and
						ut.CleanSpacesandUpper(left.Serial_Number)= ut.CleanSpacesandUpper(right.Serial_Number) and
						ut.CleanSpacesandUpper(left.Device_Type )= ut.CleanSpacesandUpper(right.Device_Type ) and
						ut.CleanSpacesandUpper(left.Device_identification_Provider)= ut.CleanSpacesandUpper(right.Device_identification_Provider) and
						ut.CleanSpacesandUpper(left.Transaction_ID)= ut.CleanSpacesandUpper(right.Transaction_ID) and
						ut.CleanSpacesandUpper(left.Transaction_Type)= ut.CleanSpacesandUpper(right.Transaction_Type) and
						ut.CleanSpacesandUpper(left.Amount_of_Loss)= ut.CleanSpacesandUpper(right.Amount_of_Loss) and
						ut.CleanSpacesandUpper(left.Professional_ID)= ut.CleanSpacesandUpper(right.Professional_ID) and
						ut.CleanSpacesandUpper(left.Profession_Type)= ut.CleanSpacesandUpper(right.Profession_Type) and
						ut.CleanSpacesandUpper(left.Corresponding_Professional_IDs)= ut.CleanSpacesandUpper(right.Corresponding_Professional_IDs) and
						ut.CleanSpacesandUpper(left.Licensed_PR_State)= ut.CleanSpacesandUpper(right.Licensed_PR_State) and
						ut.CleanSpacesandUpper(left.vin)= ut.CleanSpacesandUpper(right.vin) and
						ut.CleanSpacesandUpper(left.head_of_household_indicator)= ut.CleanSpacesandUpper(right.head_of_household_indicator) and
						ut.CleanSpacesandUpper(left.relationship_indicator)= ut.CleanSpacesandUpper(right.relationship_indicator) and
						ut.CleanSpacesandUpper(left.county)= ut.CleanSpacesandUpper(right.county) and
						ut.CleanSpacesandUpper(left.additional_address.Street_1)= ut.CleanSpacesandUpper(right.additional_address.Street_1) and
						ut.CleanSpacesandUpper(left.additional_address.Street_2)= ut.CleanSpacesandUpper(right.additional_address.Street_2) and
						ut.CleanSpacesandUpper(left.additional_address.City)= ut.CleanSpacesandUpper(right.additional_address.City) and
						ut.CleanSpacesandUpper(left.additional_address.State)= ut.CleanSpacesandUpper(right.additional_address.State) and
						ut.CleanSpacesandUpper(left.additional_address.Zip)= ut.CleanSpacesandUpper(right.additional_address.Zip) and
						ut.CleanSpacesandUpper(left.additional_address.Address_Type)= ut.CleanSpacesandUpper(right.additional_address.Address_Type) and
						ut.CleanSpacesandUpper(left.Race)= ut.CleanSpacesandUpper(right.Race) and
						ut.CleanSpacesandUpper(left.Ethnicity)= ut.CleanSpacesandUpper(right.Ethnicity) and
						ut.CleanSpacesandUpper(left.bank_routing_number_1)= ut.CleanSpacesandUpper(right.bank_routing_number_1) and
						ut.CleanSpacesandUpper(left.bank_account_number_1)= ut.CleanSpacesandUpper(right.bank_account_number_1) and
						ut.CleanSpacesandUpper(left.bank_routing_number_2)= ut.CleanSpacesandUpper(right.bank_routing_number_2) and
						ut.CleanSpacesandUpper(left.bank_account_number_2)= ut.CleanSpacesandUpper(right.bank_account_number_2) and
						ut.CleanSpacesandUpper(left.reported_by)= ut.CleanSpacesandUpper(right.reported_by) and
						ut.CleanSpacesandUpper(left.name_risk_code)= ut.CleanSpacesandUpper(right.name_risk_code) and
						ut.CleanSpacesandUpper(left.ssn_risk_code)= ut.CleanSpacesandUpper(right.ssn_risk_code) and
						ut.CleanSpacesandUpper(left.dob_risk_code)= ut.CleanSpacesandUpper(right.dob_risk_code) and
						ut.CleanSpacesandUpper(left.drivers_license_risk_code)= ut.CleanSpacesandUpper(right.drivers_license_risk_code) and
						ut.CleanSpacesandUpper(left.physical_address_risk_code)= ut.CleanSpacesandUpper(right.physical_address_risk_code) and
						ut.CleanSpacesandUpper(left.phone_risk_code)= ut.CleanSpacesandUpper(right.phone_risk_code) and
						ut.CleanSpacesandUpper(left.cell_phone_risk_code)= ut.CleanSpacesandUpper(right.cell_phone_risk_code) and
						ut.CleanSpacesandUpper(left.work_phone_risk_code)= ut.CleanSpacesandUpper(right.work_phone_risk_code) and
						ut.CleanSpacesandUpper(left.bank_account_1_risk_code)= ut.CleanSpacesandUpper(right.bank_account_1_risk_code) and
						ut.CleanSpacesandUpper(left.bank_account_2_risk_code)= ut.CleanSpacesandUpper(right.bank_account_2_risk_code) and
						ut.CleanSpacesandUpper(left.email_address_risk_code)= ut.CleanSpacesandUpper(right.email_address_risk_code) and
						ut.CleanSpacesandUpper(left.ip_address_fraud_code)= ut.CleanSpacesandUpper(right.ip_address_fraud_code) and
						ut.CleanSpacesandUpper(left.business_risk_code)= ut.CleanSpacesandUpper(right.business_risk_code) and
						ut.CleanSpacesandUpper(left.mailing_address_risk_code)= ut.CleanSpacesandUpper(right.mailing_address_risk_code) and
						ut.CleanSpacesandUpper(left.device_risk_code)= ut.CleanSpacesandUpper(right.device_risk_code) and
						ut.CleanSpacesandUpper(left.identity_risk_code)= ut.CleanSpacesandUpper(right.identity_risk_code) and
						ut.CleanSpacesandUpper(left.tax_preparer_id)= ut.CleanSpacesandUpper(right.tax_preparer_id) and
						ut.CleanSpacesandUpper(left.start_date)= ut.CleanSpacesandUpper(right.start_date) and
						ut.CleanSpacesandUpper(left.end_date)= ut.CleanSpacesandUpper(right.end_date) and
						ut.CleanSpacesandUpper(left.amount_paid)= ut.CleanSpacesandUpper(right.amount_paid) and
						ut.CleanSpacesandUpper(left.region_code)= ut.CleanSpacesandUpper(right.region_code) and
						ut.CleanSpacesandUpper(left.investigator_id)= ut.CleanSpacesandUpper(right.investigator_id) and 
						ut.CleanSpacesandUpper(left.cleared_fraud)= ut.CleanSpacesandUpper(right.cleared_fraud) and 
						ut.CleanSpacesandUpper(left.reason_cleared_code)= ut.CleanSpacesandUpper(right.reason_cleared_code) and 
						ut.CleanSpacesandUpper(left.geo_lat)= ut.CleanSpacesandUpper(right.geo_lat) and 
						ut.CleanSpacesandUpper(left.geo_long)= ut.CleanSpacesandUpper(right.geo_long) and 
						left.source_rec_id = right.source_rec_id and 
						ut.CleanSpacesandUpper(left.Duration) = ut.CleanSpacesandUpper(right.Duration) and
						ut.CleanSpacesandUpper(left.TransactionStatus) = ut.CleanSpacesandUpper(right.TransactionStatus) and
						ut.CleanSpacesandUpper(left.Reason) = ut.CleanSpacesandUpper(right.Reason),
						LEFT ONLY
						);

	f := COUNT(missingRecords);

	missingRIDs := join(dPreviousMain, dBaseMainFile, left.record_id = right.record_id, left only, local);
	g:=COUNT(missingRIDs);

	duplicateRIDs := table(dBaseMainFile, {record_id; cnt := count(group)}, record_id );
	h:= COUNT(duplicateRIDs(cnt > 1));

	t1 := if(exists(tdst1(cnt > 1)), 'Failed','Passed'); //RinId N_S_D_col
	t2 := if(exists(tdst2(cnt > 1)), 'Failed','Passed'); //RinId N_D_A_C_Z_col
	t3 := if(exists(tdst3(cnt > 1)), 'Failed','Passed'); //RinId N_D_A_Z_col

	t4 := if(exists(tdst4(cnt > 1)), 'Failed','Passed');
	t5 := if(exists(tdst5(cnt > 1)), 'Failed','Passed');
	t6 := if(exists(tdst6(cnt > 1)), 'Failed','Passed');
	t7 := if(exists(tdst7(cnt > 1)), 'Failed','Passed');
	t8 := if(exists(tdst8(cnt > 1)), 'Failed','Passed');

	// missing over 1%
	t9  := if(c > 1, 'Failed','Passed');
	t10 := if(e > 1, 'Failed','Passed');
	t11 := if(f > 1, 'Failed','Passed');
	t12 := if(g > 1, 'Failed','Passed');
	t13 := if(h > 1, 'Failed','Passed');

	myReport := RECORD
		string unittest;
		string result := '';
		string value := '';
	END;

	export base_tests := dataset([
		{'RinId N_S_D_col',t1,COUNT(tdst1(cnt > 1))},
		{'RinId N_D_A_C_Z_col',t2,COUNT(tdst2(cnt > 1))},
		{'RinId N_D_A_Z_col',t3,COUNT(tdst3(cnt > 1))},
		{'Lexid N_S_col',t4,COUNT(tdst4(cnt > 1))},
		{'Lexid N_D_P_col',t5,COUNT(tdst5(cnt > 1))},
		{'Lexid N_D_C_col',t6,COUNT(tdst6(cnt > 1))},
		{'Lexid N_D_A_C_Z_col',t7,COUNT(tdst7(cnt > 1))},
		{'Lexid N_D_A_Z_col',t8,COUNT(tdst8(cnt > 1))},
		{'RINIDs changed (Under 1% Threashold)',t9,b},
		{'LEXIDs changed',t10,e},
		{'Records Lost',t11, f},
		{'RIDs Missing',t12,g},
		{'RIDs Duplicates',t13,h},
		{'Build Incremented',if(count(pBaseMainFile)>count(pPreviousMain),'Passed','Review'),count(pBaseMainFile)-count(pPreviousMain)},
		{'Records Appended',if(count(newRecords)>1,'Passed','Review'),count(newRecords)},
		{'New LEXIDs',if(count(newRecords(did > 0 and did < FirstRinID ))>1,'Passed','Review'),count(newRecords(did > 0 and did < FirstRinID ))},
		{'New RINIDs',if(count(newRecords(did >= FirstRinID ))>1,'Passed','Review'),count(newRecords(did >= FirstRinID ))},
		{'DID = 0',if(count(newRecords(did = 0 ))>1,'Passed','Review'),count(newRecords(did = 0 ))},
		{'Max RINID - Before',if(Max(oldRecords(did >= FirstRinID ),did)>1,'Passed','Review'),Max(oldRecords(did >= FirstRinID ),did)},		
		{'Max RINID - After',if(Max(newRecords(did >= FirstRinID ),did)>1,'Passed','Review'),Max(newRecords(did >= FirstRinID ),did)},
		//{'Min RINID',if(count(newRecords)>1,'Passed','Review'),Min(newRecords(did >= FirstRinID ),did)},
		{'Min Record_ID',if(Min(newRecords,record_id)>1,'Passed','Review'),Min(newRecords,record_id)},
		{'Max Record_ID',if(Max(newRecords,record_id)>1,'Passed','Review'),Max(newRecords,record_id)},
		{'Min Reported Date',if(_Validate.Date.fIsValid(Min(newRecords,reported_date)) and (unsigned)Min(newRecords,reported_date) <= (unsigned)(STRING8)Std.Date.Today(),'Passed','Review'),Min(newRecords,reported_date)},
		{'Max Reported Date',if(_Validate.Date.fIsValid(Max(newRecords,reported_date)) and (unsigned)Min(newRecords,reported_date) <= (unsigned)(STRING8)Std.Date.Today(),'Passed','Review'),Max(newRecords,reported_date)},
		{'Min dt_first_seen',if(_Validate.Date.fIsValid((string)Min(newRecords,dt_first_seen)) and Min(newRecords,dt_first_seen) <= (unsigned)(STRING8)Std.Date.Today(),'Passed','Review'),Min(newRecords,dt_first_seen)},
		{'Max dt_first_seen',if(_Validate.Date.fIsValid((string)Max(newRecords,dt_first_seen)) and Max(newRecords,dt_first_seen) <= (unsigned)(STRING8)Std.Date.Today(),'Passed','Review'),Max(newRecords,dt_first_seen)},		
		{'Min dt_vendor_last_reported',if(_Validate.Date.fIsValid((string)Min(newRecords,dt_vendor_last_reported)) and Min(newRecords,dt_vendor_last_reported) <= (unsigned)(STRING8)Std.Date.Today(),'Passed','Review'),Min(newRecords,dt_vendor_last_reported)},
		{'Max dt_vendor_last_reported',if(_Validate.Date.fIsValid((string)Max(newRecords,dt_vendor_last_reported)) and Max(newRecords,dt_vendor_last_reported) <= (unsigned)(STRING8)Std.Date.Today(),'Passed','Review'),Max(newRecords,dt_vendor_last_reported)},
		{'SSNs Cleaned',if(Count(newRecords(clean_ssn <> ''))>1,'Passed','Review'),Count(newRecords(clean_ssn <> ''))},
		{'DOBs Cleaned',if(Count(newRecords(clean_dob <> ''))>1,'Passed','Review'),Count(newRecords(clean_dob <> ''))},
		{'Names Cleaned',if(Count(newRecords(cleaned_name.fname <> ''))>1,'Passed','Review'),Count(newRecords(cleaned_name.fname <> ''))},
		{'Addresses Cleaned',if(Count(newRecords(clean_address.err_stat[1] = 'S'))>1,'Passed','Review'),Count(newRecords(clean_address.err_stat[1] = 'S'))},
		{'Invalid Addresses',if((DECIMAL5_2)(Count(newRecords(clean_address.err_stat[1] = 'E'))/Count(newRecords))*100 < 30,'Passed','Review'),(string)(Count(newRecords(clean_address.err_stat[1] = 'E'))) + ' (' + (string)(DECIMAL5_2)((Count(newRecords(clean_address.err_stat[1] = 'E'))/Count(newRecords))*100) + '% )'},
		{'Additional Addresses Cleaned',if(Count(newRecords(additional_address.clean_address.err_stat[1] = 'S'))>1,'Passed','Review'),Count(newRecords(additional_address.clean_address.err_stat[1] = 'S'))},
		{'Invalid Additional Addresses',if((DECIMAL5_2)(Count(newRecords(additional_address.clean_address.err_stat[1] = 'E'))/Count(newRecords))*100 < 30,'Passed','Review'),(string)(Count(newRecords(additional_address.clean_address.err_stat[1] = 'E'))) + ' (' + (string)(DECIMAL5_2)((Count(newRecords(additional_address.clean_address.err_stat[1] = 'E'))/Count(newRecords))*100) + '% )'}

		],myreport );

			
	tools.mac_WriteFile($.Filenames(pversion).Base.BaseUnitTests.New,base_tests,Build_Base_Test,pCompress:=true,pHeading:=false,pOverwrite:=true);

	// Return
	export full_build :=
		sequential(
			Build_Base_Test
			, Promote(pversion).buildfiles.New2Built
			, if(EXISTS(base_tests( result  = 'Failed')),FAIL('Unit Test Failed'))

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_KnownFraud atribute')
	);

			
END;