export File_Soff_Alias := DATASET(  SOFF_SuperFileList.DIGSSOFFAlias ,
                                    //'~thor_data50::in::digssoff::raw_data_alias', 
                                    Layout_soff_alias, 
																		csv(separator('|'),terminator(['\r\n','\r','\n']),quote('')));