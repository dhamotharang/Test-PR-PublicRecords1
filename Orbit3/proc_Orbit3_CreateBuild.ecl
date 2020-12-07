﻿/*2019-01-12T01:11:26Z (Kasavajjala, Sudhir (RIS-BCT))

*/
import std,ut,Orbit4,_Control;
export Proc_Orbit3_CreateBuild(string buildname,string Buildvs,string Envmt = 'N',string email_list = '',string BuildStatus = 'BUILD_AVAILABLE_FOR_USE', boolean skipcreatebuild = false,boolean skipupdatebuild = false,boolean runcreatebuild = true, boolean is_npf = false) := function

string wuid := workunit;




ECL1 := '#workunit(\'name\',\'Orbit Create Build Instance -- '+ buildname + '-- '+Buildvs+'\');\r\n'+
'Orbit4.proc_Orbit4_CreateBuild_sp( \''+buildname+'\', \''+Buildvs+'\', \''+Envmt+'\', \''+BuildStatus+'\', \''+email_list+'\', '+if (skipcreatebuild , 'true','false')+ ','
+ if (skipupdatebuild , 'true','false')+','
+if (runcreatebuild, 'true','false') +','
+if (is_npf,'true','false')+' , \''+wuid+'\') \n'
+' : success(Orbit4.Send_Email(\''+Buildvs+'\', \''+email_list+'\', \''+buildname+'\', \''+Buildvs+'\' ).build_success)\n'
+' , failure(Orbit4.Send_Email(\''+Buildvs+'\', \''+email_list+'\', \''+buildname+'\', \''+Buildvs+'\').build_failure)\n'
+' ;\n';

	tgtcluster := STD.System.Job.Target();

spcluster := map  ( regexfind('_eclcc',tgtcluster)  and _Control.ThisEnvironment.Name = 'Dataland'  => 'hthor_dev_eclcc',
                                 regexfind('_eclcc',tgtcluster)  and _Control.ThisEnvironment.Name <> 'Dataland'  => 'hthor_eclcc',
                                   regexfind('_eclcc',tgtcluster)  = false and _Control.ThisEnvironment.Name = 'Dataland'       =>  'hthor_dev',
							 'hthor'									 );

    fswu :=  _control.fSubmitNewWorkunit(ECL1, trim(spcluster)) :   SUCCESS(fileservices.sendemail(Orbit4.Send_Email(Buildvs,email_list,buildname,Buildvs ).emaillist
																			                                                                                                     ,'Orbit4  submit WU to spawn status -- '+ workunit + '  ,  ' +
																																												   ' Build Name : ' +buildname +  ' , ' +
																																												   ' Build vs : ' +Buildvs
																			                                                                                                      ,'Orbit4 submit WU to spawn success -- '+ workunit +  '  ,  ' +
																																												   ' Build Name : ' +buildname +   ' , ' +
																																												   ' Build vs : ' +Buildvs
																			                                                                                                       )),
		                                                                                                                                                                                      FAILURE(fileservices.sendemail(Orbit4.Send_Email(Buildvs,email_list,buildname,Buildvs ).emaillist
																			                                                                                                     ,'Orbit4 submit WU to spawn status -- '+ workunit +   '  ,  ' +
																																												 ' Build Name : ' +buildname +  ',' +
																																												 ' Build vs : ' +Buildvs
																			                                                                                                      ,'Orbit4 submit WU to spawn failed - - '+ workunit + ' ,  ' +
																																												  ' Build Name : ' +buildname + ','+
																																												  ' Build vs : '+Buildvs
																			                                                                                                       ));
return    evaluate(fswu);
end;