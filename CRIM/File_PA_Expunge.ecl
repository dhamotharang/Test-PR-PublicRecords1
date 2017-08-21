import ut;

export File_PA_Expunge := module 

export File_PA_History_Expunge := dataset('~thor_data400::in::crim_court::pa_historical_expunge',
	Crim.Layout_PA_History_Expunge,csv(heading(1),terminator('\r\n'), separator('|'), quote('')));	

export File_PA_Updating_Expunge := dataset('~thor_data400::in::crim_court::pa_expunge',	Crim.Layout_PA_Updating_Expunge,thor);	

end;