import lib_fileservices,_control,lib_stringlib;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// Spray all states data residing in a dated folder.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 spray_raw_data(string filedate)	:=	function
       
		do_spray								:=	FileServices.SprayVariable(_control.IPAddress.bctlpedata11
												   ,'/data/hds_180/SIM/Diversity_Certification/data/'+filedate+'/*.txt'
												   ,_Dataset().max_record_size
												   ,'|'
												   ,'\\n,\\r\\n'     
												   ,'[\'\']'
												   ,'thor400_44'
												   ,cluster+'in::Diversity_Certification::'+filedate+'::allStates_Data'
												   ,-1
												   ,
												   ,
												   ,true
												   ,
												   ,true);
		check_raw	:= 	if(NOT FileServices.FileExists(cluster+'in::Diversity_Certification::'+filedate+'::allStates_Data')
							,do_spray
						  );							 
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// Note: Check to see if  sprayed file is already in superfile
///// If sprayed file is present remove sprayed file from subsuperfile and respray and add to superfile again.                                                         
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		doSeq:= sequential(  	if(fileservices.findsuperfilesubname(Diversity_Certification.Filenames().Input.sprayed, cluster+'in::Diversity_Certification::'+filedate+'::allStates_Data') > 0
									,FileServices.ClearSuperFile(Diversity_Certification.Filenames().Input.sprayed,true)
									)
								 ,if(fileservices.findsuperfilesubname(Diversity_Certification.Filenames().Input.using, cluster+'in::Diversity_Certification::'+filedate+'::allStates_Data') > 0
									,FileServices.ClearSuperFile(Diversity_Certification.Filenames().Input.using,true)
									)
								,if(fileservices.findsuperfilesubname(Diversity_Certification.Filenames().Input.used, cluster+'in::Diversity_Certification::'+filedate+'::allStates_Data') > 0
									,FileServices.ClearSuperFile(Diversity_Certification.Filenames().Input.used,true)
								   )
								,check_raw
							  );							 
		return doSeq;
end;
export fSprayFiles(string filedate)	:=	function
	
			CreateSuperfile1		:=	FileServices.CreateSuperFile(Diversity_Certification.Filenames().Input.Sprayed,false);
								
			CreateSuperIfNotExist1	:= 	if(NOT FileServices.SuperFileExists(Diversity_Certification.Filenames().Input.Sprayed),CreateSuperfile1); 
			
			CreateSuperfile2		:=	FileServices.CreateSuperFile(Diversity_Certification.Filenames().Input.using,false);
								
			CreateSuperIfNotExist2	:= 	if(NOT FileServices.SuperFileExists(Diversity_Certification.Filenames().Input.using),CreateSuperfile2); 
			
			CreateSuperfile3		:=	FileServices.CreateSuperFile(Diversity_Certification.Filenames().Input.used,false);
								
			CreateSuperIfNotExist3	:= 	if(NOT FileServices.SuperFileExists(Diversity_Certification.Filenames().Input.used),CreateSuperfile3); 
			super_main				:= sequential(	FileServices.StartSuperFileTransaction(),
													FileServices.AddSuperFile(Diversity_Certification.Filenames().Input.Sprayed, 
																			cluster+'in::Diversity_Certification::'+filedate+'::allStates_Data'), 
																			FileServices.FinishSuperFileTransaction()
												 );
									 
			add_super				:= if(FileServices.FindSuperFileSubName(Diversity_Certification.Filenames().Input.Sprayed, cluster+'in::Diversity_Certification::'+filedate+'::allStates_Data') = 0,
																			super_main
													 ); 
			
			do_super				:= sequential(  CreateSuperIfNotExist1
												   ,CreateSuperIfNotExist2
												   ,CreateSuperIfNotExist3
												   ,spray_raw_data(filedate)
												   ,add_super
												);

			return do_super;

end;	