IMPORT _Control, VersionControl, OneKey;

EXPORT _Flags := MODULE

  EXPORT IsTesting                := VersionControl._Flags.IsDataland;
	
  EXPORT UseStandardizePersists   := IsTesting;
  
  EXPORT ExistCurrentSprayedA     := COUNT(NOTHOR(fileservices.superfilecontents(OneKey.Filenames().InputA.using))) > 0;
  EXPORT ExistCurrentSprayedB     := COUNT(NOTHOR(fileservices.superfilecontents(OneKey.Filenames().InputB.using))) > 0;
  EXPORT ExistBaseFile            := COUNT(NOTHOR(fileservices.superfilecontents(OneKey.Filenames().Base.qa))) > 0;

  EXPORT ShouldUpdate             := ExistCurrentSprayedA AND ExistCurrentSprayedB AND ExistBaseFile;

  EXPORT IsUpdateFullFile         := TRUE;	//Current/historical flag depends on this
	
  EXPORT ShouldFilter             := TRUE;

END;