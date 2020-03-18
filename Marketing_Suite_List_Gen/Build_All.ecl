export Build_All(
									string	pFilename				=	''
								) := module

	export ParmFile			:=	dataset('~' + pFileName,Marketing_Suite_List_Gen.Layouts.Layout_ParmFile,CSV(SEPARATOR(['|']), quote('"'), TERMINATOR(['\n','\r\n','\n\r']), HEADING(1)));
	IdBegPos						:=	StringLib.Stringfind(pFilename, '-', 1);
	IdEndPos						:=	StringLib.Stringfind(pFilename, '.', 1);
	export JobID				:=	pFilename[IdBegPos + 1..IdEndPos-1];
	export resultsCheck	:=	Marketing_Suite_List_Gen.ValidateBatchParmFile(ParmFile);
	export ReturnList		:=	Marketing_Suite_List_Gen.Build_List(resultsCheck,JobID).all;
	
	export All	:=	sequential(ReturnList);

end;