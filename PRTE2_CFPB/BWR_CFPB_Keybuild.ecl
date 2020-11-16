IMPORT PRTE, PRTE2_Common, ut, STD;

#WORKUNIT ('name', 'PRCT CFPB BUILD PROCESS');

filedate := (STRING8)Std.Date.Today()+''; 

skipDopsYN := PRTE2_Common.Constants.TRIAL_RUN_ONLY_NO_DOPS;
// skipDopsYN := PRTE2_Common.Constants.FULL_RUN_WITH_DOPS;

// because we cannot sandbox myInfo when running in Production
emailTo := PRTE2_Common.Email.DOPSInterestEmails;

// just debugging here
OUTPUT(PRTE2_Common.Constants.is_running_in_prod AND skipDopsYN,NAMED('DO_DOPS_YN'));

BuildStep := PRTE2_CFPB.Proc_Build_Keys(filedate, skipDopsYN, emailTo);
SEQUENTIAL (BuildStep);
