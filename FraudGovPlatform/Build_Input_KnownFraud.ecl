﻿IMPORT tools,STD, FraudGovPlatform_Validation, FraudShared,ut;
EXPORT Build_Input_KnownFraud(
	 string		pversion
) :=
module

	SHARED fn_dedup(inputs):=FUNCTIONMACRO
		in_srt:=sort(inputs, RECORD, EXCEPT processdate);
		in_ddp:=rollup(in_srt,
								TRANSFORM(Layouts.Input.KnownFraud,SELF := LEFT; SELF := []),
								RECORD,
								EXCEPT ProcessDate,
								LOCAL);	
		return in_ddp;
	ENDMACRO;
	
	Sprayed_KnownFraud := Files(pversion).Sprayed.KnownFraud;

	Layouts.Input.KnownFraud tr(Sprayed_KnownFraud l) := transform
		sub:=stringlib.stringfind(l.fn,'20',1);
		sub2:=stringlib.stringfind(l.fn,'.dat',1)-6;
		FileDate := (unsigned)l.fn[sub..sub+7];
		FileTime := ut.CleanSpacesAndUpper(l.fn[sub2..sub2+5]);
		self.FileName := l.fn;
		self.ProcessDate := (unsigned)pversion;
		self.FileDate := if(FileDate>20130000,FileDate,self.ProcessDate);
		self.FileTime :=FileTime;
		self:=l;
		self:=[];
	end;

	f1:=project(Sprayed_KnownFraud,tr(left));

	f1_errors:=f1
			(	 
						Client_ID												=''
				or		Customer_County 									=''
				or 	(LexID = 0 and Full_Name = '' and (First_name = '' or Last_Name=''))
				or 	(SSN = '' and (Drivers_License_Number='' and Drivers_License_State='') and LexID = 0)
				or 	(Physical_Address_1='' and City=''	and State='' and Zip='')
				or 	(Customer_State 								in FraudGovPlatform_Validation.Mod_Sets.States) 							= FALSE
				or 	(Customer_Agency_Vertical_Type 		in FraudGovPlatform_Validation.Mod_Sets.Agency_Vertical_Type) 		= FALSE
				or 	(Customer_Program 							in FraudGovPlatform_Validation.Mod_Sets.IES_Benefit_Type) 			= FALSE				
			);

	NotInMbs := join(f1,
							FraudShared.Files().Input.MBS.sprayed(status = 1)
										,left.client_id =(string)right.gc_id
										and left.Customer_State = right.customer_state
										and Functions.ind_type_fn(left.Customer_Program) = right.ind_type
										and left.Customer_Agency_Vertical_Type = right.Customer_Vertical,
										// and left.customer_county = right.customer_county
										TRANSFORM(Layouts.Input.KnownFraud,SELF := LEFT),LEFT ONLY);
	//Exclude Errors
	f1_bypass_dedup := fn_dedup(files().Input.ByPassed_KnownFraud.sprayed + (f1_errors + NotInMbs));	
	Build_Bypass_Records :=  OUTPUT(f1_bypass_dedup,,Filenames().Input.ByPassed_KnownFraud.New(pversion),CSV(separator(['~|~']),quote(''),terminator('~<EOL>~')), COMPRESSED);							

	//Move only Valid Records
	f1_dedup := fn_dedup(files().Input.KnownFraud.sprayed + (f1 - f1_errors - NotInMbs));
	Build_Input_File :=  OUTPUT(f1_dedup,,Filenames().Input.KnownFraud.New(pversion),CSV(separator(['~|~']),quote(''),terminator('~<EOL>~')), COMPRESSED);							

	Promote_Input_File := 
		sequential(
			 STD.File.StartSuperFileTransaction()
			 //Promote Input Records
			,STD.File.ClearSuperFile(Filenames().Input.KnownFraud.Used, TRUE)
			,STD.File.AddSuperfile(
				 Filenames().Input.KnownFraud.Sprayed
				,Filenames().Input.KnownFraud.Used
				,addcontents := true
			)
			,STD.File.ClearSuperFile(Filenames().Input.KnownFraud.Sprayed)
			,STD.File.AddSuperfile(
				 Filenames().Input.KnownFraud.Sprayed
				,Filenames().Input.KnownFraud.New(pversion)
			)
			//Promote Bypass Records
			,STD.File.ClearSuperFile(Filenames().Input.ByPassed_KnownFraud.Used, TRUE)
			,STD.File.AddSuperfile(
				 Filenames().Input.ByPassed_KnownFraud.Sprayed
				,Filenames().Input.ByPassed_KnownFraud.Used
				,addcontents := true
			)
			,STD.File.ClearSuperFile(Filenames().Input.ByPassed_KnownFraud.Sprayed)
			,STD.File.AddSuperfile(
				 Filenames().Input.ByPassed_KnownFraud.Sprayed
				,Filenames().Input.ByPassed_KnownFraud.New(pversion)
			)
			//Clear Individual Sprayed Files
			,STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._KnownFraudPassed, TRUE)
			,STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._KnownFraudRejected, TRUE)
			,STD.File.FinishSuperFileTransaction()	
		);
		
// Return
	export build_prepped := 
		if(	STD.File.GetSuperFileSubCount('~thor_data400::in::fraudgov::passed::knownfraud') > 0, 
			 sequential(
				 Build_Input_File
				,Build_Bypass_Records 
				,Promote_Input_File
			)		
		);

		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,build_prepped
		,output('No Valid version parameter passed, skipping Build_Input_KnownFraud atribute')
	);

end;


