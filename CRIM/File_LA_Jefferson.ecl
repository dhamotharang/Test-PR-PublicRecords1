//Source: Alpharetta-Scrape
import ut;

export File_LA_Jefferson := module 

export Defendant := dataset('~thor_data400::in::crim_court::la_jefferson_defendant', 
crim.Layout_LA_Jefferson.Defendant, csv(heading(1),terminator('\n'), separator('|')));

export Alias := dataset('~thor_data400::in::crim_court::la_jefferson_alias', 
crim.Layout_LA_Jefferson.Alias, csv(heading(1),terminator('\n'), separator('|')));

export Charge := dataset('~thor_data400::in::crim_court::la_jefferson_charge', 
crim.Layout_LA_Jefferson.Charge, csv(heading(1),terminator('\n'), separator('|')));

export Sentence := dataset('~thor_data400::in::crim_court::la_jefferson_sentence', 
crim.Layout_LA_Jefferson.Sentence, csv(heading(1),terminator('\n'), separator('|')));

end;
