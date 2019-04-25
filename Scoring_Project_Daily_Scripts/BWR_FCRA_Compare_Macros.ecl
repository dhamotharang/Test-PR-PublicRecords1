import  Scoring_Project_Macros;
test2 :=		Scoring_Project_PIP.Generic_Tracking_Report('scoringqa::out::fcra::riskview_xml_generic_attributes_v3_', scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_Attributes_V3_Global_Layout, 'RiskView v3', 'accountnumber');
test3 :=		Scoring_Project_PIP.Generic_Tracking_Report('scoringqa::out::fcra::riskview_xml_generic_attributes_v4_', scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_xml_Generic_Attributes_V4_Global_Layout, 'RiskView v4', 'accountnumber');
test4 :=		Scoring_Project_PIP.Generic_Tracking_Report('scoringqa::out::fcra::riskview_xml_generic_allflagships_attributes_v5_', Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_Attributes_V5_Global_Layout, 'RiskView v5', 'acctNo');
test5 :=		Scoring_Project_PIP.Generic_Tracking_Report('scoringqa::out::fcra::riskview_xml_experian_attributes_v3_', scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_Experian_Attributes_V3_Global_Layout, 'RiskView v3 Experian', 'accountnumber');
sequential(test2,test3,test4,test5);
FileServices.SendEmail('Bridgett.braaten@lexisnexis.com; Matthew.Ludewig@lexisnexisrisk.com', 'Cert FCRA Tracking Reports:', WORKUNIT);

EXPORT BWR_FCRA_Compare_Macros := 'todo';