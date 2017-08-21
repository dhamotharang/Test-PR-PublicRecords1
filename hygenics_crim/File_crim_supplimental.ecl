import MI5,crim_cp_ln;
export File_crim_supplimental := dataset('~thor200_144::in::crim_supplimental',Crim_CP_LN.layout_cross_criminal_supplimental, 
																			csv(separator('|'),terminator(['\r\n','\r','\n']),quote('')));