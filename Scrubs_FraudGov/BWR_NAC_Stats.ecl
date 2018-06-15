import Scrubs;
versionDate:= '20170606b';

F := table(Scrubs_Fraudgov.NAC_In_NAC, nac_layout_nac) ; // Input file
S := Scrubs_Fraudgov.NAC_Scrubs; // My scrubs module
N := S.FromNone(F); // Generate the error flags
B := N.BitmapInfile;
// OUTPUT(B,,'~thor_data400::scrubs::fraudgov::20170522::scrubs_mbs', overwrite, compressed);
T := S.FromBits(B);     // Use the FromBits module; makes my bitmap datafile easier to get to
// output(T);
U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module
// output(U.SummaryStats, named('ErrorSummary')); // Show errors by field and type
// output(choosen(U.AllErrors, 1000), named('EyeballSomeErrors')); // Just eyeball some errors
// output(choosen(U.BadValues, 1000), named('SomeErrorValues')); // See my error field values

//	Get our stats
stats := U.OrbitStats();
// output(stats,all,named('OrbitReport'));
//Generating a template to upload rules to Orbit
// Scrubs.OrbitProfileStats('Scrubs_MBS','Scrubs',stats).ProfileTemplate;
//Generating a template to upload rules to Orbit
Scrubs.OrbitProfileStats('Scrubs_FraudGov_NAC','ScrubsAlerts',stats).ProfileAlertsTemplate;
//Generating a template to upload rules to Orbit
// Scrubs.OrbitProfileStats(,,stats).ProfileTemplate;
//Generating a template to upload rules to Orbit
// Scrubs.OrbitProfileStats(,,stats).ProfileAlertsTemplate;

//Submits stats to Orbit
// submitStats:=Scrubs.OrbitProfileStats('Scrubs_MBS','ScrubsAlerts',stats,versionDate,'MBS').SubmitStats;
// submitStats;			
