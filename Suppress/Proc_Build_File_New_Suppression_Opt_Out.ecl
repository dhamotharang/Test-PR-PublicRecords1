EXPORT Proc_Build_File_New_Suppression_Opt_Out(String pVersion) := FUNCTION

	//Spray input file
	STRING		vSourceIP		:=	Constants.serverIP;
	STRING		vDirectory	:=	Constants.SuppressOptOut.Directory + pVersion + '/';
	STRING		vfileName		:=	Constants.SuppressOptOut.FileToSpray;

	checkFileExists		:=	IF(pVersion<>'' AND COUNT(FileServices.remotedirectory(vSourceIP,vDirectory,vfileName,FALSE)(size	<>	0))	=	1,
																	TRUE,
																	FALSE);
	clearSprayedFile	:= SEQUENTIAL(FileServices.StartSuperFileTransaction()
																						,FileServices.clearsuperfile(Filenames(pVersionDate).SuppressOptOut.input.sprayed,TRUE)
																						,FileServices.finishSuperFileTransaction());																																	
	sprayInputFile			:= fSprayFiles.OptOutSrc(pVersion,,'/data/hds_2/test/',,'thor400_dev01');																	

	//Build base file
	newUpdate						:= Input_Raw
END;