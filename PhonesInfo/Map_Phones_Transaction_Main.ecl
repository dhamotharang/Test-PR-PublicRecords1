	//Base Files by Source
	portFile		:= 	PhonesInfo.File_TCPA.Main(vendor_first_reported_dt<=20150308);					//Neustar Ported
	port2File		:= 	PhonesInfo.File_iConectiv.Main;																					//iConectiv Ported
	deactFile		:= 	PhonesInfo.File_Deact.Main;																							//Digital Segment Deact
	deactGHFile	:= 	PhonesInfo.File_Deact_GH.Main;																					//Neustar Gong History Deact
	otpFile 		:= 	PhonesInfo.File_OTP.Main;																								//OTP
	
	//Concat Base Files Together	
	concatFiles := 	portFile +
									port2File +
									deactFile +
									deactGHFile +
									otpFile; 												

EXPORT Map_Phones_Transaction_Main := concatFiles;