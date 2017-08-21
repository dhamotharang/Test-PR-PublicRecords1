import MI5,crim_cp_ln;

export File_crim_sentence := dataset('~thor200_144::in::crim_sentence',Crim_CP_LN.layout_cross_criminal_sentences, 
																			csv(separator('|'),terminator(['\r\n','\r','\n']),quote('')));