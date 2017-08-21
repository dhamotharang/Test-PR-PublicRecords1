export File_Soff_Attribute := DATASET(SOFF_SuperFileList.DIGSSOFFAttribute,
                                      //'~thor_data50::in::digssoff::raw_data_attribute', 
                                      Layout_soff_attribute, 
																			csv(separator('|'),terminator(['\r\n','\r','\n']),quote('')));