//Source: Alpharetta-Scrape
import ut;

export File_OH_Cuyahoga := module

export File_OH_Cuyahoga_Defendant := dataset('~thor_data400::in::crim_court::oh_cuyahoga_defendant', 
crim.Layout_OH_Ross_Defendant, csv(heading(1),terminator('\n'), separator('|'), quote('')));

export File_OH_Cuyahoga_Charge := dataset('~thor_data400::in::crim_court::oh_cuyahoga_charge', 
crim.Layout_OH_Ross_Charge, csv(heading(1),terminator('\n'), separator('|'), quote('')));


// export File_OH_Cuyahoga_Alias := dataset('~thor_data200::in::crim_court::oh_cuyahoga_alias', 
// crim.Layout_OH_Ross_Alias, csv(heading(1),terminator('\n'), separator('|'), quote('')));

// export File_OH_Cuyahoga_Sentence := dataset('~thor_data200::in::crim_court::oh_cuyahoga_sentence', 
// crim.Layout_OH_Ross_Sentence, csv(heading(1),terminator('\n'), separator('|'), quote('')));

end;



