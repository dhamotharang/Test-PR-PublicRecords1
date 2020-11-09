IMPORT doxie;

// I want this interface to be independent from $.LIB_Business_Shell_LIBIN.
EXPORT LIB_B2B_options := INTERFACE(doxie.IDataAccessFlat)
  EXPORT UNSIGNED1 MarketingMode                  := $.Constants.Default_MarketingMode;
  EXPORT STRING50 AllowedSources                  := $.Constants.Default_AllowedSources;
  EXPORT BOOLEAN OverrideExperianRestriction      := FALSE;
END;
