IMPORT _control, VersionControl;

EXPORT _Flags :=
MODULE

	EXPORT IsTesting 							:= VersionControl._Flags.IsDataland;
	
	EXPORT UseStandardizePersists := IsTesting;	// Missing dependency from persist to stored
	
	EXPORT ExistCurrentSprayed		:= COUNT(NOTHOR(fileservices.superfilecontents(filenames().Input.NAICS.using ))) > 0;
	EXPORT ExistBaseFile					:= COUNT(NOTHOR(fileservices.superfilecontents(filenames().NAICSLookup.qa		 ))) > 0;

	EXPORT UpdateExists						:= ExistCurrentSprayed and ExistBaseFile;
	
	EXPORT ExistCurrentDnbDmiSprayed := COUNT(NOTHOR(fileservices.superfilecontents(filenames().Input.DnbDmi.using ))) > 0;

	EXPORT UpdateDnbDmiExists			   := ExistCurrentDnbDmiSprayed;
	
	EXPORT IsUpdateFullFile				:= TRUE;	//Current/historical flag depends on this
	
	EXPORT ShouldFilter						:= TRUE;

END;