IMPORT BIPV2, Doxie;

EXPORT IParam := MODULE
  EXPORT options := INTERFACE(Doxie.IDataAccess)
    EXPORT BOOLEAN IncludePhonesPlus := false;
    EXPORT BOOLEAN IncludePhonesFeedback := false;
    EXPORT STRING1 BusinessReportFetchLevel := BIPV2.IDconstants.Fetch_Level_SELEID;
    EXPORT BOOLEAN useSupergroup := false;
    EXPORT BOOLEAN useLevels := false;
    EXPORT BOOLEAN isBIPReport := false;
  END;
END;
