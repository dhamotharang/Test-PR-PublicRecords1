import ut;
export File_OH_Summit := DATASET('~'+ut.foreign_prod+'thor_data400::in::crim_court::oh_summit', 
                                                     Layout_OH_Summit,
																										 csv(separator('|'),terminator(['\r\n','\r','\n']),quote('')));