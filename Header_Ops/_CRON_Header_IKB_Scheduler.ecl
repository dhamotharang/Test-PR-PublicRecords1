// Header_ops._CRON_Header_IKB_Scheduler
// scheduler job name -> Header IKB Scheduler
// ON_NOTIFY: Header_Ops.hdr_bld_ikb
	// Get the FILEDATE of the last built INC LAB keys in ALPHA
	// Copy the LAB keys from Alpha to Boca
	// Update the INC IDL superfile
    // Build IDL and FCRA Keys
    // Move the keys to QA superfile
    // Create and Update Orbit entries for PersonXLAB_Inc, FCRA_Header and Header_IKB
    // Deploy PersonLabKeys, PersonHeaderWeeklyKeys, FCRA_PersonHeaderKeys packages
    
// Expected execution time -> Estimated around 6 hrs

import ut,wk_ut,_control,STD, header;
#WORKUNIT('name', 'PersonHeader: Build_Incremental_Keys');

filedate := Header.Proc_Copy_From_Alpha_Incrementals().filedate;
lastestIkbVersionOnThor  := header.Proc_Copy_From_Alpha_Incrementals().lastestIkbVersionOnThor;

valid_state := ['blocked','running','wait','submitted','compiling','compiled'];
ikb_wuname 	:= '*Update Incremental linking keys*';

wks := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=ikb_wuname))(wuid <> thorlib.wuid() and state in valid_state)
		 ,-wuid);
active_wk :=  exists(wks);

sf_name := '~thor_data400::out::header_ikb_status';
ver    := Header.LogBuildStatus(sf_name).Read[1].version;
status := Header.LogBuildStatus(sf_name).Read[1].status;
bldversion := if(status <> 0, ver, filedate); // 0 -> Completed

norun := if(filedate = lastestIkbVersionOnThor and status = 0, true, false);

wuname1 := filedate + ' IKB - Running Right Now';
wuname2 := filedate + ' IKB - Data Was Already Built';
wuname3 := bldversion + if(status <> 0, ' IKB - RECOVER Update Incremental linking keys', ' IKB - Update Incremental linking keys');

ECL1 := '\n'
+'#WORKUNIT(\'name\',\'' + wuname1 + '\');\n'
;

ECL2 := '\n'
+'#WORKUNIT(\'name\',\'' + wuname2 + '\');\n'
;

ECL3 := '\n'
+'#WORKUNIT(\'name\',\'' + wuname3 + '\');\n'
+'#stored (\'buildname\', \'header_incremental_keys\');\n'
+'#WORKUNIT(\'protect\',true);\n\n'

+'import Header, header_ops;\n\n'
+'build_ikb := header_ops.hdr_bld_ikb(\'' + bldversion + '\',' + status + ').all;\n\n'
+'build_ikb;';

ECL := if(active_wk
          ,ECL1
          ,if(norun, ECL2, ECL3)
         );

THOR := 'thor400_44_eclcc';

#WORKUNIT('protect',true);
wk_ut.CreateWuid(ECL,THOR,wk_ut._constants.ProdEsp) : when('Build_Incremental_Keys')
                             ,SUCCESS(fileservices.sendemail(Header.email_list.BocaDevelopers
                                ,'IKB BUILD - SEE ' + workunit
                                ,ECL
                            ));