IMPORT _control, MDR, Std;

	//Base Files by Source
	portFile		:= 	PhonesInfo.File_TCPA.Main(vendor_first_reported_dt<=20150308);					//Neustar Ported
	port2File		:= 	PhonesInfo.File_iConectiv.Main;																					//iConectiv Ported
	deactFile		:= 	PhonesInfo.File_Deact.Main;																							//Digital Segment Deact
	deactGHFile	:= 	PhonesInfo.File_Deact_GH.Main;																					//Neustar Gong History Deact
	otpFile 		:= 	PhonesInfo.File_OTP.Main;																								//OTP
	
	//Concat Base Files Together	
	concatFiles := 	//portFile +
									port2File +
									deactFile +
									deactGHFile +
									otpFile; 
									
	//Add Global_SID Field
	// addGlobalSID:= 	MDR.macGetGlobalSid(concatFiles, 'PhonesMetadata', 'source', 'global_sid');												
     addGlobalSID:= 	MDR.macGetGlobalSID(concatFiles,'PhonesMetadata_Virtual','','global_sid');//CCPA-799
EXPORT Map_Phones_Transaction_Main := addGlobalSID;