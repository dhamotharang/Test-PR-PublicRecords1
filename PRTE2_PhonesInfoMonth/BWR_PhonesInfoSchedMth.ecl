
import std;

pversion:=(string8)STD.Date.CurrentDate(True);

#workunit ('name', 'Build Phones Info Monthly' );

PRTE2_PhonesInfoMonth.proc_Build_All(pversion):   WHEN(CRON('0 12 15 * 1'));