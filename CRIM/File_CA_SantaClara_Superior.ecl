import ut;

export File_CA_SantaClara_Superior := 
	dataset('~thor_data400::in::crim_court::CA_SantaClara_Superior_ff',
	Crim.Layout_CA_SantaClara,csv(heading(1),terminator('\n'), separator('|'), quote('')));