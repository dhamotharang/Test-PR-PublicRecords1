EXPORT MAC_AccuityBankData_BatchService := MACRO

  #WEBSERVICE(FIELDS(
    /*---- Compliance Fields ----*/
    'DataPermissionMask',
    /*---- Other Fields ----*/
    'IncludeGeotriangulationComparison',
    'ReturnDetailedRoyalties',
    /*---- Batch ----*/
    'batch_in'
  ));

ENDMACRO;
