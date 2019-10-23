EXPORT Spray_GA(dataset({string ftype,string fdate})infile) := module

//Spray Medical

import lib_fileservices,_control,lib_thorlib;

	string					MedCSVSeparator				:=	'\t';
	string					MedCSVQuote						:=	'"';
	string          GAMedicaldate         := infile(ftype = 'medical')[1].fdate;
	string					GAMedicalLF				:=	'~thor_data400::in::prolic::ga::medical::raw_'+GAMedicaldate;
	
	string          sourceLZ              := '/data/hds_4/prolic/ga/medical_examiners/'+GAMedicaldate+'/';
	string					GAMedicalSF				:=	'~thor_data400::in::prolic::ga::medical::raw';
	         
	string pServer			:=  _Control.IPAddress.bctlpedata11 ;
	
	string pGroupName			:= thorlib.group();

	
	
	
	sprayMedFile	:=	if(	EXISTS(FileServices.RemoteDirectory(pServer,sourceLZ,'medical*.csv')) and FileServices.FindSuperFileSubName(GAMedicalSF,GAMedicalLF) = 0  ,
                       Sequential( 	if (  FileServices.SuperFileExists( GAMedicalSF),FileServices.ClearSuperfile( GAMedicalSF)),

	                              fileservices.sprayvariable(	pServer,
																												sourceLZ + 'medical*.csv',
																												 ,
																												MedCSVSeparator,
																												 ,
																												MedCSVQuote,
																										//		_control.TargetGroup.Thor400_20,
																												pGroupName,
																												GAMedicalLF,
																												,,,true,false,false
																											), 
																	output('No GA Medical files recieved or GA Medical were already Sprayed'))); 
																	
		addMedSuper   := Sequential (  FileServices.StartSuperFileTransaction( ),
		                                   if ( NOT FileServices.SuperFileExists( GAMedicalSF),FileServices.CreateSuperfile(GAMedicalSF)),
																			 if (  FileServices.SuperFileExists( GAMedicalSF),FileServices.ClearSuperfile( GAMedicalSF)),
																			 FileServices.AddSuperfile( GAMedicalSF,GAMedicalLF),
																			 FileServices.FinishSuperFileTransaction( )
																		);
																			 
																											
	
	sprayGAMed	:=	Sequential(sprayMedFile,addMedSuper);
	
	// Spray All Available
	
	string					AllCSVSeparator				:=	'\t';
	string					AllCSVQuote						:=	'"';
	string          Availdate         := infile(ftype = 'available')[1].fdate;

	string					AllMedicalLF				:=	'~thor_data400::in::prolic::ga::all_available::raw_'+Availdate;
	
	string          AllsourceLZ              := '/data/hds_4/prolic/ga/all_available/'+Availdate+'/';
	string					AllMedicalSF				:=	'~thor_data400::in::prolic::ga::all_available::raw';
	         
	
	
	
	
	sprayAllFile	:=	if(	EXISTS(FileServices.RemoteDirectory(pServer,AllsourceLZ,'*.txt')) and FileServices.FindSuperFileSubName(AllMedicalSF,AllMedicalLF) = 0 ,
	                      Sequential(if (  FileServices.SuperFileExists( AllMedicalSF),FileServices.ClearSuperfile( AllMedicalSF)),

	                              fileservices.sprayvariable(	pServer,
																												AllsourceLZ + '*.txt',
																												 ,
																												AllCSVSeparator,
																												 ,
																												AllCSVQuote,
																										//		_control.TargetGroup.Thor400_20,
																												pGroupName,
																												AllMedicalLF,
																												,,,true,false,false
																											), 
																	output('No GA ALL Available files recieved or GA ALL Available Files were already Sprayed'))); 
																	
		addAllSuper   := Sequential (  FileServices.StartSuperFileTransaction( ),
		                                   if ( NOT FileServices.SuperFileExists( AllMedicalSF),FileServices.CreateSuperfile(AllMedicalSF)),
																			 if (  FileServices.SuperFileExists( AllMedicalSF),FileServices.ClearSuperfile( AllMedicalSF)),
																			 FileServices.AddSuperfile( AllMedicalSF,AllMedicalLF),
																			 FileServices.FinishSuperFileTransaction( )
																		);
																			 
																											
	
	sprayGAAll	:=	Sequential(sprayAllFile,addAllSuper);
	
	//Spray Nurses
	
	string					LPNCSVSeparator				:=	'\t';
	string					LPNCSVQuote						:=	'"';
	string          LPNdate         := infile(ftype = 'nurse')[1].fdate;

	string					LPNMedicalLF				:=	'~thor_data400::in::prolic::ga::nurses::LPN_'+LPNdate;
	
	string          LPNsourceLZ              := '/data/hds_4/prolic/ga/nurses_new/'+LPNdate+'/';
	string					LPNMedicalSF				:=	'~thor_data400::in::prolic::ga::nurses::LPN';
	         
	
	
	
	
	sprayLPNFile	:=	if(	EXISTS(FileServices.RemoteDirectory(pServer,LPNsourceLZ,'Licensed Practical Nurse.txt')) and FileServices.FindSuperFileSubName(LPNMedicalSF,LPNMedicalLF) = 0 ,
                       Sequential( 	if (  FileServices.SuperFileExists( LPNMedicalSF),FileServices.ClearSuperfile( LPNMedicalSF)),

	                              fileservices.sprayvariable(pServer,
																												LPNsourceLZ + 'Licensed Practical Nurse.txt',
																												 ,
																												LPNCSVSeparator,
																												 ,
																												LPNCSVQuote,
																										//		_control.TargetGroup.Thor400_20,
																												pGroupName,
																												LPNMedicalLF,
																												,,,true,false,false
																											), 
																	output('No GA Nurse LPN  files recieved or GA Nurse LPN Files were already Sprayed'))); 
																	
		addLPNSuper   := Sequential (  FileServices.StartSuperFileTransaction( ),
		                                   if ( NOT FileServices.SuperFileExists( LPNMedicalSF),FileServices.CreateSuperfile(LPNMedicalSF)),
																			 FileServices.AddSuperfile( LPNMedicalSF,LPNMedicalLF),
																			 FileServices.FinishSuperFileTransaction( )
																		);
																			 
																											
	
	sprayLPNAll	:=	Sequential(sprayLPNFile,addLPNSuper);
	
	
	
	string					RNCSVSeparator				:=	'\t';
	string					RNCSVQuote						:=	'"';
		string         RNdate         := infile(ftype = 'nurse')[1].fdate;

	string					RNMedicalLF				:=	'~thor_data400::in::prolic::ga::nurses::RN_'+RNdate;
	
	string          RNsourceLZ              := '/data/hds_4/prolic/ga/nurses_new/'+RNdate+'/';
	string					RNMedicalSF				:=	'~thor_data400::in::prolic::ga::nurses::RN';
	         
	
	
	
	
	sprayRNFile	:=	if(	EXISTS(FileServices.RemoteDirectory(pServer,RNsourceLZ,'Registered Professional Nurse.txt')) and FileServices.FindSuperFileSubName(RNMedicalSF,RNMedicalLF) = 0 ,
                     Sequential( 	if (  FileServices.SuperFileExists( RNMedicalSF),FileServices.ClearSuperfile( RNMedicalSF)),

	                              fileservices.sprayvariable(	pServer,
																												RNsourceLZ + 'Registered Professional Nurse.txt',
																												 ,
																												RNCSVSeparator,
																												 ,
																												RNCSVQuote,
																										//		_control.TargetGroup.Thor400_20,
																												pGroupName,
																												RNMedicalLF,
																												,,,true,false,false
																											), 
																	output('No GA Nurse RN  files recieved or GA Nurse RN Files were already Sprayed'))); 
																	
		addRNSuper   := Sequential (  FileServices.StartSuperFileTransaction( ),
		                                   if ( NOT FileServices.SuperFileExists( RNMedicalSF),FileServices.CreateSuperfile(RNMedicalSF)),
																			 FileServices.AddSuperfile( RNMedicalSF,RNMedicallF),
																			 FileServices.FinishSuperFileTransaction( )
																		);
																			 
																											
	
	sprayRNAll	:=	Sequential(sprayRNFile,addRNSuper);
	
	sprayGAnurse := Sequential( sprayLPNAll , sprayRNAll);
	
	

export dospray := map ( count(infile(ftype = 'medical')) = 1 and  count(infile) = 1 => sprayGAMed,
                        count(infile(ftype = 'available')) = 1 and  count(infile) = 1 => sprayGAAll,
												count(infile(ftype =	'nurse')) = 1 and  count(infile) = 1 => sprayGAnurse,
												count(infile(ftype in ['medical','available'])) = 2  and  count(infile) = 2 => Sequential( sprayGAMed , sprayGAAll),
								        count(infile(ftype in ['medical','nurse'])) = 2 and  count(infile) = 2 => Sequential( sprayGAMed , sprayGAnurse),
								        count(infile(ftype in ['nurse','available'])) = 2 and  count(infile) = 2 => Sequential( sprayGAnurse,sprayGAAll),
												    
												Sequential( sprayGAMed,sprayGAAll,sprayGAnurse)
                                      );
																			
end;
                 