import data_services, ArrestLogs, Crim_Common;

//Abinitio Files
ds := dataset(data_services.foreign_prod+'thor_data400::in::arrest_extrenal_sources_offenses', Crim_Common.Layout_In_Arrest_Offenses, flat)(vendor in
 
	['A2', //(CV)CA-SanBernardino
	 'A4', // FL-SarasotaCtyArrest
	 'AP', // TX-LubbockCtyArr
	 'B7', // CA-SanJoaquinArr
	 'B8', // CA-Solano_Arr
	 'D4',  // MI-Oakland Co Arrest
	//files are now built in ECL - Bug# 178960
	 'A3', // CA-SantaMonicaCtyArr historical
	 'A7', // WA-OkanoganCtyArrest historical
	 'AT' // FL-DadeCtyArrest historical
	 ]);

//ECL_files 
	CA_SM	:=	ArrestLogs.map_CA_SantaMonicaOffenses;
	FL_DA	:=	ArrestLogs.map_FL_DadeOffenses;
	WA_OK	:=	ArrestLogs.map_WA_OkanoganOffenses;
	
export File_In_Arrest_Offenses := ds
																+ CA_SM
																+ FL_DA
																+ WA_OK;
