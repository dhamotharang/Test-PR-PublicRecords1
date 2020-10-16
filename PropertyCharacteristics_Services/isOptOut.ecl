IMPORT Doxie, Suppress;

EXPORT isOptOut ( UNSIGNED8 Lexid) := FUNCTION
	mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
	MAC_Suppress_In_Layout := RECORD
		UNSIGNED6 did;
		UNSIGNED4 global_sid;
	END;
	ds_in	:= DATASET([{Lexid, Constants.CCPA_Global_SourceID}],MAC_Suppress_In_Layout);
	RETURN ~EXISTS(Suppress.MAC_SuppressSource(ds_in, mod_access));
END;
