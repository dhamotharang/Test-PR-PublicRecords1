import std,ut,Orbit3,_Control;
export Proc_Orbit3_CreateBuild(string buildname,string Buildvs,string Envmt = 'N', string email_list = '', boolean skipcreatebuild = false,boolean skipupdatebuild = false,boolean runcreatebuild = true) := function

ECL1 := '#workunit(\'name\',\'Orbit Create Build Instance'+ buildname + '-- '+Buildvs+'\');\r\n'+
		 'Orbit3.proc_Orbit3_CreateBuild_sp( \''+buildname+'\',  \''+Buildvs+'\', \''+Envmt+'\', \''+email_list+'\', '+skipcreatebuild+', '+skipupdatebuild+', '+runcreatebuild+') \n' 
		+'	  : success(Orbit3.Send_Email(\''+Buildvs+'\', \''+email_list+'\').build_success)\n'
          +'	, failure(Orbit3.Send_Email(\''+Buildvs+'\', \''+email_list+'\').build_failure)\n'
           +'	;\n';

	tgtcluster := STD.System.Job.Target();

spcluster := if ( regexfind('_eclcc',tgtcluster) , 'hthor_eclcc','hthor');


    fswu :=  _control.fSubmitNewWorkunit(ECL1, spcluster) :   SUCCESS(fileservices.sendemail(Send_Email(Buildvs,email_list).emaillist
																			                                                                                                     ,'Orbit3  submit WU to spawn status'+ workunit
																			                                                                                                      ,'Orbit3 submit WU to spawn success -- '+ workunit
																			                                                                                                       )),
		                                                                                                                                                                                      FAILURE(fileservices.sendemail(Send_Email(Buildvs,email_list).emaillist
																			                                                                                                     ,'Orbit3 submit WU to spawn status'+ workunit
																			                                                                                                      ,'Orbit3 submit WU to spawn failed -- '+ workunit
																			                                                                                                       ));
return 	fswu;
end;