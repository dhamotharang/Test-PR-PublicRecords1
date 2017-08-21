export File_Soff_Offender := DATASET(SOFF_SuperFileList.DIGSSOFFOffender,
                                     //'~thor_data50::in::digssoff::raw_data_offender', 
                                     Layout_soff_offender, 
																		 csv(separator('|'),terminator(['\r\n','\r','\n']),quote('')));