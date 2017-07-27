
export autokey_ids(boolean inWorkhard = false, boolean inNofail =false, boolean inNoDeepDives = false) := 
FUNCTION

	in_mod := IParam.getSearchModule();
	autoKey_mod := Module(project(in_mod, IParam.searchParams, opt))
		EXPORT BOOLEAN workHard := inWorkhard;
		EXPORT BOOLEAN noFail := inNofail;
		EXPORT BOOLEAN isdeepDive := NOT inNoDeepDives;
	END;
	return AutoKeyIds(autoKey_mod);
END;