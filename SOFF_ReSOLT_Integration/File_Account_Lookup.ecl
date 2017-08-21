export File_Account_Lookup := DATASET(ReSOLT_SuperFile_List.SOFFReSOLT_Account,
                                          //'~thor_data50::in::digssoff::source_lookup', 
                                          Layout_Account_Lookup,csv(separator(','),terminator(['\r\n','\r','\n']),quote('"')));