export File_Soff_Offense := DATASET(SOFF_SuperFileList.DIGSSOFFOffense,
                                    //'~thor_data50::in::digssoff::raw_data_offense', 
                                    Layout_soff_offense, 
																		csv(separator('|'),terminator(['\r\n','\r','\n']),quote('')));