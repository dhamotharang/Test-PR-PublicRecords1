export File_Soff_Address := DATASET(SOFF_SuperFileList.DIGSSOFFAddress,
                                    //'~thor_data50::in::digssoff::raw_data_address',
                                  Layout_Soff_address,csv(separator('|'),terminator(['\r\n','\r','\n']),quote('')));