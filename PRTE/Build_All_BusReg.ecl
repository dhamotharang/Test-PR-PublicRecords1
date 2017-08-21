IMPORT prte_csv, tools;

EXPORT Build_All_BusReg(STRING	pversion) := MODULE										

	Create_Superfiles_Busreg           :=  PRTE.SprayFiles(pversion).Create_Input_Superfiles('busreg_aid');
	Spray_Busreg          						 :=  PRTE.SprayFiles(pversion).Spray_Raw_Data('busreg_built__aid','busreg_aid',,,'.txt');
	Add2SuperFile_Busreg          		 :=  PRTE.SprayFiles(pversion).Add_To_Superfiles('busreg_aid');
	Build_BusReg_Keys									 :=  PRTE.Proc_Build_BusReg_Keys(pversion);
	Promote_Keys											 :=  PRTE_CSV.BusReg_Promote_Keys(pversion,FALSE).promote_all;

	full_build 								:= SEQUENTIAL( Create_Superfiles_Busreg
																					,Spray_Busreg
																					,Add2SuperFile_Busreg
																					,PRTE_CSV.Promote('busreg_aid').input.sprayed2using																					
																					,Build_BusReg_Keys
																					,Promote_Keys																					
																					,PRTE_CSV.Promote('busreg_aid').input.using2used																						
																					);

	EXPORT All 	:= 	IF(tools.fun_IsValidVersion(pversion)
									 ,full_build
									 ,OUTPUT('No Valid version parameter passed to Build_All_BusReg, skipping build')
									 );						
						
END;