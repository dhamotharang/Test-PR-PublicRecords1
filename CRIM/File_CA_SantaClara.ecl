import ut;

export File_CA_SantaClara := module 

 export File_CA_SantaClara_Sup := 
	dataset('~thor_data400::in::crim_court::CA_SantaClara_Superior_ff',
	Crim.Layout_CA_SantaClara,csv(heading(1),terminator('\n'), separator('|'), quote('')));

 export  File_CA_SantaClara_Mun := 
	dataset('~thor_data400::in::crim_court::CA_SantaClara_Municipal_ff',
	Crim.Layout_CA_SantaClara,csv(heading(1),terminator('\n'), separator('|'), quote('')));

end;
