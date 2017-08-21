//Source: Alpharetta-Scrape
import ut;

export File_LA_EBatonRouge := module 

export Defendant := dataset('~thor_data400::in::crim_court::la_ebatonrouge_defendant', 
crim.Layout_OH_Ross_Defendant, csv(heading(1),terminator('\n'), separator('|')));

export Alias := dataset('~thor_data400::in::crim_court::la_ebatonrouge_alias', 
crim.Layout_OH_Ross_Alias, csv(heading(1),terminator('\n'), separator('|')));

export Charge := dataset('~thor_data400::in::crim_court::la_ebatonrouge_charge', 
crim.Layout_OH_Ross_Charge, csv(heading(1),terminator('\n'), separator('|')));

export Sentence := dataset('~thor_data400::in::crim_court::la_ebatonrouge_sentence', 
crim.Layout_OH_Ross_Sentence, csv(heading(1),terminator('\n'), separator('|')));

end;