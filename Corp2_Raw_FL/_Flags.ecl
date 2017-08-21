IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT TMFile	    := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_FL.Filenames().Base.TMFile.QA)))    > 0;
		EXPORT CorpFile	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_FL.Filenames().Base.CorpFile.QA)))  > 0;
		EXPORT EventFile	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_FL.Filenames().Base.EventFile.QA))) > 0;
  end;
end;


