#WORKUNIT('priority','high');
#workunit('name', 'BSS Report');
attr_compare_1:=Scoring_QA.bss;
attr_compare_2:=Scoring_QA_Risk_Indicator_Report.bss;
attr_compare_3:= Scoring_QA_Risk_Indicator_Report.bss_fp31505scores;
PBTracking := Scoring_Project_Macros.Profile_Booster_Tracking_Report;
sequential(attr_compare_1,attr_compare_3, attr_compare_2,PBTracking)

: WHEN(CRON('05 13 * * *')),
FAILURE(FileServices.SendEmail( 'Apaar.Sinha@lexisnexis.com,suman.burjukindi@lexisnexis.com,Benjamin.Karnatz@lexisnexis.com,karthik.reddy@lexisnexis.com,Nathan.Koubsky@lexisnexis.com,jayson.alayay@lexisnexis.com,Bridgett.Braaten@lexisnexis.com,Venkat.Arani@lexisnexis.com','BSS attribute CRON jobs failed','The failed workunit is:' + workunit + FailMessage));



// EXPORT BWR_BSS_Attribute_Report := 'todo';