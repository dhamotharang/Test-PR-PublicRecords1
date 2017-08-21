


import Scrubs;
import Hygenics_SOff;

#option('multiplePersistInstances',FALSE);
//version := '20141022';
version :=  StringLib.GetDateYYYYMMDD();
F := scrubs_sexoffender_def_raw.in_sex_offender_defendant_raw;
S :=scrubs_sexoffender_def_raw.Scrubs; // My scrubs module
N := S.FromNone(F); // Generate the error flags

U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module
//output(U.SummaryStats, named('ErrorSummaryDef_raw')); // Show errors by field and type
//output(choosen(U.AllErrors, 1000), named('EyeballSomeErrorsDef_raw')); // Just eyeball some errors
//output(choosen(U.BadValues, 1000), named('SomeErrorValuesDef_raw')); // See my error field values
Orbit_st := U.OrbitStats() : persist('~persist::sexoffender_def_raw_orbit_stats');

//Outputs reports
output(Orbit_st,all,named('OrbitReportDef_raw'));
//output(Scrubs.OrbitProfileStats(,,Orbit_st).SummaryStats, all,named('OrbitReportSummaryDef_raw'));

//This will output a file with bitmap(s) for the rules
OUTPUT( N.BitmapInfile,,'~thor_data::sex_offender_def_raw_bits', overwrite, compressed, named('create_bitmapinfile_def_raw')); // long term storage
DS := DATASET('~thor_data::sex_offender_def_raw_bits',S.Bitmap_Layout,FLAT); // Read in my data (which has bitmap appended
//This will translate the bitmap(s)
T := S.FromBits(DS);     // Use the FromBits module; makes my bitmap datafile easier to get to
//output(T);

//This will create expanded file
OUTPUT(T.ExpandedInfile,,'~thor_data::sex_offender_def_raw_expandedfile', overwrite, compressed, named('create_expandedinfile_def_raw'));
DS2 := DATASET('~thor_data::sex_offender_def_raw_expandedfile',S.Expanded_Layout,FLAT);

//Generates a Profile template to set up a profile in Orbit - don't need to run it every time.
//Once the profile is set and doesn't need updates.  There is no need to rerun.
//Scrubs.OrbitProfileStats('Scrubs_Sexoffender_Def_Raw',, Orbit_st, version).ProfileTemplate;

//Submits Profile's stats to Orbit
Scrubs.OrbitProfileStats('scrubs_sexoffender_def_raw',, Orbit_st, version, 'def_raw').SubmitStats;



