IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT crAnlPf	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_AL.Filenames().Base.crAnlPf.QA))) > 0;
		EXPORT crBusPf	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_AL.Filenames().Base.crBusPf.QA))) > 0;
		EXPORT crHstPf	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_AL.Filenames().Base.crHstPf.QA))) > 0;
		EXPORT crIncPf	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_AL.Filenames().Base.crIncPf.QA))) > 0;
		EXPORT crMstPf	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_AL.Filenames().Base.crMstPf.QA))) > 0;
		EXPORT crNamPf	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_AL.Filenames().Base.crNamPf.QA))) > 0;
		EXPORT crOffPf	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_AL.Filenames().Base.crOffPf.QA))) > 0;
		EXPORT crSerPf	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_AL.Filenames().Base.crSerPf.QA))) > 0;
  end;
end;


