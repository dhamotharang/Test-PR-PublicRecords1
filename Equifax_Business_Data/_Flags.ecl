IMPORT _control, VersionControl;

EXPORT _Flags :=
MODULE

	EXPORT IsTesting 							:= VersionControl._Flags.IsDataland;
	
	EXPORT UseStandardizePersists := IsTesting;	// Missing dependency from persist to stored
	
	EXPORT ExistCurrentSprayed		     := EXISTS(NOTHOR(fileservices.superfilecontents(filenames().Input.Companies.using )));
	EXPORT ExistContactsCurrentSprayed := EXISTS(NOTHOR(fileservices.superfilecontents(filenames().Input.Contacts.using )));
  
	EXPORT ExistBaseFile				 := EXISTS(NOTHOR(fileservices.superfilecontents(filenames().base.Companies.qa		 )));  
	EXPORT ExistContactsBaseFile := EXISTS(NOTHOR(fileservices.superfilecontents(filenames().base.Contacts.qa		   )));

	EXPORT UpdateExists						:= ExistCurrentSprayed and ExistBaseFile;
	EXPORT UpdateContactsExists	  := ExistContactsCurrentSprayed and ExistContactsBaseFile;

	EXPORT IsUpdateFullFile				:= TRUE;	//Current/historical flag depends on this
	
	EXPORT ShouldFilter						:= TRUE;

END;