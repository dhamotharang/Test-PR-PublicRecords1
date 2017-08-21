/*
Coverage Date Rankings:
The following dates should be used in the following order for example in Arrest Logs, 
case filing date and arrest date are equally effective when determining coverage.  
(However case filing date is more likely to be populated).  You would only use date fields with subsequent rankings 
in the absence of its predecessor.  Those date fields not listed should not be used.

Arrest Logs:
1. Case Filing Date
1. Arrest Date
2. Arrest Disposition Date
3. Offense Date

Criminal Court:
1. Case Filing Date
2. Court Disposition Date
3. Sentence Date

Civil Court:

1. Filing Date
2. Judgment Date
3. Judgment Disposition
4. Disposition Date

DOC:

5. Incarceration Admit Date
6. Sentence Date
7. Latest Admit Date
8. Case Filing Date
9. Event Date
*/

////////////////////////////////////////////////////////////////////////////////////////////////////////
import CRIM,civil_court,Crim_Common;

crimData := Crim_Common.File_Crim_Offender2_Plus; //includes arrest logs, criminal court and doc
civData:= civil_court.File_Moxie_Matter_Prod;    // civil only

/*Ex:
CRIM.mac_CoverageReport(crimData,case_filing_dt,crimCoverageReport);
crimCoverageReport;
*/

CRIM.mac_CoverageReport(/*Enter Dataset Here*/,/*Enter Date Field Name*/,coverageReport);
CoverageReport;

//RUN BWR
////////////////////////////////////////////////////////////////////////////////////////////////////////