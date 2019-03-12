//BWR_PhoneFraudSched

import std;

pversion:=(string8)STD.Date.CurrentDate(True);

#workunit ('name', 'Build Phone Fraud ' );

PRTE2_PhoneFraud.proc_Build_All(pversion): WHEN(CRON('0 13 * * 1'));