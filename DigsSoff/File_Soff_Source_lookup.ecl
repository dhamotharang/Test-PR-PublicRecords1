export File_Soff_Source_lookup := DATASET(SOFF_SuperFileList.DIGSSOFFSource,
                                          //'~thor_data50::in::digssoff::source_lookup', 
                                          Layout_Soff_Source_lookup,csv(separator(','),terminator(['\r\n','\r','\n']),quote('')));