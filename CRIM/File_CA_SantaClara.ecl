import data_services ;

export File_CA_SantaClara := module 

 export File_CA_SantaClara_Sup := 
	dataset(data_services.foreign_prod+'thor_data400::in::crim_court::CA_SantaClara_Superior_ff',
	Crim.Layout_CA_SantaClara,csv(heading(1),terminator('\n'), separator('|'), quote('')));

 export  File_CA_SantaClara_Mun := 
	dataset(data_services.foreign_prod+'thor_data400::in::crim_court::CA_SantaClara_Municipal_ff',
	Crim.Layout_CA_SantaClara,csv(heading(1),terminator('\n'), separator('|'), quote('')));

end;
