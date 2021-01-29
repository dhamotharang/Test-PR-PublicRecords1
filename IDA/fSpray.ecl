import lib_fileservices,_control,lib_stringlib,Versioncontrol,std,tools;


export fSpray(boolean pUseProd = false) := MODULE

version:=IDA._Constants(pUseProd).filesdate;

// RD:=STD.File.RemoteDirectory(IDA._Constants(pUseProd).Source_IP,IDA._Constants(pUseProd).spray_path );
// RDF:=RD[1];
RD:=IDA._Constants(false).RD;
RDF:=IDA._Constants(false).RDF;



tools.Layout_Sprays.Info xForm(recordof(RDF) L) := transform
			self:=row(
								{	 
								 IDA._Constants(pUseProd).Source_IP				
								,IDA._Constants(pUseProd).spray_path                        
								,L.name                                  
								,0
								,IDA.Filenames(version,pUseProd).lInputTemplate
								,[{IDA.Filenames(version,pUseProd).lInputTemplate_built}] 
								,'thor400_dev01'                                              
								,REGEXFIND('[0-9]{8}'+'_'+'[0-9]{6}',L.name,0)                                             
								,'[0-9]{8}'+'_'+'[0-9]{6}'                                                          
								,'VARIABLE'                                                         
								,''
								,''
								,'|'
								,''               //'\\n,\\r\\n'
								,','                     //''
								,true
								}
								,tools.Layout_Sprays.Info);
																
	end;
	
toSpray:=project(RDF, xForm(left));
toSpray;

sprayds:=DATASET(toSpray);

Spray := VersionControl.fSprayInputFiles(sprayds,pOverwrite:=true,pIsTesting:=FALSE,pShouldClearSuperfileFirst:= true);

PrepSuper := SEQUENTIAL(STD.File.StartSuperFileTransaction()
	                     ,STD.File.ClearSuperfile(TRIM(IDA.Filenames(version,pUseProd).lInputTemplate_built))
	              	     ,STD.File.ClearSuperfile(TRIM(IDA.Filenames(version,pUseProd).lInputTemplate_qa))
	 					 ,STD.File.addsuperfile(TRIM(IDA.Filenames(version,pUseProd).lInputTemplate_qa),TRIM(IDA.Filenames(version,pUseProd).lInputTemplate_built),,TRUE)
						 ,STD.File.ClearSuperfile(TRIM(IDA.Filenames(version,pUseProd).lInputTemplate_father))
						 ,STD.File.addsuperfile(TRIM(IDA.Filenames(version,pUseProd).lInputTemplate_father),TRIM(IDA.Filenames(version,pUseProd).lInputTemplate_qa),,TRUE)
						 ,STD.File.ClearSuperfile(TRIM(IDA.Filenames(version,pUseProd).lInputTemplate_delete),true)
						 ,STD.File.addsuperfile(TRIM(IDA.Filenames(version,pUseProd).lInputTemplate_delete),TRIM(IDA.Filenames(version,pUseProd).lInputTemplate_father),,TRUE)	
   						 ,STD.File.FinishSuperFileTransaction());
											 
EXPORT _spray:=if(EXISTS(RD),SEQUENTIAL(PrepSuper,Spray));
											 
end;