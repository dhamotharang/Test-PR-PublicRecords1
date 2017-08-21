import MI5,crim_cp_ln;
export File_case_details := dataset('~thor200_144::in::crim::CASE_DETAILS',crim_cp_ln.Layout_cross_case_detail, 
																			csv(separator('|'),terminator(['\r\n','\r','\n']),quote('')));