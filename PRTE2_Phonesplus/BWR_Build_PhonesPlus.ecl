IMPORT PRTE, PRTE2_Common, ut;
#OPTION('multiplePersistInstances',FALSE);
#WORKUNIT ('name', 'PRCT PhonesPlus Alpha Base Spray');

string filedate := ut.GetDate+''; 
skipDopsYN := PRTE2_Common.Constants.TRIAL_RUN_ONLY_NO_DOPS;
// skipDopsYN := PRTE2_Common.Constants.FULL_RUN_WITH_DOPS;

// because we cannot sandbox myInfo when running in Production
emailTo := PRTE2_Common.Email.DOPSInterestEmails;

// just debugging here
OUTPUT(PRTE2_Common.Constants.is_running_in_prod AND skipDopsYN,NAMED('DO_DOPS_YN'));

BuildStep := PRTE.Proc_Build_Phonesplusv2_Keys (filedate, skipDopsYN, emailTo);
SEQUENTIAL (BuildStep);
