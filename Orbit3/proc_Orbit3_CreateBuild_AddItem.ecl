import  ut,_Control,STD;
export proc_Orbit3_CreateBuild_AddItem(string buildname,string Buildvs,string Envmt = 'N',  boolean skipcreatebuild = false,boolean skipupdatebuild = false, boolean skipaddcomponents = false, boolean runcreatebuild = true, boolean runaddcomponentsonly = false,string email_list = '',boolean is_npf = false) := function

string wuid := workunit;

 boolean skipcreatebuild_sp := skipcreatebuild;
boolean skipupdatebuild_sp := skipupdatebuild;
boolean skipaddcomponents_sp := skipaddcomponents;
boolean runcreatebuild_sp := runcreatebuild;
boolean runaddcomponentsonly_sp := runaddcomponentsonly;
boolean is_npf_sp := is_npf;


ECL1 := '#workunit(\'name\',\'Orbit4 Create Build Instance and Add Items -- '+ buildname + '-- '+Buildvs+'\');\r\n'+
		   'Orbit3.proc_Orbit3_CreateBuild_AddItem_sp( \''+buildname+'\',  \''+Buildvs+'\', \''+Envmt+'\',\''+email_list+'\', '+skipcreatebuild_sp+',  '+skipupdatebuild_sp+' , '+skipaddcomponents_sp+' , '+runcreatebuild_sp+' , '+runaddcomponentsonly_sp+' ,'+is_npf_sp+'  ,  \''+wuid+'\')\n' 
		+'	  : success(Orbit3.Send_Email(\''+Buildvs+'\', \''+email_list+'\').build_success)\n'
          +'	, failure(Orbit3.Send_Email(\''+Buildvs+'\', \''+email_list+'\').build_failure)\n'
           +'	;\n';																															  

tgtcluster := STD.System.Job.Target();

spcluster := map  ( regexfind('_eclcc',tgtcluster)  and _Control.ThisEnvironment.Name = 'Dataland'  => 'hthor_dev_eclcc',
                                 regexfind('_eclcc',tgtcluster)  and _Control.ThisEnvironment.Name <> 'Dataland'  => 'hthor_eclcc',
                                   regexfind('_eclcc',tgtcluster)  = false and _Control.ThisEnvironment.Name = 'Dataland'       =>  'hthor_dev',
							 'hthor'									 );

fswu :=   _control.fSubmitNewWorkunit(ECL1 ,trim(spcluster)) :   SUCCESS(fileservices.sendemail(Send_Email(Buildvs,email_list).emaillist
																			                                                                                                     ,'Orbit4 submit WU to spawn status'+ workunit
																			                                                                                                      ,'Orbit4 submit WU to spawn success -- '+ workunit
																			                                                                                                       )),
		                                                                                                                                                                                      FAILURE(fileservices.sendemail(Send_Email(Buildvs,email_list).emaillist
																			                                                                                                     ,'Orbit4 submit WU to spawn status'+ workunit
																			                                                                                                      ,'Orbit4 submit WU to spawn failed -- '+ workunit
																			                                                                                                       ));
																																																																						 
																																																											
return evaluate(fswu);
	
end;