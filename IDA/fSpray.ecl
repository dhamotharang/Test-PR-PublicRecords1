import lib_fileservices,_control,lib_stringlib,Versioncontrol,std,tools;


export fSpray(string pversion='', boolean pUseProd = false) := MODULE

version:=if(pversion='',(string8)std.date.today(),pversion):INDEPENDENT;

RD:=STD.File.RemoteDirectory(IDA._Constants(version,pUseProd).Source_IP,IDA._Constants(version,pUseProd).spray_path );

tools.Layout_Sprays.Info xForm(RD L) := transform
			self:=row(
								{	 
								 IDA._Constants(version,pUseProd).Source_IP				
								,IDA._Constants(version,pUseProd).spray_path                        
								,L.name                                      
								,0
								,IDA.Filenames(version,pUseProd).lInputTemplate
								,[{IDA.Filenames(version,pUseProd).lInputTemplate_built}] 
								,'thor400_dev01'                                              
								,version                                                     
								,'[0-9]{8}'                                                            
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
	
toSpray:=project(RD, xForm(left));
	
Spray := VersionControl.fSprayInputFiles(toSpray,pOverwrite:=true,pIsTesting:=FALSE,pShouldClearSuperfileFirst:= true);

MoveToDone:=nothor(apply(RD,STD.File.MoveExternalFile(IDA._Constants(version,pUseProd).Source_IP, IDA._Constants(version,pUseProd).spray_path + name, IDA._Constants(version,pUseProd).done_path + name)));

PrepSuper := SEQUENTIAL(STD.File.StartSuperFileTransaction()
	                     ,STD.File.ClearSuperfile(TRIM(IDA.Filenames(version,pUseProd).lInputTemplate_built))
	              	     ,STD.File.ClearSuperfile(TRIM(IDA.Filenames(version,pUseProd).lInputTemplate_qa))
	 								     ,STD.File.addsuperfile(TRIM(IDA.Filenames(version,pUseProd).lInputTemplate_qa),TRIM(IDA.Filenames(version,pUseProd).lInputTemplate_built),,TRUE)
									     ,STD.File.ClearSuperfile(TRIM(IDA.Filenames(version,pUseProd).lInputTemplate_father))
									     ,STD.File.addsuperfile(TRIM(IDA.Filenames(version,pUseProd).lInputTemplate_father),TRIM(IDA.Filenames(version,pUseProd).lInputTemplate_qa),,TRUE)
								    	 ,STD.File.ClearSuperfile(TRIM(IDA.Filenames(version,pUseProd).lInputTemplate_delete),true)
									     ,STD.File.addsuperfile(TRIM(IDA.Filenames(version,pUseProd).lInputTemplate_delete),TRIM(IDA.Filenames(version,pUseProd).lInputTemplate_father),,TRUE)	
   										 ,STD.File.FinishSuperFileTransaction());
											 
EXPORT _spray:=if(EXISTS(rd),SEQUENTIAL(PrepSuper,Spray,MoveToDone));
											 
end;