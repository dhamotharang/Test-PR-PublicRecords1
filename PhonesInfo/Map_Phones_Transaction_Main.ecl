IMPORT _control, MDR, Std, dx_PhonesInfo;

	//Base Files by Source
	portFile		:= 	PhonesInfo.File_iConectiv.Main;																																					//iConectiv/Telo Ported Phones (source='PK')
	portVFile		:=  project(PhonesInfo.File_iConectiv.Main_PortData_Valid, dx_PhonesInfo.Layouts.Phones_Transaction_Main);	//iConectiv PortValidate Phones (source='P!')
	deactFile		:= 	PhonesInfo.File_Deact.Main;																																							//Digital Segment Deact
	deactGHFile	:= 	PhonesInfo.File_Deact_GH.Main;																																					//Neustar Gong History Deact
	otpFile 		:= 	PhonesInfo.File_OTP.Main;																																								//OTP
	
	//Concat Base Files Together	
	concatFiles := 	portFile +
									portVFile +
									deactFile +
									deactGHFile +
									otpFile; 
									
	//Add Global_SID Field												
     addGlobalSID:= 	MDR.macGetGlobalSID(concatFiles,'PhonesMetadata_Virtual','','global_sid');//CCPA-799

EXPORT Map_Phones_Transaction_Main := addGlobalSID;