import ut;

EXPORT File_Deact := module

	//Raw Daily	
	EXPORT Raw								:= distribute(dataset('~thor_data400::in::phones::deact_daily', 	PhonesInfo.Layout_Deact.Raw, csv(terminator('\n'), separator('|'))))(regexfind('_deact', filename, 0)<>'');	
	
	//Raw Daily History
	EXPORT History						:= dataset('~thor_data400::in::phones::deact_daily_history', 			PhonesInfo.Layout_Deact.History, flat);

	//Base File	
	EXPORT Main_Current 			:= dataset('~thor_data400::base::phones::disconnect_main', 				PhonesInfo.Layout_Deact.Temp, flat);
	
end; 