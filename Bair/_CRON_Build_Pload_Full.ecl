// Bair._CRON_Build_Pload_Full
// scheduler job name -> Bair Full Build All Scheduler
// queued job name -> Bair Full Build All
// ON_NOTIFY: Bair Build All Scheduler
	// Build payload full
// Expected execution time -> 2-3 hours

import ut,wk_ut,std;

BldChkPt		:= dataset(Bair.Superfile_List(false).BldChkPt, {unsigned1 pos}, flat, opt);
ChkPtPos		:= BldChkPt[1].pos;
rec_lastBld	:= if(ChkPtPos < 12, true, false);

reprocess 	:= if(rec_lastBld,'true','false');

PrevFull 		:= dataset(bair.Superfile_List(false).BuiltVers, bair.layouts.rBuiltVers, flat);
CurDelta 		:= dataset(bair.Superfile_List(true).BuiltVers, bair.layouts.rBuiltVers, flat);

build_name     := 'bair_pload_full';
build_version  := if(rec_lastBld, PrevFull[1].ver, CurDelta[1].ver + 'w');

ECL0 :=
 'wunameF := \'Bair Full Build All*?\';\n'
+'wunameBLF := \'Bair BOOLEAN Full Build and Deploy*?\';\n'
+'wunameCF := \'Bair COMPOSITE Full Build and Deploy*?\';\n'
+'wunameException := [\'Bair Build All Monitor\',\'Bair Full Build All Controller\',\'Bair Full Build All Scheduler\'];\n'
+'valid_state := [\'blocked\',\'running\',\'wait\',\'submitted\',\'compiling\',\'compiled\'];\n'

+'dupdwusF := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wunameF))(wuid <> thorlib.wuid() and state in valid_state and job not in wunameException), -wuid);\n'
+'dupdwusBLF := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wunameBLF))(wuid <> thorlib.wuid() and state in valid_state and job not in wunameException), -wuid);\n'
+'dupdwusCF := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wunameCF))(wuid <> thorlib.wuid() and state in valid_state and job not in wunameException), -wuid);\n'

+'d := dupdwusF+ dupdwusBLF+ dupdwusCF;\n'
+'active_workunit :=  exists(d);\n'
;

ECL:=
 '//Bair._CRON_Build_Pload_Full\n'
+'//scheduler job nane -> Bair Full Build All Scheduler\n'
+'//queued job nane -> Bair Full Build All\n'
+'//ON_NOTIFY: Bair Full Build All Scheduler\n'
+'// Build payload delta\n'
+'// Expected execution time -> 2-3 hours\n'
+'\n'
+ECL0
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#stored(\'did_add_force\',\'thor\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'
+'pUseProd 	:= false;\n'
+'\n'

+'wuname := \'Bair Full Build All \'+\'' + build_version + '\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'\n'
+'building        := if(active_workunit = false, Bair.Build_All(\''+build_name+'\',\''+build_version+'\', pUseProd,false,'+reprocess+'));\n'
+'building;\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Full Build All Scheduler');
wk_ut.CreateWuid(ECL,'thor40',Bair._ESP):
													WHEN('Bair Full Build All Scheduler')
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Full Build All Scheduler Failure'
													,Bair.email_msg(workunit).NOC_MSG
													));