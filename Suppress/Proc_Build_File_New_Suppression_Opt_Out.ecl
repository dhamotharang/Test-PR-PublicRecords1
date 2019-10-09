IMPORT	versioncontrol;
EXPORT Proc_Build_File_New_Suppression_Opt_Out(String pVersion) := FUNCTION

	//Spray input file
	STRING		vSourceIP		:=	Suppress.Constants.serverIP;
	STRING		vDirectory		:=	Suppress.Constants.OptOut.Directory + pVersion + '/';
	STRING		vfileName		:=	Suppress.Constants.OptOut.FileToSpray;

	checkFileExists		:=	IF(pVersion<>'' AND COUNT(FileServices.remotedirectory(vSourceIP,vDirectory,vfileName,FALSE)(size	<>	0))	=	1,
								TRUE,
								FALSE);
	clearSprayedFile	:= SEQUENTIAL(	FileServices.StartSuperFileTransaction()
									   ,FileServices.clearsuperfile(Suppress.Filenames().OptOut.input.sprayed,TRUE)
									   ,FileServices.finishSuperFileTransaction());																																	
	sprayInputFile		:= Suppress.fSprayFiles.OptOutSrc(pVersion);																	

	//Build base file
	buildBase 			:= Suppress.Proc_Build_Base_OptOut(pVersion);

	RETURN SEQUENTIAL(sprayInputFile, buildBase);

END;