IMPORT _Control, VersionControl;

EXPORT _Flags := MODULE
 EXPORT IsTesting							 := VersionControl._Flags.IsDataland;
 EXPORT UseStandardizePersists := NOT IsTesting; // for bug 26170 -- Missing dependency from persist to stored
END;