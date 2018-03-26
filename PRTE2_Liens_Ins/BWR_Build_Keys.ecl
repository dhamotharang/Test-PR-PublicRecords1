/* *********************************************************************************************
  PRTE2_Liens_Ins.BWR_Build_Keys
  It is assumed that our data base files are set and ready - this will do the Boca key build
********************************************************************************************* */

IMPORT PRTE2_Liens, PRTE2_Common;
#workunit('name', 'Build PRCT L&J Key Files');

STRING fileVersion := PRTE2_Common.Constants.TodayString+'a';
STRING emailTo := PRTE2_Common.Email.DOPSInterestEmails;
// boolean skipDopsYN := PRTE2_Common.Constants.TRIAL_RUN_ONLY_NO_DOPS;
boolean skipDopsYN := PRTE2_Common.Constants.FULL_RUN_WITH_DOPS;

// build_base := PRTE2_Liens.proc_build_base;
// build_liens_keys := PRTE2_Liens.proc_build_liens_keys(fileVersion,skipDopsYN,emailTo);
// SEQUENTIAL(build_base, build_liens_keys);

build_liens_keys := PRTE2_Liens.proc_build_all(fileVersion,skipDopsYN,emailTo);
SEQUENTIAL(build_liens_keys);

	

