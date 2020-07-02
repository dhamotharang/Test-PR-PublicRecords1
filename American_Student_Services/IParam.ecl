IMPORT doxie, AutoKeyI, AutoStandardI, AutoHeaderI;

EXPORT IParam := MODULE

  EXPORT AutoKeyIdsParams := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
    EXPORT BOOLEAN workHard := FALSE;
    EXPORT BOOLEAN noFail := FALSE;
    EXPORT BOOLEAN isdeepDive := FALSE;
  END;
  
  EXPORT reportParams := INTERFACE (doxie.IDataAccess)
  END;
  
  EXPORT searchParams := interface(reportParams,
                    AutoStandardI.LIBIN.PenaltyI.base,
                    AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,
                    AutoKeyIdsParams)
    EXPORT string14 didValue := '';
    EXPORT unsigned2 penalty_threshold := 10;
    EXPORT string DataPermissionMask := ''; //conflicting definition;
  END;

END;
