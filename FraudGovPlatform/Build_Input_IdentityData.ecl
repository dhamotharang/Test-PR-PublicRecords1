IMPORT tools,STD, FraudGovPlatform_Validation;
EXPORT Build_Input_IdentityData(
	 string		pversion
) :=
module

	SHARED fn_dedup(infile , inputs):=functionmacro
			// rollup by Customer_Name + Customer_Account_Number + Customer_State + 
			//           Customer_Agency_Vertical_Type + Customer_Program + First_name + 
			//           Last_Name + SSN + Date_of_Birth + Transaction ID, 
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
						,Transaction_ID_Number
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
																				,Transaction_ID_Number
																				,local
																				);

			return in_ddp;
	endmacro;

	SHARED Sprayed_IdentityData := Files(pversion).Sprayed.IdentityData;
	
		Layouts.Input.IdentityData tr(Sprayed_IdentityData l) := transform
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

	f1:=project(Sprayed_IdentityData,tr(left));


	f1_bypass:=f1
			(	 
			//Empty Values
			Customer_Name 											=''
			or Customer_Account_Number 					=''
			or Customer_Job_ID 									=''
			or Batch_Record_ID 									=''
			or Reason_for_Transaction_Activity 	=''
			or Customer_County 									=''
			or Customer_Agency 									=''
			or First_name												=''
			or Last_Name												=''
			// Format
			or length(Date_of_Transaction)		<>8	
			// Lists
			or (Customer_State 								in FraudGovPlatform_Validation.Mod_Sets.States) 								= FALSE
			or (Customer_Agency_Vertical_Type 	in FraudGovPlatform_Validation.Mod_Sets.Agency_Vertical_Type) 	= FALSE
			or (Customer_Program 							in FraudGovPlatform_Validation.Mod_Sets.IES_Benefit_Type) 			= FALSE				
			);

	f1_bypass_dedup:=fn_dedup(f1_bypass, files().Input.ByPassed_IdentityData.sprayed + f1_bypass);
	
	Build_Bypass_Records :=  OUTPUT(f1_bypass_dedup,,Filenames().Input.ByPassed_IdentityData.New(pversion),CSV(separator(['~|~']),quote(''),terminator('~<EOL>~')), COMPRESSED);							

	f1_valid := 	f1(Customer_Name<>''
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
									
	f1_dedup:=fn_dedup(f1_valid, files().Input.IdentityData.sprayed + f1_valid);

	Build_Input_File :=  OUTPUT(f1_dedup,,Filenames().Input.IdentityData.New(pversion),CSV(separator(['~|~']),quote(''),terminator('~<EOL>~')), COMPRESSED);							

	Promote_Input_File := 
		sequential(
			 STD.File.StartSuperFileTransaction()
			 //Promote Input Records
			,STD.File.ClearSuperFile(Filenames().Input.IdentityData.Used, TRUE)
			,STD.File.AddSuperfile(
				 Filenames().Input.IdentityData.Sprayed
				,Filenames().Input.IdentityData.Used
				,addcontents := true
			)
			,STD.File.ClearSuperFile(Filenames().Input.IdentityData.Sprayed)
			,STD.File.AddSuperfile(
				 Filenames().Input.IdentityData.Sprayed
				,Filenames().Input.IdentityData.New(pversion)
			)
			//Promote Bypass Records
			,STD.File.ClearSuperFile(Filenames().Input.ByPassed_IdentityData.Used, TRUE)
			,STD.File.AddSuperfile(
				 Filenames().Input.ByPassed_IdentityData.Sprayed
				,Filenames().Input.ByPassed_IdentityData.Used
				,addcontents := true
			)
			,STD.File.ClearSuperFile(Filenames().Input.ByPassed_IdentityData.Sprayed)
			,STD.File.AddSuperfile(
				 Filenames().Input.ByPassed_IdentityData.Sprayed
				,Filenames().Input.ByPassed_IdentityData.New(pversion)
			)
			//Clear Individual Sprayed Files
			,STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._IdentityDataPassed, TRUE)
			,STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._IdentityDataRejected, TRUE)
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
		,output('No Valid version parameter passed, skipping Build_Input_IdentityData atribute')
	);

end;


