﻿envVars :=
'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'#STORED (\'_Validate_Year_Range_Low\', \'1800\');\n'
+'#STORED (\'_Validate_Year_Range_high\', ut.GetDate[1..4]);\n'
+'wuname := \'NAC Contributory Pilot\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
;


STRING ProcessRecipient := MOD_InternalEmailsList.fn_GetInternalRecipients('Preprocess Error','');



lECL1 :=
envVars
+'email(string msg):=fileservices.sendemail(\n'
+'   \'' + ProcessRecipient +     '\'\n'
+'																					,\'NAC Build\'\n'
+'																					,msg\n'
+'																					+\'Build wuid \'+workunit\n'
+'																					);\n\n'
+'valid_state := [\'blocked\',\'running\',\'wait\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',,,wuname,\'\'))(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'version:=ut.GetDate : independent;\n'
+'if(active_workunit\n'
+'		,email(\'**** ALERT - Workunit \'+d_wu+\' in Wait, Queued, or Running *******\')\n'
+'		,sequential(email(\'NAC Build Started\\n\'),NAC.BWR_Build_NAC(version,NAC.Constants.LandingZoneServer,NAC.Constants.LandingZonePathBaseEx),NAC_V2.fn_Base2_from_Base1(version))\n'
+'	)\n'
+'	: success(NAC.Send_Email(Version).Build_Success)\n'
+'	, failure(NAC.Send_Email(Version).Build_Failure)\n'
+'	;\n'
+'// Estimated THOR time: 1Hrs\n'
;

import _Control;
ThorName := 'thor400_44_sla_eclcc';

// NOTE: Ssystem time is standard time + 5; therefore, Sunday at 10 PM is actually Monday 3 AM
#WORKUNIT('name', 'S-K NAC Contributory Build');
Sun_thru_Thur_at_10_PM:='0 3 * * 1-5';
_Control.fSubmitNewWorkunit(lECL1, ThorName ) : WHEN(CRON(Sun_thru_Thur_at_10_PM))
