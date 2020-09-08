﻿// Header_ops._CRON_Header_IKB_Scheduler
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

import ut,wk_ut,_control,STD, header, dops;
#WORKUNIT('name', 'PersonHeader: Build_Incremental_Keys');

filedate := '20200901';//Header.Proc_Copy_From_Alpha_Incrementals().filedate;
lastestIkbVersionOnThor  := header.Proc_Copy_From_Alpha_Incrementals().lastestIkbVersionOnThor;

valid_state := ['blocked','running','wait','submitted','compiling','compiled'];
ikb_wuname 	:= '*Update Incremental linking keys*';

wks := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=ikb_wuname))(wuid <> thorlib.wuid() and state in valid_state)
		 ,-wuid);

active_wk :=  exists(wks);
sf_name := '~thor_data400::out::header_ikb_status';

ver    := Header.LogBuildStatus(sf_name).GetLatest.versionName;
status := Header.LogBuildStatus(sf_name).GetLatest.versionStatus;

bldversion := if(status <> 9, ver, filedate); // 9 -> Completed

// Get versions for packages from DOPS waiting to be deployed
ver_lab_TBD := Dops.GetBuildVersion('PersonLabKeys'//'PersonLABKeys' // DOPS package name  20190111
                    ,'B' // B - Boca, A - Alpharetta
                    ,'N' // N - Nonfcra, F - FCRA, S - Customer Supp, T - Customer Test, FS - FCRA Cust Support
                    ,'T' // C - Cert, P - Prod, T - Thor
                    ,dops.constants.dopsenvironment
                    );
ver_lab_cert_ver := dops.GetBuildVersion('PersonLabKeys','B','N','C')[1..9];
                 

norun := if(filedate = lastestIkbVersionOnThor and status = 9
          ,true   //norun
          ,if(ver_lab_TBD <> ver_lab_cert_ver
          ,true   //norun
          ,false
          ));

// norun := false;          
          
wuname1 := filedate + ' IKB - Running Right Now';
wuname2 := filedate + ' IKB - Data Was Already Built';
wuname3 := bldversion + if(status <> 9, ' IKB - Update Incremental linking keys RECOVER', ' IKB - Update Incremental linking keys');

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
+'build_ikb := header_ops.hdr_bld_ikb(\'' + bldversion + '\',' + if(status = 9, 0, status) + ').all;\n\n'
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