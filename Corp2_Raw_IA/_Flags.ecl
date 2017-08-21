IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT crpAdd	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IA.Filenames().Base.crpAdd.QA))) > 0;
		EXPORT crpAgt	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IA.Filenames().Base.crpAgt.QA))) > 0;
		EXPORT crpDes	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IA.Filenames().Base.crpDes.QA))) > 0;
		EXPORT crpFil	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IA.Filenames().Base.crpFil.QA))) > 0;
		EXPORT crpHis	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IA.Filenames().Base.crpHis.QA))) > 0;
		EXPORT crpNam	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IA.Filenames().Base.crpNam.QA))) > 0;
		EXPORT crpOff	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IA.Filenames().Base.crpOff.QA))) > 0;
		EXPORT crpPrt	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IA.Filenames().Base.crpPrt.QA)))	> 0;
		EXPORT crpRem	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IA.Filenames().Base.crpRem.QA))) > 0;
		EXPORT crpStk	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IA.Filenames().Base.crpStk.QA))) > 0;
	end;
end;