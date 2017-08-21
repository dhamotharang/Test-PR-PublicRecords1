export File_TN_RutherFord_GS_Disp_Lookup  := DATASET('~thor_data400::in::crim_court::tn_rutherford_gs_disp_lookup', 
                                                     Layout_TN_Rutherford_GS_Disp_Lookup,
																										 csv(separator(','),terminator(['\r\n','\r','\n']),quote('"')));