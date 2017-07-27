
import lib_fileservices,_control,lib_stringlib;


 SprayRawFiles(string filename,string fileDate):=function

 shared spray:= FileServices.SprayVariable(_control.IPAddress.edata12
												   ,'/hds_180/SIM/ECRulings/'+filedate+'/*'+filename+'.txt'
												   ,
												   ,'|'
												   ,'\\n,\\r\\n',
												   ,'thor400_92'
												   ,ECRulings.Cluster + 'in::ECRulings::'+fileDate+'::allsrc_'+filename
												   ,-1
												   ,
												   ,
												  ,true
												   ,
												   ,true);						   		
shared  CreateSuperfiles :=FileServices.CreateSuperFile(ECRulings.Cluster + 'raw_base::ECRulings_'+filename,false);
								
shared CreateSuperIfNotExist := if(NOT FileServices.SuperFileExists(ECRulings.Cluster + 'raw_base::ECRulings_'+filename),CreateSuperfiles); 

shared spray_main :=if(NOT FileServices.FileExists(ECRulings.Cluster + 'in::ECRulings::'+fileDate+'::allsrc_'+filename),spray);

shared  super_main :=sequential(FileServices.AddSuperFile(ECRulings.Cluster + 'raw_base::ECRulings_'+filename, 
				                         ECRulings.Cluster + 'in::ECRulings::'+fileDate+'::Allsrc_'+filename));

shared  add_super := if(FileServices.FindSuperFileSubName(ECRulings.Cluster + 'raw_base::ECRulings_'+filename, ECRulings.Cluster + 'in::ECRulings::'+fileDate+'::Allsrc_'+filename) = 0,super_main); 

return sequential(CreateSuperIfNotExist,spray_main,add_super);
end;



export fSprayFiles(string filedate):=function

			allFiles_spray :=  sequential (	if(FileServices.SuperFileExists('~thor_data400::raw_base::ecrulings_competition'), FileServices.ClearSuperFile('~thor_data400::raw_base::ecrulings_competition',TRUE))
											,if(FileServices.SuperFileExists('~thor_data400::raw_base::ecrulings_decisionpublication'),FileServices.ClearSuperFile('~thor_data400::raw_base::ecrulings_decisionpublication',TRUE))
											,if(FileServices.SuperFileExists('~thor_data400::raw_base::ecrulings_economicactivity'),FileServices.ClearSuperFile('~thor_data400::raw_base::ecrulings_economicactivity',TRUE))
											,if(FileServices.SuperFileExists('~thor_data400::raw_base::ecrulings_eventdocument'),FileServices.ClearSuperFile('~thor_data400::raw_base::ecrulings_eventdocument',TRUE))
											,SprayRawFiles('Competition',filedate)
											,SprayRawFiles('DecisionPublication',filedate)	
											,SprayRawFiles('EconomicActivity',filedate)
											,SprayRawFiles('EventDocument',filedate));
											
				return allFiles_spray;
				
											
	end;