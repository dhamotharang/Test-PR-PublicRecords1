import MI5,crim_cp_ln;

export File_crim_charges := dataset('~thor200_144::in::crim_charges',Crim_CP_LN.layout_cross_criminal_charges, 
																			csv(separator('|'),terminator(['\r\n','\r','\n']),quote('')));