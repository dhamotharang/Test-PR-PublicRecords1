//Source: Alpharetta-Scrape
import ut;

export File_OH_Ross := module 

export Common_Pleas_Defendant := dataset('~thor_data400::in::crim_court::oh_ross_common_pleas_defendant', 
crim.Layout_OH_Ross_Defendant, csv(heading(1),terminator('\n'), separator('|'), quote('')));

export Common_Pleas_Charge := dataset('~thor_data400::in::crim_court::oh_ross_common_pleas_charge', 
crim.Layout_OH_Ross_Charge, csv(heading(1),terminator('\n'), separator('|'), quote('')));

export Common_Pleas_Sentence := dataset('~thor_data400::in::crim_court::oh_ross_common_pleas_sentence', 
crim.Layout_OH_Ross_Sentence, csv(heading(1),terminator('\n'), separator('|'), quote('')));

export Common_Pleas_alias := dataset('~thor_data400::in::crim_court::oh_ross_common_pleas_alias', 
crim.Layout_OH_Ross_Alias, csv(heading(1),terminator('\n'), separator('|'), quote('')));

export municipal_Defendant := dataset('~thor_data400::in::crim_court::oh_ross_municipal_defendant', 
crim.Layout_OH_Ross_Defendant, csv(heading(1),terminator('\n'), separator('|'), quote('')));

export municipal_Charge := dataset('~thor_data400::in::crim_court::oh_ross_municipal_charge', 
crim.Layout_OH_Ross_Charge, csv(heading(1),terminator('\n'), separator('|'), quote('')));

export municipal_Sentence := dataset('~thor_data400::in::crim_court::oh_ross_municipal_sentence', 
crim.Layout_OH_Ross_Sentence, csv(heading(1),terminator('\n'), separator('|'), quote('')));

export municipal_alias := dataset('~thor_data400::in::crim_court::oh_ross_municipal_alias', 
crim.Layout_OH_Ross_Alias, csv(heading(1),terminator('\n'), separator('|'), quote('')));

end;


