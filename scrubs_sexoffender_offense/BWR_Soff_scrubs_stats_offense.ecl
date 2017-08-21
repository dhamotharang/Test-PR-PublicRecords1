
import Scrubs; 

#option('multiplePersistInstances',FALSE);
//version := '20141022';
version :=  StringLib.GetDateYYYYMMDD();
F := scrubs_sexoffender_offense.in_sex_offender_offensepublic;
S :=scrubs_sexoffender_offense.Scrubs; // My scrubs module
N := S.FromNone(F); // Generate the error flags

U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module
//output(U.SummaryStats, named('ErrorSummaryOff')); // Show errors by field and type
//output(choosen(U.AllErrors, 1000), named('EyeballSomeErrorsOff')); // Just eyeball some errors
//output(choosen(U.BadValues, 1000), named('SomeErrorValuesOff')); // See my error field values
Orbit_st := U.OrbitStats() : persist('~persist::sexoffender_offense_orbit_stats');

//Outputs reports
output(Orbit_st,all,named('OrbitReportOff'));
//output(Scrubs.OrbitProfileStats(,,Orbit_st).SummaryStats, all,named('OrbitReportSummaryOff'));

//This will output a file with bitmap(s) for the rules
OUTPUT( N.BitmapInfile,,'~thor_data::sex_offender_offense_bits', overwrite, compressed, named('create_bitmapinfile_offense')); // long term storage
DS := DATASET('~thor_data::sex_offender_offense_bits',S.Bitmap_Layout,FLAT); // Read in my data (which has bitmap appended
//This will translate the bitmap(s)
T := S.FromBits(DS);     // Use the FromBits module; makes my bitmap datafile easier to get to
//output(T);

//This will create a expanded file
OUTPUT(T.ExpandedInfile_offense,,'~thor_data::sex_offender_offense_expandedfile', overwrite, compressed, named('create_expandedinfile_offense'));
DS2 := DATASET('~thor_data::sex_offender_offense_expandedfile',S.Expanded_Layout,FLAT);

//Generates a Profile template to set up a profile in Orbit - don't need to run it every time.
//Once the profile is set and doesn't need updates.  There is no need to rerun.
//Scrubs.OrbitProfileStats('Scrubs_Sexoffender_Offense',, Orbit_st, version).ProfileTemplate;

//Submits Profile's stats to Orbit
Scrubs.OrbitProfileStats('Scrubs_Sexoffender_Offense',, Orbit_st, version, 'Offense').SubmitStats;
Scrubs.OrbitProfileStats('ScrubsAlerts_Sexoffender_Offense','ScrubsAlerts', Orbit_st, version, 'OffenseScrubsAlerts').SubmitStats;
