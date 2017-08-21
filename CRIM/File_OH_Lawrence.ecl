//Source: Alpharetta-Scrape
import ut;

export File_OH_Lawrence := module 

export File_OH_Lawrence_Defendant_CommonPleas := dataset('~thor_data400::in::crim_court::oh_lawrence_defendant_common_pleas', 
crim.Layout_OH_Ross_Defendant, csv(heading(1),terminator('\n'), separator('|'), quote('')));

export File_OH_Lawrence_Alias_CommonPleas := dataset('~thor_data400::in::crim_court::oh_lawrence_alias_common_pleas', 
crim.Layout_OH_Ross_Alias, csv(heading(1),terminator('\n'), separator('|'), quote('')));

export File_OH_Lawrence_Charge_CommonPleas := dataset('~thor_data400::in::crim_court::oh_lawrence_charge_common_pleas', 
crim.Layout_OH_Ross_Charge, csv(heading(1),terminator('\n'), separator('|'), quote('')));

export File_OH_Lawrence_Sentence_CommonPleas := dataset('~thor_data400::in::crim_court::oh_lawrence_sentence_common_pleas', 
crim.Layout_OH_Ross_Sentence, csv(heading(1),terminator('\n'), separator('|'), quote('')));

export File_OH_Lawrence_Defendant_Mun := dataset('~thor_data400::in::crim_court::oh_lawrence_defendant_municipal', 
crim.Layout_OH_Ross_Defendant, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

export File_OH_Lawrence_Charge_Mun := dataset('~thor_data400::in::crim_court::oh_lawrence_charge_municipal', 
crim.Layout_OH_Ross_Charge, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

export File_OH_Lawrence_Alias_Mun := dataset('~thor_data400::in::crim_court::oh_lawrence_alias_municipal', 
crim.Layout_OH_Ross_Alias, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

export File_OH_Lawrence_Sentence_Mun := dataset('~thor_data400::in::crim_court::oh_lawrence_sentence_municipal', 
crim.Layout_OH_Ross_Sentence, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

end;

