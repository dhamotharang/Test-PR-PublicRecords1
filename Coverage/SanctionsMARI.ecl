/* W20080304-120033
Sanctions MARI
*/

/*

Coverage Date Rankings:

The following dates should be used in the following order for example in Arrest Logs, 

case filing date and arrest date are equally effective when determining coverage.  

(However case filing date is more likely to be populated).  You would only use date fields with subsequent rankings 

in the absence of its predecessor.  Those date fields not listed should not be used.

 

Arrest Logs:

1. Case Filing Date

1. Arrest Date

2. Arrest Disposition Date

3. Offense Date

 

Criminal Court:

1. Case Filing Date

2. Court Disposition Date

3. Sentence Date

 

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

import CRIM,civil_court,Crim_Common,SANCTN,lib_stringlib;

crimData := Crim_Common.File_Crim_Offender2_Plus; // Includes arrest logs, criminal court and doc
civData:= civil_court.File_Moxie_Matter_Prod;    // civil only

sanctnData := SANCTN.file_out_incident_cleaned;                                   // Sanctn

sanctnLayout := record
SANCTN.layout_SANCTN_incident_clean;
string8 process_date := '';
string20 source_file :='';
string6 did := '';
end;

sanctnLayout sanctnReform(sanctnData l):= transform
self.process_date := '20080212';
self.source_file := 'Mari Choicepoint';
self.did := '';
self := l;
end;

sanctOut := project(sanctnData,sanctnReform(left));

/*Ex:
CRIM.mac_CoverageReport(crimData,case_filing_dt,crimCoverageReport);
crimCoverageReport;
*/

CRIM.mac_CoverageReport(sanctOut,incident_date_clean,coverageReport);
CoverageReport;