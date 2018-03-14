IMPORT tools,STD, FraudGovPlatform_Validation, FraudShared,ut;
EXPORT Build_Input_KnownFraud(
	  string		pversion
	 ,boolean		PSkipKnownFraud	= false 
	 ,boolean		PSkipNAC				= false	 
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
	
	inKnownFraudUpdate := 	if	(nothor(STD.File.GetSuperFileSubCount('~thor_data400::in::fraudgov::passed::KnownFraud')) > 0 and PSkipKnownFraud = false, 
													Files(pversion).Sprayed.KnownFraud, 
													dataset([],{string75 fn { virtual(logicalfilename)},		FraudGovPlatform.Layouts.Sprayed.KnownFraud})
										)    											
									+ 	if	(nothor(STD.File.GetSuperFileSubCount('~thor_data400::in::fraudgov::passed::nac')) > 0 and PSkipNAC = false, 
													Build_Prepped_NAC(pversion).NACKNFDUpdate,
													dataset([],{string75 fn { virtual(logicalfilename)}, 	FraudGovPlatform.Layouts.Sprayed.KnownFraud})
										);
	
	Functions.CleanFields(inKnownFraudUpdate ,inKnownFraudUpdateUpper); 
	
	knfd := record
		FraudGovPlatform.Layouts.Input.knownfraud;
		INTEGER sequence;			
	end;	

	knfd tr(inKnownFraudUpdateUpper l, INTEGER C) := transform
		sub:=stringlib.stringfind(l.fn,'20',1);
		sub2:=stringlib.stringfind(l.fn,'.dat',1)-6;
		FileDate := (unsigned)l.fn[sub..sub+7];
		FileTime := ut.CleanSpacesAndUpper(l.fn[sub2..sub2+5]);
		self.FileName := l.fn;
		self.ProcessDate := (unsigned)pversion;
		self.FileDate := if(FileDate>20130000,FileDate,self.ProcessDate);
		self.FileTime :=FileTime;
		self.address_1 := tools.AID_Helpers.fRawFixLine1( trim(l.Street_1) + ' ' +  trim(l.Street_2));
		self.address_2 := tools.AID_Helpers.fRawFixLineLast( stringlib.stringtouppercase(trim(l.city) + if(l.state != '', ', ', '') + trim(l.state)  + ' ' + trim(l.zip)[1..5]));  
		self.mailing_address_1 := tools.AID_Helpers.fRawFixLine1( trim(l.Mailing_Street_1) + ' ' + trim(l.Mailing_Street_2));;
		self.mailing_address_2 := tools.AID_Helpers.fRawFixLineLast(  stringlib.stringtouppercase(trim(l.Mailing_City) + if(l.Mailing_State != '', ', ', '') + trim(l.Mailing_State)  + ' ' + trim(l.Mailing_Zip)[1..5]));
		self.raw_full_name := if(l.raw_full_name='', ut.CleanSpacesAndUpper(l.raw_first_name + ' ' + l.raw_middle_name + ' ' + l.raw_last_name), l.raw_full_name);
		self.source_input := if (l.source_input = '', 'Contributory',l.source_input);
		self.sequence := C;
		self:=l;
		self:=[];
	end;

	f1:=project(inKnownFraudUpdateUpper, tr(left,counter));
	

	f1_errors:=f1
			(	 
						Customer_Account_Number						=''
				or		Customer_County 									=''
				or 	(LexID = 0 and raw_Full_Name = '' and (raw_First_name = '' or raw_Last_Name=''))
				or 	(SSN = '' and (Drivers_License_Number='' and Drivers_License_State='') and LexID = 0)
				or 	(Street_1='' and City=''	and State='' and Zip='')
				or 	(Customer_State 								in FraudGovPlatform_Validation.Mod_Sets.States) 							= FALSE
				or 	(Customer_Agency_Vertical_Type 		in FraudGovPlatform_Validation.Mod_Sets.Agency_Vertical_Type) 		= FALSE
				or 	(Customer_Program 							in FraudGovPlatform_Validation.Mod_Sets.IES_Benefit_Type) 			= FALSE				
			);

	NotInMbs := join(f1,
							FraudShared.Files().Input.MBS.sprayed(status = 1)
										,left.Customer_Account_Number =(string)right.gc_id
										and left.Customer_State = right.customer_state
										and Functions.ind_type_fn(left.Customer_Program) = right.ind_type
										and left.Customer_Agency_Vertical_Type = right.Customer_Vertical
										and left.Customer_County = right.Customer_County,
										TRANSFORM(knfd,SELF := LEFT),LEFT ONLY,lookup);
	//Exclude Errors
	ByPassed_records := f1_errors + NotInMbs;
	f1_bypass_dedup := files().Input.ByPassed_KnownFraud.sprayed + project(ByPassed_records, FraudGovPlatform.Layouts.Input.knownfraud);
	Build_Bypass_Records :=  OUTPUT(f1_bypass_dedup,,Filenames().Input.ByPassed_KnownFraud.New(pversion),CSV(separator(['~|~']),quote(''),terminator('~<EOL>~')), COMPRESSED);							

	//Move only Valid Records
	f1_dedup					:=	 join (f1,
																							ByPassed_records,
																							left.sequence = right.sequence,
																							TRANSFORM(knfd,SELF := LEFT),
																							left only);	
	dAppendAID     := Standardize_Entity.Clean_Address(f1_dedup, pversion);// : persist(Persistnames.AppendAID);
	dappendName		:= Standardize_Entity.Clean_Name(dAppendAID);	
	dAppendPhone   := Standardize_Entity.Clean_Phone (dappendName);
	dAppendLexid   := Standardize_Entity.Append_Lexid (dAppendPhone);	
	
	new_file := fn_dedup(files().Input.KnownFraud.sprayed  + project(dAppendLexid,Layouts.Input.KnownFraud));
	
	Build_Input_File :=  OUTPUT(new_file,,Filenames().Input.KnownFraud.New(pversion),CSV(separator(['~|~']),quote(''),terminator('~<EOL>~')), COMPRESSED);							

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
			//,STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._KnownFraudPassed, TRUE)
			//,STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._KnownFraudRejected, TRUE)
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


