import AutokeyI;
EXPORT AutoKeyStandardFetchLibraryInterface(AutokeyI.AutoKeyStandardFetchArgumentInterface args) := INTERFACE
	EXPORT DATASET({unsigned6 ID, boolean isDID, boolean isBDID, boolean IsFake}) ids;
END;
