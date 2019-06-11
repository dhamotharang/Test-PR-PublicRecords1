//Source: Alpharetta-Scrape
import data_services;

export File_OH_Brown :=  module 

export Defendant_CommonPleas := dataset(data_services.foreign_prod+'thor_data400::in::crim_court::oh_brown_defendant_common_pleas', 
crim.Layout_OH_Ross_Defendant, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

export Alias_CommonPleas := dataset(data_services.foreign_prod+'thor_data400::in::crim_court::oh_brown_alias_common_pleas', 
crim.Layout_OH_Ross_Alias, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

export Charge_CommonPleas := dataset(data_services.foreign_prod+'thor_data400::in::crim_court::oh_brown_charge_common_pleas', 
crim.Layout_OH_Ross_Charge, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

export Sentence_CommonPleas := dataset(data_services.foreign_prod+'thor_data400::in::crim_court::oh_brown_sentence_common_pleas', 
crim.Layout_OH_Ross_Sentence, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

export Defendant_Mun := dataset(data_services.foreign_prod+'thor_data400::in::crim_court::oh_brown_defendant_municipal', 
crim.Layout_OH_Ross_Defendant, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

export Charge_Mun := dataset(data_services.foreign_prod+'thor_data400::in::crim_court::oh_brown_charge_municipal', 
crim.Layout_OH_Ross_Charge, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

export Alias_Mun := dataset(data_services.foreign_prod+'thor_data400::in::crim_court::oh_brown_alias_municipal', 
crim.Layout_OH_Ross_Alias, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

export Sentence_Mun := dataset(data_services.foreign_prod+'thor_data400::in::crim_court::oh_brown_sentence_municipal', 
crim.Layout_OH_Ross_Sentence, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));

end;
