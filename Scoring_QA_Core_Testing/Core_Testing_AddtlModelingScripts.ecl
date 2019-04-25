// EXPORT Core_Testing_AddtlModelingScripts := 'todo';


#Workunit('name','ExperianPhone_CoreTest_Modeling_Before');

#WORKUNIT('priority','high');

Sequential(
		Scoring_QA_Core_Testing.bwr_BocaShell53_nonFCRA																	// Requirement 8.4.1
	,Scoring_QA_Core_Testing.bwr_BocaShell51_NonFCRA																	// Requirement 8.4.1
 ,Scoring_QA_Core_Testing.bwr_Fraudpoint3_Attributes_Scores							// Requirement 8.4.2
	,Scoring_QA_Core_Testing.bwr_Fraudpoint2_Attributes_Scores       // Requirement 8.4.3
	,Scoring_QA_Core_Testing.bwr_Fraudpoint201_Attributes_Scores	    // Requirement 8.4.3
	,Scoring_QA_Core_Testing.bwr_CIID                                // Requirement 8.4.4
 ,Scoring_QA_Core_Testing.bwr_BocaShell50_BT_ST 	                 // Requirement 8.4.5
 ,Scoring_QA_Core_Testing.BWR_Runway_Core_Stats                   // Requirement 8.4.6
//	,Scoring_QA_Core_Testing.bwr_NewPhoneShellGateways             // Requirement 8.4.7
//	,Scoring_QA_Core_Testing.bwr_NewPhoneShellNoGateways           // Requirement 8.4.7
	,Scoring_QA_Core_Testing.bwr_OrigPhoneShellGateways              // Requirement 8.4.7
	,Scoring_QA_Core_Testing.bwr_OrigPhoneShellNoGateways            // Requirement 8.4.7
// requirement # 8 included in PhoneShell run
	,Scoring_QA_Core_Testing.bwr_Business_InstantID                  // Requirement 8.4.9
	,Scoring_QA_Core_Testing.BWR_Business_InstantID_20               // Requirement 8.4.9
	,Scoring_QA_Core_Testing.BWR_Business_Shell_v22                  // Requirement 8.4.9
 	)



: WHEN(CRON('05 5 * * *')),
SUCCESS(FileServices.SendEmail('Matthew.Ludewig@lexisnexis.com','ExPhone_CoreTest_Modeling','The Completed workunit is:' + workunit));
 

