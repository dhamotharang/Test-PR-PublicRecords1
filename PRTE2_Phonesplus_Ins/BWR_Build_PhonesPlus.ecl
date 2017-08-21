/* ******************************************************************************
This is the new PRTE2_Ins build we must do to work with the new PRTE2 Boca Build
(this is separate from spraying new data into our base file which must be done first)
****************************************************************************** */

IMPORT PRTE, PRTE2_PhonesPlus, PRTE2_Common, ut;
#WORKUNIT ('name', 'PRCT PhonesPlus Alpha/Boca Key Build');

STRING filedate := PRTE2_Common.Constants.TodayString+'';
skipDopsYN := PRTE2_Common.Constants.TRIAL_RUN_ONLY_NO_DOPS;
// skipDopsYN := PRTE2_Common.Constants.FULL_RUN_WITH_DOPS;

// because we cannot sandbox myInfo when running in Production
emailTo := PRTE2_Common.Email.DOPSInterestEmails;

// just debugging here
OUTPUT(PRTE2_Common.Constants.is_running_in_prod AND skipDopsYN,NAMED('DO_DOPS_YN'));

// Nov 2016 - point to the new Boca Build
BuildStep := PRTE2_PhonesPlus.proc_build_all (filedate, skipDopsYN, emailTo);
SEQUENTIAL (BuildStep);
