//Source: Alpharetta - DIGS Scrape
import ut;

export File_OH_Summit_CuyahogaFalls := module 

export Defendant := dataset('~'+ut.foreign_prod+'thor_data400::in::crim_court::OH_Summit_CuyahogaFalls_defendant', 
crim.Layout_OH_Ross_Defendant, csv(heading(1),terminator('\r\n'), separator('|'),quote('')));

export Charge := dataset('~'+ut.foreign_prod+'thor_data400::in::crim_court::OH_Summit_CuyahogaFalls_charge', 
crim.Layout_OH_Ross_Charge, csv(heading(1),terminator('\r\n'), separator('|'),quote('')));

end;



