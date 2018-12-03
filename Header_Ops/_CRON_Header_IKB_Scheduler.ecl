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
#WORKUNIT('name', 'IKB FCRA Build Scheduler');

filedate:=Header.Proc_Copy_From_Alpha_Incrementals().filedate;

ECL := '\n'
+'#WORKUNIT(\'name\',\'' + filedate + ' Update Incremental linking keys\');\n'
+'#stored (\'buildname\', \'header_incremental_keys\');\n'
+'#WORKUNIT(\'protect\',true);\n\n'

+'import Header, header_ops;\n\n'
+'build_ikb := sequential(\n'
+'              header.LogBuild.single(\'STARTED:IKB BUILD\'),\n'
+'              header_ops.hdr_bld_ikb(\'' + filedate + '\').all,\n'
+'              header.LogBuild.single(\'END:IKB BUILD\')\n'
+'             );\n\n'
+'build_ikb;';

THOR := 'thor400_44_eclcc';

#WORKUNIT('protect',true);
wk_ut.CreateWuid(ECL,THOR,wk_ut._constants.ProdEsp) : when('IKB FCRA Build Scheduler');