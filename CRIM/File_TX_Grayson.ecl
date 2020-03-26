//Source: Alpharetta-Scrape
import data_services ;

export File_TX_Grayson := module

export Defendant := dataset(data_services.foreign_prod+'thor_data400::in::crim_court::tx_grayson_defendant', 
crim.Layout_TX_Grayson_Defendant, csv(heading(1),terminator('\n'), separator('|'), quote('')));

export Alias := dataset(data_services.foreign_prod+'thor_data400::in::crim_court::tx_grayson_alias', 
crim.Layout_TX_Grayson_Alias, csv(heading(1),terminator('\n'), separator('|'), quote('')));

export Charge := dataset(data_services.foreign_prod+'thor_data400::in::crim_court::tx_grayson_charge', 
crim.Layout_TX_Grayson_Charge, csv(heading(1),terminator('\n'), separator('|'), quote('')));

export Sentence := dataset(data_services.foreign_prod+'thor_data400::in::crim_court::tx_grayson_sentence', 
crim.Layout_TX_Grayson_Sentence, csv(heading(1),terminator('\n'), separator('|'), quote('')));

end;



