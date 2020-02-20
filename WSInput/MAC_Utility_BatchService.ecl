EXPORT MAC_Utility_BatchService() := MACRO

  #WEBSERVICE(FIELDS(
    /*---- Compliance Fields ----*/
    'ApplicationType',
    'IndustryClass',
    'GLBPurpose',
    /*---- Masking Fields ----*/
    'SSNMask',
    'DOBMask',
    'DLMask',
    /*---- Batch ----*/
    'batch_in'
  ));

ENDMACRO;
