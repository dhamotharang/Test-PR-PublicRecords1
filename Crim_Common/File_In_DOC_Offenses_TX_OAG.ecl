tx:= dataset('~thor_data400::in::crim_offenses_tx_oag', Layout_In_DOC_Offenses.new,flat);
lkup := Crim_Common.File_In_DOC_Offenses_TX_OAG_NCIC.lkup;

tx trecs(tx L, lkup R) := transform
//self.off_lev := if(L.off_code = R.code, R.off_lev+R.degree,L.off_lev);
self.off_lev := if(L.off_code = R.code, R.off_lev,L.off_lev);
self := L;
end;

jrecs := join(tx,lkup,
							left.off_code = right.code,
							trecs(left,right),lookup);
							
export File_In_DOC_Offenses_TX_OAG := jrecs;
							

