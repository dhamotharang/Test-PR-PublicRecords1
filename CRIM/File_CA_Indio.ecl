import ut;
export File_CA_Indio := DATASET('~thor_data400::in::crim_court::ca_indio', 
                                                     Layout_CA_Indio,
																										 csv(separator('|'),terminator(['\r\n','\r','\n']),quote('"')));
