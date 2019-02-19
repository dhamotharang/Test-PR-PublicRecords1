import Scrubs;

F := table(Scrubs_Fraudgov.InquiryLogs_In_InquiryLogs, InquiryLogs_layout_InquiryLogs) ; // Input file
S := Scrubs_Fraudgov.InquiryLogs_Scrubs; // My scrubs module
N := S.FromNone(F); // Generate the error flags
U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

//	Get our stats
stats := U.OrbitStats();
//Generating a template to upload rules to Orbit
Scrubs.OrbitProfileStats('Scrubs_FraudGov_InquiryLogs_v2','ScrubsAlerts',stats).ProfileAlertsTemplate;