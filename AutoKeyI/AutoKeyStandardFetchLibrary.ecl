import AutokeyI;
tempmod(AutokeyI.AutoKeyStandardFetchArgumentInterface args) := MODULE
	EXPORT ids := PROJECT(AutokeyI.FetchI.new.do(AutokeyI.FetchI_Pkg.new.val(args),args),{unsigned6 ID, boolean isDID, boolean isBDID, boolean IsFake});
end;

EXPORT AutoKeyStandardFetchLibrary(AutokeyI.AutoKeyStandardFetchArgumentInterface args) := FUNCTION
	RETURN PROJECT(tempmod(args),AutokeyI.AutoKeyStandardFetchLibraryInterface(args));
END;
