


import Scrubs;

#option('multiplePersistInstances',FALSE);
//version := '20141022';
version :=  StringLib.GetDateYYYYMMDD();
F := scrubs_sexoffender_main.in_sex_offender_mainpublic;
S :=scrubs_sexoffender_main.Scrubs; // My scrubs module
N := S.FromNone(F); // Generate the error flags

U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module
//output(U.SummaryStats, named('ErrorSummaryMain')); // Show errors by field and type
//output(choosen(U.AllErrors, 1000), named('EyeballSomeErrorsMain')); // Just eyeball some errors
//output(choosen(U.BadValues, 1000), named('SomeErrorValuesMain')); // See my error field values
Orbit_st := U.OrbitStats() : persist('~persist::sexoffender_main_orbit_stats');

//Outputs reports
output(Orbit_st,all,named('OrbitReportMain'));
//output(Scrubs.OrbitProfileStats(,,Orbit_st).SummaryStats, all,named('OrbitReportSummaryMain'));

//This will output a file with bitmap(s) for the rules
OUTPUT( N.BitmapInfile,,'~thor_data::sex_offender_main_bits', overwrite, compressed, named('create_bitmapinfile_main')); // long term storage
DS := DATASET('~thor_data::sex_offender_main_bits',S.Bitmap_Layout,FLAT); // Read in my data (which has bitmap appended
//This will translate the bitmap(s)
T := S.FromBits(DS);     // Use the FromBits module; makes my bitmap datafile easier to get to
//output(T);

//This will create expanded file
OUTPUT(T.ExpandedInfile_main,,'~thor_data::sex_offender_main_expandedfile', overwrite, compressed, named('create_expandedinfile_main'));
DS2 := DATASET('~thor_data::sex_offender_main_expandedfile',S.Expanded_Layout,FLAT);

//Generates a Profile template to set up a profile in Orbit - don't need to run it every time.
//Once the profile is set and doesn't need updates.  There is no need to rerun.
//Scrubs.OrbitProfileStats('Scrubs_Sexoffender_Main',, Orbit_st, version).ProfileTemplate;

//Submits Profile's stats to Orbit
Scrubs.OrbitProfileStats('Scrubs_Sexoffender_Main',, Orbit_st, version, 'Main').SubmitStats;
Scrubs.OrbitProfileStats('ScrubsAlerts_Sexoffender_Main','ScrubsAlerts', Orbit_st, version, 'MainScrubsAlerts').SubmitStats;


