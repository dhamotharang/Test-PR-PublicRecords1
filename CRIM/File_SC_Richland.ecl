//Source: Alpharetta-Scrape
import ut;

export File_SC_Richland := module 

export Defendant := dataset('~thor_data400::in::crim_court::sc_richland_defendant', 
crim.Layout_OH_Ross_Defendant, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

export Alias := dataset('~thor_data400::in::crim_court::sc_richland_alias', 
crim.Layout_OH_Ross_Alias, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

export Charge := dataset('~thor_data400::in::crim_court::sc_richland_charge', 
crim.Layout_OH_Ross_Charge, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

export Sentence := dataset('~thor_data400::in::crim_court::sc_richland_sentence', 
crim.Layout_OH_Ross_Sentence, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

end;