IMPORT RiskWise,scoring_project_pip, Scoring_Project_Macros, sghatti, Gateway, ut, std, Inquiry_AccLogs, BIPV2, doxie, data_services, _control;


ds1 := Scoring_Project_Macros.Bankruptcy_Run;
ds2 := Scoring_Project_Macros.Criminal_Run;
ds3 := Scoring_Project_Macros.Liens_Run;
ds4 := Scoring_Project_Macros.Inquiries_Run;
ds5 := Scoring_Project_Macros.Header_Run;
ds6 := Scoring_Project_Macros.Thrive_Run;



SEQUENTIAL(ds1,ds2,ds3,ds4,ds5,ds6)
:SUCCESS(FileServices.SendEmail('Daniel.Harkins@lexisnexisrisk.com','FCRA_Query_Test_Cases_Generated','The completed workunit is:' + ' ' + workunit)),
FAILURE(FileServices.SendEmail('Daniel.Harkins@lexisnexisrisk.com','FCRA_Query_Test_Cases_Failed','The failed workunit is:' + ' ' + workunit + FailMessage));
