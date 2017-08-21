IMPORT _Control, VersionControl;

EXPORT _Flags := MODULE
 EXPORT IsTesting							 := VersionControl._Flags.IsDataland;
 EXPORT UseStandardizePersists := NOT IsTesting; // for bug 26170 -- Missing dependency from persist to stored
 EXPORT ExistCurrentSprayed		 := nothor(FileServices.SuperFileExists(Filenames().prov_info_Input.Using)) AND 
												             COUNT(nothor(FileServices.SuperFileContents(Filenames().prov_info_Input.Using))) > 0;
 EXPORT ExistBaseFile					 := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().prov_info_Base.QA))) > 0;	
 EXPORT Update								 := ExistCurrentSprayed AND ExistBaseFile;
 EXPORT IsUpdateFullFile			 := FALSE;
END;