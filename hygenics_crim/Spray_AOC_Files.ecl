#workunit('name','Hygenics AOC Spray');
IMPORT lib_stringlib, lib_fileservices, _control,lib_thorlib, digssoff;

EXPORT Spray_AOC_Files (String srcIP,
							String targetGrp,
							String RemoteLoc,
							String Update_filedate,
							string src_state) := FUNCTION

	//srcIP       		:= 'edata12.br.seisint.com';
	//targetGrp   		:= 'thor200';
	//RemoteLoc   		:= '/cx4_load01/hygenics/sex_offenders/' ;
	//Update_filedate 	:= '20111003';
	//src_state   		:= 'CONNECTICUT'; 
	
   def   := src_state+'_DEFENDANT.csv';
	 off   := src_state+'_OFFENSE.csv';
	 chg   := src_state+'_CHARGE.csv';
	 sen   := src_state+'_SENTENCE.csv';
	 add   := src_state+'_ADDRESS_HISTORY.csv';
	 ali   := src_state+'_ALIAS.csv';
	 pri   := src_state+'_PRIORS.csv';	 
	 oth   := src_state+'_OTHER.csv';
	 pho   := src_state+'_PHONE_HISTORY.csv';
	 
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
						true),

	output('Source Lookup not found'+' '+srcIP+' '+RemoteLoc+' '+remoteFileName));
																							 
	//Create_SuperFile    	:= Parallel(digssoff.SuperFile_Functions.Fun_createSuperfile('~thor200::in::AOC_ADDRESS_HISTORY'));
	SprayFile          		:= Parallel(Fun_Sprayfile(def,Sprayeddef),
									Fun_Sprayfile(off,Sprayedoff),
									Fun_Sprayfile(chg,Sprayedchg),
	                                Fun_Sprayfile(ali,Sprayedali),
									Fun_Sprayfile(add,Sprayedadd),
	                                Fun_Sprayfile(pri,Sprayedpri),
									Fun_Sprayfile(oth,Sprayedoth),
									Fun_Sprayfile(sen,Sprayedsen));                                                    																		 
												 
	AddToSuperFile    		:=  Parallel(digssoff.SuperFile_Functions.Fun_AddToSuperfile(Sprayeddef, '~thor200::in::crim::hd::aoc_DEFENDANT'),
										digssoff.SuperFile_Functions.Fun_AddToSuperfile(Sprayedoff, '~thor200::in::crim::hd::aoc_OFFENSE'),
										digssoff.SuperFile_Functions.Fun_AddToSuperfile(Sprayedchg, '~thor200::in::crim::hd::aoc_CHARGE'),
										digssoff.SuperFile_Functions.Fun_AddToSuperfile(Sprayedali, '~thor200::in::crim::hd::aoc_ALIAS'),
										digssoff.SuperFile_Functions.Fun_AddToSuperfile(Sprayedpri, '~thor200::in::crim::hd::aoc_PRIOR'),
										digssoff.SuperFile_Functions.Fun_AddToSuperfile(Sprayedoth, '~thor200::in::crim::hd::aoc_OTHER'),
										digssoff.SuperFile_Functions.Fun_AddToSuperfile(Sprayedadd, '~thor200::in::crim::hd::aoc_ADDRESS_HISTORY'),
										digssoff.SuperFile_Functions.Fun_AddToSuperfile(Sprayedsen, '~thor200::in::crim::hd::aoc_SENTENCE'));
   								    
	return sequential(//Create_SuperFile, 
	            SprayFile, 
				FileServices.StartSuperFileTransaction(),								
				AddToSuperFile,
				FileServices.FinishSuperFileTransaction());
				
END;