export File_Soff_Vehicle := DATASET(SOFF_SuperFileList.DIGSSOFFVehicle,
                                    //'~thor_data50::in::digssoff::raw_data_vehicle', 
                                    Layout_soff_vehicle, 
																		csv(separator('|'),terminator(['\r\n','\r','\n']),quote('')));