import ut;

tx_div_filter := dataset('~thor_200::in::mar_div::tx::divorce',marriage_divorce_v2.Layout_Divorce_TX_In,csv(heading(1),separator(' '),terminator(['\n','\r\n']),quote('"')),OPT);

export File_Divorce_TX_In  := tx_div_filter( (trim(Husbands_Name)!='') or (trim(Wifes_Name)!='')); 
