import ut;

File_OH_Champaign_in := 
	dataset(ut.foreign_prod +'thor_data400::in::crim_court::OH_Champaign',
	Crim.Layout_OH_Champaign,csv(heading(1),terminator('\r\n'), separator('|')));
	
export File_OH_Champaign := File_OH_Champaign_in(CaseNumber != 'CaseNumber');