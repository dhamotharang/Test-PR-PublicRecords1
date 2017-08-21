import MI5,crim_cp_ln;
export File_case_master := dataset('~thor200_144::in::CASE_MASTER',crim_cp_ln.Layout_cross_case_master, 
																			csv(separator('|'),terminator(['\r\n','\r','\n']),quote('')));