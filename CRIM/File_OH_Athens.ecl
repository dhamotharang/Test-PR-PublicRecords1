//Source: Alpharetta-Scrape
import ut;

export File_OH_Athens := module

export File_OH_Athens_Defendant := dataset('~thor_data400::in::crim_court::oh_athens_defendant', 
crim.Layout_OH_Ross_Defendant, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

export File_OH_Athens_Alias := dataset('~thor_data400::in::crim_court::oh_athens_alias', 
crim.Layout_OH_Ross_Alias, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

export File_OH_Athens_Charge := dataset('~thor_data400::in::crim_court::oh_athens_charge', 
crim.Layout_OH_Ross_charge, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

export File_OH_Athens_Sentence := dataset('~thor_data400::in::crim_court::oh_athens_sentence', 
crim.Layout_OH_Ross_Sentence, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

end;