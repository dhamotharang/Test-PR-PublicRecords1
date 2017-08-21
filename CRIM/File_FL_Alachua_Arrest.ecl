import ut;
export File_FL_Alachua_Arrest := DATASET('~'+'thor_data400::in::crim_court::fl_alachua_arrest', 
                                         //'~thor_data400::in::crim_court::fl_alachua_arrest' use this for prod.
                                         Layout_FL_Alachua_Arrest,
																				 csv(separator('|'),terminator(['\r\n','\r','\n']),quote('"')));

