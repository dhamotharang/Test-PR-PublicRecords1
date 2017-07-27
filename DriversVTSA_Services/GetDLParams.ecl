IMPORT AutoStandardI;

EXPORT GetDLParams := MODULE;
	EXPORT params := INTERFACE(AutoStandardI.LIBIN.PenaltyI.base)
		EXPORT STRING dlState := '';
	END;

	EXPORT getDefault() := MODULE(PROJECT(AutoStandardI.GlobalModule(), params, OPT))
													 STRING tmpDlSt := '' : STORED('DLState');
													 EXPORT STRING dlState := StringLib.StringToUpperCase(tmpDLSt);
												 END;
END;