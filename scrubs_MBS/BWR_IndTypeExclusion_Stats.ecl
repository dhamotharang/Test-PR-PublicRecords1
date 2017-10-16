﻿Import Scrubs;
versionDate:= '20170611a';

F := Scrubs_MBS.IndTypeExclusion_In_IndTypeExclusion; // Input file
S := Scrubs_MBS.IndTypeExclusion_Scrubs; // My scrubs module
N := S.FromNone(F); // Generate the error flags
B := N.BitmapInfile;
//OUTPUT(B,,'~thor_data400::scrubs::fraudgov::20170522::scrubs_IndTypeExclusion', overwrite, compressed);
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
// Scrubs.OrbitProfileStats('Scrubs_MBS_IndTypeExclusion','Scrubs',stats).ProfileTemplate;
//Generating a template to upload rules to Orbit
//Submits stats to Orbit
submitStats:=Scrubs.OrbitProfileStats('Scrubs_MBS_IndTypeExclusion','ScrubsAlerts',stats,versionDate,'MBS').SubmitStats;
submitStats;			
