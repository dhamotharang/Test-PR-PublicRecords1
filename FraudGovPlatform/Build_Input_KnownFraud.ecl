IMPORT tools,STD, FraudGovPlatform_Validation;
EXPORT Build_Input_KnownFraud(
	 string		pversion
) :=
module

	SHARED fn_dedup(infile , inputs):=FUNCTIONMACRO
			// rollup by Customer_Name + Customer_Account_Number + Customer_State + 
			//           Customer_Agency_Vertical_Type + Customer_Program + First_name + 
			//           Last_Name + SSN + Date_of_Birth + customer_event_id, 
			// keep most recent filedate 
			
			in_srt:=sort(inputs
						,Customer_Name
						,Customer_Account_Number
						,Customer_State
						,Customer_Agency_Vertical_Type
						,Customer_Program
						,First_name
						,Last_Name
						,SSN
						,DOB
						,customer_event_id
						,-FileDate
						,-FileTime
						,local
						);

			infile tr(in_srt l, in_srt r) :=transform
				self:=l;
			end;

			in_ddp:=rollup(in_srt,tr(left,right)
																				,Customer_Name
																				,Customer_Account_Number
																				,Customer_State
																				,Customer_Agency_Vertical_Type
																				,Customer_Program
																				,First_name
																				,Last_Name
																				,SSN
																				,DOB
																				,customer_event_id
																				,local
																				);

			return in_ddp;
	ENDMACRO;

	SHARED Sprayed_KnownFraud := Files(pversion).Sprayed.KnownFraud;

	
		Layouts.Input.KnownFraud tr(Sprayed_KnownFraud l) := transform
			self.FileName := l.fn;

			sub:=stringlib.stringfind(l.fn,'20',1);
			sub2:=stringlib.stringfind(l.fn,'.dat',1)-6;
			self.ProcessDate := (unsigned)pversion;
			FileDate := (unsigned)l.fn[sub..sub+7];
			FileTime := l.fn[sub2..sub2+5];
			self.FileDate := if(FileDate>20130000,FileDate,self.ProcessDate);
			self.FileTime :=map(
															FileTime in ['0000.a','0000.s','0000.o','0000.n'] =>'999999'
															,FileTime ='5527.a' =>'195527'
															,FileTime ='1911.a' =>'091911'
															,FileTime ='0359.s' =>'140359'
															,FileTime ='2744.s' =>'102744'
															,FileTime ='0033.o' =>'140033'
															,FileTime ='1935.o' =>'111935'
															,FileTime
															);
			self:=l;
			self:=[];
		end;

	f1:=project(Sprayed_KnownFraud,tr(left));

	f1_bypass:=f1
			(	 Customer_Name=''
			or Customer_Account_Number=''
			or Customer_State=''
			or Customer_Agency_Vertical_Type=''
			or Customer_Program=''
			or First_name=''
			or Last_Name=''
			or SSN=''
			or Physical_Address_1=''
			or City=''
			or State=''
			or Zip=''
			or Mailing_Address_1=''
			or Mailing_City=''
			or Mailing_State=''
			or Mailing_Zip=''
			or DOB=''
			);

	f1_bypass_dedup:=fn_dedup(f1_bypass, files().Input.ByPassed_KnownFraud.sprayed + f1_bypass);
	
	Build_Bypass_Records :=  OUTPUT(f1_bypass_dedup,,Filenames().Input.ByPassed_KnownFraud.New(pversion),CSV(separator(['~|~']),quote(''),terminator('~<EOL>~')), COMPRESSED);							

	f1_valid := 	f1(	 Customer_Name<>''
										,Customer_Account_Number<>''
										,Customer_State<>''
										,Customer_Agency_Vertical_Type<>''
										,Customer_Program<>''
										,First_name<>''
										,Last_Name<>''
										,SSN<>''
										,Physical_Address_1<>''
										,City<>''
										,State<>''
										,Zip<>''
										,Mailing_Address_1<>''
										,Mailing_City<>''
										,Mailing_State<>''
										,Mailing_Zip<>''
										,DOB<>''
									);	
									
	f1_dedup:=fn_dedup(f1_valid, files().Input.KnownFraud.sprayed + f1_valid);

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
		 sequential(
			 Build_Input_File
			,Build_Bypass_Records 
			,Promote_Input_File
		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,build_prepped
		,output('No Valid version parameter passed, skipping Build_Input_KnownFraud atribute')
	);

end;


