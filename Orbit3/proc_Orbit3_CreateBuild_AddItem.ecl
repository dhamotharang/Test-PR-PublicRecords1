﻿import  ut,_Control,STD;
export proc_Orbit3_CreateBuild_AddItem(string buildname,string Buildvs,string Envmt = 'N',  string email_list = '', string BuildStatus = 'BUILD_AVAILABLE_FOR_USE', boolean skipcreatebuild = false,boolean skipupdatebuild = false, boolean skipaddcomponents = false, boolean runcreatebuild = true, boolean runaddcomponentsonly = false,boolean is_npf = false) := function

string wuid := workunit;




ECL1 := '#workunit(\'name\',\'Orbit Create Build Instance and Add Items -- '+ buildname + '-- '+Buildvs+'\');\r\n'+
'Orbit3.proc_Orbit3_CreateBuild_AddItem_sp( \''+buildname+'\', \''+Buildvs+'\', \''+Envmt+'\',  \''+email_list+'\', \''+BuildStatus+'\', '+if (skipcreatebuild , 'true','false')+ ','
+ if (skipupdatebuild , 'true','false')+','
+ if (skipaddcomponents , 'true','false')+','
+if (runcreatebuild, 'true','false') +','
+if (runaddcomponentsonly, 'true','false') +','
+if (is_npf,'true','false')+' , \''+wuid+'\') \n'
+' : success(Orbit3.Send_Email(\''+Buildvs+'\', \''+email_list+'\', \''+buildname+'\', \''+Buildvs+'\' ).build_success)\n'
+' , failure(Orbit3.Send_Email(\''+Buildvs+'\', \''+email_list+'\', \''+buildname+'\', \''+Buildvs+'\').build_failure)\n'
+' ;\n';

	tgtcluster := STD.System.Job.Target();

spcluster := map  ( regexfind('_eclcc',tgtcluster)  and _Control.ThisEnvironment.Name = 'Dataland'  => 'hthor_dev_eclcc',
                                 regexfind('_eclcc',tgtcluster)  and _Control.ThisEnvironment.Name <> 'Dataland'  => 'hthor_eclcc',
                                   regexfind('_eclcc',tgtcluster)  = false and _Control.ThisEnvironment.Name = 'Dataland'       =>  'hthor_dev',
							 'hthor'									 );

    fswu :=  _control.fSubmitNewWorkunit(ECL1, trim(spcluster)) :   SUCCESS(fileservices.sendemail(Orbit3.Send_Email(Buildvs,email_list,buildname,Buildvs ).emaillist
																			                                                                                                     ,'Orbit3  submit WU to spawn status -- '+ workunit + '  ,  ' +
																																												   ' Build Name : ' +buildname +  ' , ' +
																																												   ' Build vs : ' +Buildvs
																			                                                                                                      ,'Orbit3 submit WU to spawn success -- '+ workunit +  '  ,  ' +
																																												   ' Build Name : ' +buildname +   ' , ' +
																																												   ' Build vs : ' +Buildvs
																			                                                                                                       )),
		                                                                                                                                                                                      FAILURE(fileservices.sendemail(Orbit3.Send_Email(Buildvs,email_list,buildname,Buildvs ).emaillist
																			                                                                                                     ,'Orbit3 submit WU to spawn status -- '+ workunit +   '  ,  ' +
																																												 ' Build Name : ' +buildname +  ',' +
																																												 ' Build vs : ' +Buildvs
																			                                                                                                      ,'Orbit3 submit WU to spawn failed - - '+ workunit + ' ,  ' +
																																												  ' Build Name : ' +buildname + ','+
																																												  ' Build vs : '+Buildvs
																			                                                                                                       ));
return    evaluate(fswu);
end;