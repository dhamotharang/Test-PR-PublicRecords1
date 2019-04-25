import  Scoring_Project_Macros, Scoring_Project_PIP;
test2 :=		Scoring_Project_PIP.Generic_Tracking_Report_Boca_Shells('scoringqa::out::fcra::bocashell_41_historydate_999999_cert_', scoring_project_Macros.Global_Output_Layouts.BocaShell_Global_Layout, 'FCRA 41', 'accountnumber');
test3 :=		Scoring_Project_PIP.Generic_Tracking_Report_Boca_Shells('scoringqa::out::fcra::bocashell_50_historydate_999999_cert_', scoring_project_Macros.Global_Output_Layouts.BocaShell_Global_Layout, 'FCRA 50', 'accountnumber');
test4 :=		Scoring_Project_PIP.Generic_Tracking_Report_Boca_Shells('scoringqa::out::nonfcra::bocashell_41_historydate_999999_cert_', Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout, 'nonFCRA 41', 'accountnumber');
test5 :=		Scoring_Project_PIP.Generic_Tracking_Report_Boca_Shells('scoringqa::out::nonfcra::bocashell_50_historydate_999999_cert_', scoring_project_Macros.Global_Output_Layouts.BocaShell_Global_Layout, 'nonFCRA 50', 'accountnumber');
sequential(test2,test3,test4,test5);
FileServices.SendEmail('Bridgett.braaten@lexisnexis.com; Matthew.Ludewig@lexisnexisrisk.com', 'Cert Boca Shell Tracking Reports:', WORKUNIT);


EXPORT BWR_Boca_Shell_Compare_Macros := 'todo';