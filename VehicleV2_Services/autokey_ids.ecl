
EXPORT autokey_ids(BOOLEAN inWorkhard = FALSE, BOOLEAN inNofail =FALSE, BOOLEAN inNoDeepDives = FALSE) :=
FUNCTION

  in_mod := IParam.getSearchModule();
  autoKey_mod := MODULE(PROJECT(in_mod, IParam.searchParams, opt))
    EXPORT BOOLEAN workHard := inWorkhard;
    EXPORT BOOLEAN noFail := inNofail;
    EXPORT BOOLEAN isdeepDive := NOT inNoDeepDives;
  END;
  RETURN AutoKeyIds(autoKey_mod);
END;
