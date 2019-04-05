//BWR_PhonesInfoSched

import std;

pversion:=(string8)STD.Date.CurrentDate(True);

#workunit ('name', 'Build Phones Info ' );

PRTE2_PhonesInfo.proc_Build_All(pversion): WHEN(CRON('0 12 * * 1'));