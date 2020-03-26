//Spray

IMPORT STD, orbit;
fileservices := STD.File;

// ###################################################################
//              Spray : Sprays Insurance NAccidents_Inquiry files
// ###################################################################
EXPORT Spray(
             STRING FileName, 
             STRING BuildDate = mod_Utilities.strSysDate,
						 STRING ProductName = '')  := SEQUENTIAL(fn_SprayVariable(SprayProcess_FileNames(FileName,BuildDate).ProcessFile,
																																			SprayProcess_FileNames(FileName,BuildDate).MaxRecLength,
																																			SprayProcess_FileNames(FileName,BuildDate).SPRAY_SUB_FILE,
																																			SprayProcess_FileNames(FileName,BuildDate).FieldSeparator),
																																			
																										 AddSuperFile(SprayProcess_FileNames(FileName,BuildDate).SPRAY_BASE_FILE, 
																												          SprayProcess_FileNames(FileName,BuildDate).SPRAY_SUB_FILE));
																										 // Proc_OrbitI_RecLoad(FileName, build_seq, ProductName));