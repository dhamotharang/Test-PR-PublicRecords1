envVars :=
 '#STORED (\'_Validate_Year_Range_Low\', \'1900\');\n'
+'#STORED (\'_Validate_Year_Range_high\', ut.GetDate[1..4]);\n'
+'wuname := \'Delta\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#stored(\'did_add_force\',\'thor\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n\n'
;

r:={ string version, string5 useprod, string5 usedelta };
parms := sort(dataset('~thor_data400::out::Bair_parms',r,flat),version);
pversion := parms[1].version;
pUseProd := parms[1].UseProd;
pUseDelta := parms[1].UseDelta;

ECL:=
envVars
+ 'bair_files :=fileservices.LogicalFileList(\'*in*bair*temp\',false,true);\n'
+ 't1:=table(bair_files,{p1:=\'~\'+regexreplace(\'::temp\',name,\'\'),p2:=fileservices.GetSuperFileSubName(\'~\'+name,1,true)})(p2<>\'\');\n'
+ 't := t1(regexfind(\'(bair::event::dbo::data_provider)|(bair::event::dbo::vehicle)|(bair::event::dbo::mo)|(bair::event::dbo::persons)|(bair::lpr::dbo::licenseplateevent)|(bair::cfs::dbo::cfs)\', p2) = true);\n'
+ 'moveinputfiles := sequential(\n'
+ '										apply(t,fileservices.AddSuperFile(p1,p2))//move temp to in\n'
+ '										,apply(t,fileservices.AddSuperFile(p1+\'::history\',p2))//move temp to history\n'
+ '										,apply(t,fileservices.RemoveSuperFile(p1+\'::temp\',p2))//remove from history\n'
+ '									);\n'
+'r:={ string version, string5 useprod, string5 usedelta };\n'
+'parms := sort(dataset(\'~thor_data400::out::Bair_parms\',r,flat),version);\n'
+'ut.MAC_SF_BuildProcess(parms(version<>\''+pversion+'\'),\'~thor_data400::out::Bair_parms\', PostIt ,2,,true);\n\n'
+'email(string msg):=fileservices.sendemail(\n'
+'																					\'jose.bello@lexisnexis.com,debendra.kumar@lexisnexis.com\'\n'
+'																					,\'Bair Build\'\n'
+'																					,msg\n'
+'																					+\'Build wuid \'+workunit\n'
+'																					);\n\n'
+'valid_state := [\'blocked\',\'running\',\'wait\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',,,wuname,\'\'))(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'if(active_workunit\n'
+'		,email(\'**** ALERT - Workunit \'+d_wu+\' in Wait, Queued, or Running *******\')\n'
+'    ,sequential(\n'
+'					bair.Build_all(\''+pversion+'\','+pUseProd+','+pUseDelta+')\n'
+'					,PostIt\n'
+'					,nothor(moveinputfiles)\n'
+'					,notify(\'build_next\',\'*\')\n'
+'        	)\n'
+'   )\n'
+'	: success(Bair.Send_Email(\''+pversion+'\').BuildSuccess)\n'
+'	, failure(Bair.Send_Email(\''+pversion+'\').BuildFailure)\n'
+'	;\n'
+'// Estimated THOR time: 1Hrs\n'
;

ESP:='10.239.228.3';
THOR:='thor228_20';
import wk_ut;
#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Contributory Build catch-up');
wk_ut.CreateWuid(ECL,THOR,ESP) : WHEN('build_next')
														,FAILURE(fileservices.sendemail('jose.bello@lexisnexis.com,debendra.kumar@lexisnexis.com'
																		,'Bair Contributory Build schedule failure'
																		,'schedule failure\n'
																		+'schedule failure\n'
																		+'See '+workunit+'\n\n'
																		+FAILMESSAGE
																		));