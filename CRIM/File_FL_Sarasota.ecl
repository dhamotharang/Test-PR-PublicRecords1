//Source: Alpharetta-Scrape
import ut;

export File_FL_Sarasota := module

export Defendant := dataset('~thor_data400::in::crim_court::fl_sarasota_defendant', 
crim.Layout_FL_Sarasota_Defendant, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

export Alias := dataset('~thor_data400::in::crim_court::fl_sarasota_alias', 
crim.Layout_FL_Sarasota_Alias, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

export Charge := dataset('~thor_data400::in::crim_court::fl_sarasota_charge', 
crim.Layout_FL_Sarasota_Charge, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

export Sentence := dataset('~thor_data400::in::crim_court::fl_sarasota_sentence', 
crim.Layout_FL_Sarasota_Sentence, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

end;

