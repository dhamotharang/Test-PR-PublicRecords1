import Scrubs;

import Scrubs;

F := table(Scrubs_Fraudgov.NAC_In_NAC, NAC_layout_NAC) ; // Input file
S := Scrubs_Fraudgov.NAC_Scrubs; // My scrubs module
N := S.FromNone(F); // Generate the error flags
U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

//	Get our stats
stats := U.OrbitStats();
//Generating a template to upload rules to Orbit
Scrubs.OrbitProfileStats('Scrubs_FraudGov_NAC_v2','ScrubsAlerts',stats).ProfileAlertsTemplate;
