

//Source: Alpharetta-Scrape
import ut;

export File_OH_Summit_Akron := module 
                              
export Defendant := dataset(ut.foreign_prod+'~thor_data400::in::crim_court::oh_akron_defendant', 
crim.Layout_OH_Summit_Akron_Defendant, csv(heading(1),terminator('\n'), separator(['|','/t']),QUOTE('"')));

export Charge := dataset(ut.foreign_prod+'~thor_data400::in::crim_court::oh_akron_charge', 
crim.Layout_OH_Summit_Akron_Charge, csv(heading(1),terminator('\n'), separator(['|','/t']),QUOTE('"')));

export Sentence := dataset(ut.foreign_prod+'~thor_data400::in::crim_court::oh_akron_sentence', 
crim.Layout_OH_Summit_Akron_Sentence, csv(heading(1),terminator('\n'), separator(['|','	']),QUOTE('"')));

end;





