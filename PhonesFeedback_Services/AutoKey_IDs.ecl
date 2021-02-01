IMPORT AutoKeyI;

EXPORT AutoKey_IDs := MODULE
  EXPORT params := INTERFACE(AutoKeyI.AutoKeyStandardFetchBaseInterface)
    EXPORT BOOLEAN workHard := TRUE;
    EXPORT BOOLEAN noFail := FALSE;
    EXPORT BOOLEAN isdeepDive := FALSE;
  END;
END;
