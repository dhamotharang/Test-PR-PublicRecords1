#workunit('name','Hygenics SexPred Pre-process: Spray Hygenics Raw Data');
IMPORT lib_stringlib, lib_fileservices, _control,lib_thorlib, digssoff;

EXPORT Spray_Soff_Files (String srcIP,
							String targetGrp,
							String RemoteLoc,
							String Update_filedate,
							string src_state) := FUNCTION

	//srcIP       		:= 'edata14.br.seisint.com';
	//targetGrp   		:= 'thor200_144';
	//RemoteLoc   		:= '/cx4_load01/hygenics/sex_offenders/' ;
	//Update_filedate 	:= '20111003';
	//src_state   		:= 'CONNECTICUT'; 
	
	def   := src_state+'_SEX_OFFENDER_REGISTRY_DEFENDANT.csv';
	off   := src_state+'_SEX_OFFENDER_REGISTRY_OFFENSE.csv';
	chg   := src_state+'_SEX_OFFENDER_REGISTRY_CHARGE.csv';
	sen   := src_state+'_SEX_OFFENDER_REGISTRY_SENTENCE.csv';
	add   := src_state+'_SEX_OFFENDER_REGISTRY_ADDRESS_HISTORY.csv';
	ali   := src_state+'_SEX_OFFENDER_REGISTRY_ALIAS.csv';
	oth   := src_state+'_SEX_OFFENDER_REGISTRY_OTHER.csv';
	pri   := src_state+'_SEX_OFFENDER_REGISTRY_PRIORS.csv';
	 
	Sprayeddef := def +'_'+Update_filedate; 
	Sprayedoff := off +'_'+Update_filedate; 
	Sprayedchg := chg +'_'+Update_filedate; 
	Sprayedsen := sen +'_'+Update_filedate; 
	Sprayedadd := add +'_'+Update_filedate; 
	Sprayedali := ali +'_'+Update_filedate; 
	Sprayedoth := oth +'_'+Update_filedate;
	Sprayedpri := pri +'_'+Update_filedate;
	 
	sourceCsvSeparater := '\\,';
	sourceCsvTeminater := '\\n,\\r\\n';
	sourceCsvQuote     := '';

	//Check if file exists in UNIX
	checkremotefileexists(STRING FileName)   :=  IF(count(FileServices.remotedirectory(srcIP,RemoteLoc,FileName,false)(size <>0 )) = 1, true, false);
	 
	//Spray the file
    Fun_SprayFile(String remoteFileName, String OPFileName) := IF(count(FileServices.remotedirectory(srcIP, RemoteLoc,remoteFileName,false)(size <>0 )) = 1,
	                 	FileServices.SprayVariable(
						srcIP, 
						RemoteLoc + remoteFileName,,	 								sourceCsvSeparater,
						sourceCsvTeminater, 
						sourceCsvQuote, 
						targetGrp, 
						OPFileName, 
						-1,,, 
						true, 
						true,
						true),

	output('Source Lookup not found'+' '+srcIP+' '+RemoteLoc+' '+remoteFileName));
																							 
	//Create_SuperFile    	:= Parallel(digssoff.SuperFile_Functions.Fun_createSuperfile('~thor200_144::in::AOC_ADDRESS_HISTORY'));
	SprayFile          		:= Parallel(Fun_Sprayfile(def,Sprayeddef),
									Fun_Sprayfile(off,Sprayedoff),
									Fun_Sprayfile(chg,Sprayedchg),
	                                Fun_Sprayfile(ali,Sprayedali),
									Fun_Sprayfile(add,Sprayedadd),
	                                Fun_Sprayfile(pri,Sprayedpri),
									Fun_Sprayfile(oth,Sprayedoth),
									Fun_Sprayfile(sen,Sprayedsen));                                                    																		 
												 
	AddToSuperFile    		:=  Parallel(digssoff.SuperFile_Functions.Fun_AddToSuperfile(Sprayeddef, '~thor200_144::in::sex_offender::hd::DEFENDANT'),
										digssoff.SuperFile_Functions.Fun_AddToSuperfile(Sprayedoff, '~thor200_144::in::sex_offender::hd::OFFENSE'),
										digssoff.SuperFile_Functions.Fun_AddToSuperfile(Sprayedchg, '~thor200_144::in::sex_offender::hd::CHARGE'),
										digssoff.SuperFile_Functions.Fun_AddToSuperfile(Sprayedali, '~thor200_144::in::sex_offender::hd::ALIAS'),
										digssoff.SuperFile_Functions.Fun_AddToSuperfile(Sprayedpri, '~thor200_144::in::sex_offender::hd::PRIOR'),
										digssoff.SuperFile_Functions.Fun_AddToSuperfile(Sprayedoth, '~thor200_144::in::sex_offender::hd::OTHER'),
										digssoff.SuperFile_Functions.Fun_AddToSuperfile(Sprayedadd, '~thor200_144::in::sex_offender::hd::ADDRESS_HISTORY'),
										digssoff.SuperFile_Functions.Fun_AddToSuperfile(Sprayedsen, '~thor200_144::in::sex_offender::hd::SENTENCE'));
   								    
	return sequential(//Create_SuperFile, 
	            SprayFile, 
				FileServices.StartSuperFileTransaction(),								
				AddToSuperFile,
				FileServices.FinishSuperFileTransaction());
				
END;