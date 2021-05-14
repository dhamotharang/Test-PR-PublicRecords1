import ut;

tx_mar_filter := dataset('~thor_200::in::mar_div::tx::marriage',marriage_divorce_v2.Layout_Marriage_TX_In,csv(heading(1),separator('*'),terminator(['\n','\r\n']),quote('"')),OPT);

export File_Marriage_TX_In  := tx_mar_filter( (trim(HName)!='') or (trim(WNAME)!='')); 	