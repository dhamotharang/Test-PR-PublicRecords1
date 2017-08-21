import prte_csv, tools;

export Build_All_FAA(string	pversion) := module										

	Create_Superfiles_FAA_Aircraft_Reg :=  PRTE.SprayFiles(pversion).Create_Input_Superfiles('faa_aircraft_reg');
	Create_Superfiles_FAA_Airmen		 	 :=  PRTE.SprayFiles(pversion).Create_Input_Superfiles('faa_airmen');
	Create_Superfiles_FAA_Airmen_Certs :=  PRTE.SprayFiles(pversion).Create_Input_Superfiles('faa_airmen_certs');															
	Spray_FAA_Aircraft_Reg						 :=  PRTE.SprayFiles(pversion).Spray_Raw_Data('faa__aircraft_reg_built','faa_aircraft_reg');
	Spray_FAA_Airmen									 :=  PRTE.SprayFiles(pversion).Spray_Raw_Data('faa_airmen_built','faa_airmen');
	Spray_FAA_Airmen_Certs						 :=  PRTE.SprayFiles(pversion).Spray_Raw_Data('faa_airmen_certs_built','faa_airmen_certs');
	Add2SuperFile_FAA_Aircraft_Reg		 :=  PRTE.SprayFiles(pversion).Add_To_Superfiles('faa_aircraft_reg');
	Add2SuperFile_FAA_Airmen					 :=  PRTE.SprayFiles(pversion).Add_To_Superfiles('faa_airmen');
	Add2SuperFile_FAA_Airmen_Certs		 :=  PRTE.SprayFiles(pversion).Add_To_Superfiles('faa_airmen_certs');															 
	Build_FAA_Keys										 :=  PRTE.Proc_Build_FAA_Keys(pversion);
	Promote_Keys											 :=  PRTE_CSV.FAA_Promote_Keys(pversion,false).promote_all;

	full_build 								:= sequential( Create_Superfiles_FAA_Aircraft_Reg
																					,Create_Superfiles_FAA_Airmen
																					,Create_Superfiles_FAA_Airmen_Certs
																					,Spray_FAA_Aircraft_Reg
																					,Spray_FAA_Airmen
																					,Spray_FAA_Airmen_Certs
																					,Add2SuperFile_FAA_Aircraft_Reg
																					,Add2SuperFile_FAA_Airmen
																					,Add2SuperFile_FAA_Airmen_Certs
																					,PRTE_CSV.Promote('faa_aircraft_reg').input.sprayed2using
																					,PRTE_CSV.Promote('faa_airmen').input.sprayed2using
																					,PRTE_CSV.Promote('faa_airmen_certs').input.sprayed2using																					
																					,Build_FAA_Keys
																					,Promote_Keys																					
																					,PRTE_CSV.Promote('faa_aircraft_reg').input.using2used
																					,PRTE_CSV.Promote('faa_airmen').input.using2used
																					,PRTE_CSV.Promote('faa_airmen_certs').input.using2used																						
																					);

	export All 	:= 	if(tools.fun_IsValidVersion(pversion)
									 ,full_build
									 ,output('No Valid version parameter passed to Build_All_FAA, skipping build')
									 );						
						
end;