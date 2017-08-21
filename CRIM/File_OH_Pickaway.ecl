//Source: Alpharetta-Scrape
import ut;

export File_OH_Pickaway := module

export File_OH_Pickaway_Defendant := dataset('~thor_data400::in::crim_court::oh_pickaway_defendant', 
crim.Layout_OH_Ross_Defendant, csv(heading(1),terminator('\n'), separator('|'), quote('')));

export File_OH_Pickaway_Charge := dataset('~thor_data400::in::crim_court::oh_pickaway_charge', 
crim.Layout_OH_Ross_Charge, csv(heading(1),terminator('\n'), separator('|'), quote('')));

export File_OH_Pickaway_Alias := dataset('~thor_data400::in::crim_court::oh_pickaway_alias', 
crim.Layout_OH_Ross_Alias, csv(heading(1),terminator('\n'), separator('|'), quote('')));

export File_OH_Pickaway_Sentence := dataset('~thor_data400::in::crim_court::oh_pickaway_sentence', 
crim.Layout_OH_Ross_Sentence, csv(heading(1),terminator('\n'), separator('|'), quote('')));

end;


