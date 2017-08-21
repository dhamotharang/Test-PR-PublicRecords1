//Source: Alpharetta-Scrape
import ut;

export File_TX_Tom_Greene := module

export Defendant := dataset('~thor_data400::in::crim_court::tx_tom_greene_defendant', 
crim.Layout_TX_Grayson_Defendant, csv(heading(1),terminator('\n'), separator('|')));

export Alias := dataset('~thor_data400::in::crim_court::tx_Tom_Greene_alias', 
crim.Layout_TX_Grayson_Alias, csv(heading(1),terminator('\n'), separator('|')));

export Charge := dataset('~thor_data400::in::crim_court::tx_Tom_Greene_charge', 
crim.Layout_TX_Grayson_Charge, csv(heading(1),terminator('\n'), separator('|')));

export Sentence := dataset('~thor_data400::in::crim_court::tx_Tom_Greene_sentence', 
crim.Layout_TX_Grayson_Sentence, csv(heading(1),terminator('\n'), separator('|')));

end;
