IMPORT tools,STD, FraudGovPlatform_Validation, ut,_Validate;
EXPORT Build_Input_IdentityData(
	 string pversion
	,dataset(Layouts.Input.mbs) MBS_Sprayed = Files().Input.MBS.sprayed
	,dataset(Layouts.Input.IdentityData) IdentityData_Sprayed =  files().Input.IdentityData.sprayed	
	,dataset(Layouts.Input.IdentityData) ByPassed_IdentityData_Sprayed = files().Input.ByPassed_IdentityData.sprayed
) :=
module

	inIdentityDataUpdate :=	  
		if( nothor(STD.File.GetSuperFileSubCount(Filenames().Sprayed.IdentityData)) > 0, 
				Build_Prepped_IdentityData(pversion),
				dataset([],{string75 fn { virtual(logicalfilename)},FraudGovPlatform.Layouts.Sprayed.IdentityData})
		)   
		+ if (nothor(STD.File.GetSuperFileSubCount(Filenames().Sprayed.NAC)) > 0, 
				Build_Prepped_NAC(pversion).NACIDDTUpdate,
				dataset([],{string75 fn { virtual(logicalfilename)},FraudGovPlatform.Layouts.Sprayed.IdentityData})
		)
		+ if (nothor(STD.File.GetSuperFileSubCount(Filenames().Sprayed.InquiryLogs)) > 0, 
				Build_Prepped_InquiryLogs(pversion),
				dataset([],{string75 fn { virtual(logicalfilename)},FraudGovPlatform.Layouts.Sprayed.IdentityData})
		)		
		+ if (nothor(STD.File.GetSuperFileSubCount(Filenames().Sprayed.RDP)) > 0, 
				Build_Prepped_RDP(pversion),
				dataset([],{string75 fn { virtual(logicalfilename)},FraudGovPlatform.Layouts.Sprayed.IdentityData})		
		);

	Functions.CleanFields(inIdentityDataUpdate ,inIdentityDataUpdateUpper); 

	Layouts.Input.IdentityData tr(inIdentityDataUpdateUpper l, integer cnt) := transform

		filename := ut.CleanSpacesAndUpper(l.fn);
		
		self.FileName := filename;		

		fn := StringLib.SplitWords( StringLib.StringFindReplace(filename, '.dat',''), '_', true );

		self.Customer_Id := StringLib.StringFindReplace(fn[1],'FRAUDGOV::IN::','');
		self.Customer_State := fn[2];
		self.Customer_Agency_Vertical_Type := fn[3];
		self.Customer_Program := fn[4];
		self.Process_Date := (unsigned)pversion;
		self.FileDate := (unsigned)fn[6];
		self.FileTime := fn[7];
		self.ind_type := functions.ind_type_fn(fn[4]);
		self.file_type := 3 ;
		//https://confluence.rsi.lexisnexis.com/display/GTG/Data+Dictionary: 
		self.RIN_Source := L.RIN_Source;			
		self:=l;
		self:=[];
	end;

	shared f1:= project(inIdentityDataUpdateUpper,tr(left, counter));

	max_uid := max(IdentityData_Sprayed, IdentityData_Sprayed.source_rec_id) + 1;

	MAC_Sequence_Records( f1, source_rec_id, f1_source_rec_id, max_uid);

	shared d_source_rec_id := distribute(f1_source_rec_id);
	
	shared customer_mappings := FraudGovPlatform.MBS_Mappings; 

	shared Append_Customer_Mappings := 
		join(d_source_rec_id, customer_mappings,
			left.customer_id = right.contribution_gc_id and right.contribution_source = 'RDP' and left.reason_description = 'APPLICANT ACTIVITY VIA LEXISNEXIS',
			transform(Layouts.Input.IdentityData, SELF.customer_id := if(left.customer_id = right.contribution_gc_id, (string20)right.customer_id, left.customer_id); SELF:=LEFT), LEFT OUTER, lookup);
	
	shared append_source := join( 
		Append_Customer_Mappings,
		MBS_Sprayed(status = 1 and regexfind('DELTA', fdn_file_code, nocase) = false),
		left.Customer_Id =(string)right.gc_id and
		left.customer_State = right.Customer_State and
		left.file_type = right.file_type and //3=transactions
		left.ind_type = right.ind_type, //program
		TRANSFORM(Layouts.Input.IdentityData,SELF.source := RIGHT.fdn_file_code; SELF := LEFT),LEFT OUTER, lookup);

	shared f1_errors:=append_source
		(
			Customer_Job_ID = ''
			or Batch_Record_ID = ''
			or Transaction_ID = ''
			or Reason_Description = ''
			or (_Validate.Date.fIsValid(Date_of_Transaction) = false  or (unsigned)Date_of_Transaction > (unsigned)(STRING8)Std.Date.Today())
			or source = ''
		);

		shared fn_dedup(inputs):=FUNCTIONMACRO
			in_dst := inputs;
			in_srt := sort(in_dst , Customer_Job_ID,Batch_Record_ID,transaction_id,Reason_Description,Date_of_Transaction,Rawlinkid,raw_Full_Name,raw_Title,raw_First_name,raw_Middle_Name,raw_Last_Name,raw_Orig_Suffix,SSN,SSN4,Address_Type,Street_1,Street_2,City,State,Zip,Mailing_Street_1,Mailing_Street_2,Mailing_City,Mailing_State,Mailing_Zip,County,Contact_Type,phone_number,Cell_Phone,dob,Email_Address,Drivers_License_State,Drivers_License,Bank_Routing_Number_1,Bank_Account_Number_1,Bank_Routing_Number_2,Bank_Account_Number_2,Ethnicity,Race,Household_ID,Customer_Person_ID,Head_of_Household_indicator,Relationship_Indicator,IP_Address,Device_ID,Unique_number,MAC_Address,Serial_Number,Device_Type,Device_identification_Provider, geo_lat,geo_long,filename);
			{inputs} RollupUpdate({inputs} l, {inputs} r) := 
			transform
					SELF.source_rec_id := if(l.source_rec_id < r.source_rec_id,l.source_rec_id, r.source_rec_id); // leave always previous Unique_Id 
					self := l;
			end;

			in_ddp := rollup( in_srt
					,RollupUpdate(left, right)
					,Customer_Job_ID,Batch_Record_ID,transaction_id,Reason_Description,Date_of_Transaction,Rawlinkid,raw_Full_Name,raw_Title,raw_First_name,raw_Middle_Name,raw_Last_Name,raw_Orig_Suffix,SSN,SSN4,Address_Type,Street_1,Street_2,City,State,Zip,Mailing_Street_1,Mailing_Street_2,Mailing_City,Mailing_State,Mailing_Zip,County,Contact_Type,phone_number,Cell_Phone,dob,Email_Address,Drivers_License_State,Drivers_License,Bank_Routing_Number_1,Bank_Account_Number_1,Bank_Routing_Number_2,Bank_Account_Number_2,Ethnicity,Race,Household_ID,Customer_Person_ID,Head_of_Household_indicator,Relationship_Indicator,IP_Address,Device_ID,Unique_number,MAC_Address,Serial_Number,Device_Type,Device_identification_Provider, geo_lat,geo_long,filename
					,local
			);
			return in_ddp;
	ENDMACRO;	
	//Exclude Errors
	shared f1_bypass_dedup:= fn_dedup(ByPassed_IdentityData_Sprayed + PROJECT(f1_errors,FraudGovPlatform.Layouts.Input.IdentityData));
	
	tools.mac_WriteFile(
		Filenames().Input.ByPassed_IdentityData.New(pversion),
		f1_bypass_dedup,
		Build_Bypass_IdentityData,
		pCompress := true,
		pHeading := false,
		pOverwrite := true);

	//Move only Valid Records
	shared Valid_Recs :=	join (	
		append_source,
		f1_bypass_dedup,
		LEFT.source_rec_id = RIGHT.source_rec_id,
		TRANSFORM(Layouts.Input.IdentityData,SELF := LEFT),
		LEFT ONLY,
		LOOKUP);	
	
	input_file_1 := fn_dedup(IdentityData_Sprayed  + project(Valid_Recs,Layouts.Input.IdentityData)); 


	tools.mac_WriteFile(
		Filenames(pversion).Input.IdentityData.New(pversion),
		input_file_1,
		Build_IdentityData,
		pCompress := true,
		pHeading := false,
		pOverwrite := true);

// Return
	export build_prepped := 
		sequential(
			 Build_IdentityData
			,Build_Bypass_IdentityData 
		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,build_prepped
		,output('No Valid version parameter passed, skipping Build_Input_IdentityData atribute')
	);

end;


