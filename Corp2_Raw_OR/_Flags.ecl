IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT CountyDBExtract				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OR.Filenames().Base.CountyDBExtract.QA))) 			> 0;
		EXPORT EntityDBExtract				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OR.Filenames().Base.EntityDBExtract.QA))) 			> 0;
		EXPORT MergerShareDBExtract		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OR.Filenames().Base.MergerShareDBExtract.QA))) > 0;
		EXPORT NameDBExtract					:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OR.Filenames().Base.NameDBExtract.QA))) 		 		> 0;
		EXPORT RelAssocNameDBExtract	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OR.Filenames().Base.RelAssocNameDBExtract.QA)))> 0;
		EXPORT TranDBExtract					:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OR.Filenames().Base.TranDBExtract.QA))) 			 	> 0;
	END;
END;