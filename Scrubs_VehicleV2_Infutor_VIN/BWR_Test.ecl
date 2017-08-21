#option('multiplePersistInstances',FALSE);
version := '20141020';
import Scrubs_VehicleV2_Infutor_VIN;
F := Scrubs_VehicleV2_Infutor_VIN.In_VehicleV2_Infutor_VIN;		//Input file
S := Scrubs_VehicleV2_Infutor_VIN.Scrubs;
N := S.FromNone(F);
T := S.FromBits(N.BitmapInfile);     // Use the FromBits module; makes my bitmap datafile easier to get to
U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

output(U.SummaryStats, named('ErrorSummary')); // Show errors by field and type
output(choosen(U.AllErrors, 1000), named('EyeballSomeErrors')); // Just eyeball some errors
output(choosen(U.BadValues, 1000), named('SomeErrorValues')); // See my error field values
Orbit_st := U.OrbitStats() : persist('~persist::vehiclev2::infutor_vin_orbit_stats');

//Outputs reports
output(Orbit_st,all,named('OrbitReport'));
output(Scrubs.OrbitProfileStats(,,U.OrbitStats()).SummaryStats, all,named('OrbitReportSummary'));

//Generates a Profile template to set up a profile in Orbit - don't need to run it every time.
//Once the profile is set and doesn't need updates.  There is no need to rerun.
Scrubs.OrbitProfileStats('Scrubs_VehicleV2_Infutor_VIN',, Orbit_st, version,'Inf_VIN').ProfileTemplate;

//Submits Profile's stats to Orbit
//Scrubs.OrbitProfileStats('Scrubs_VehicleV2_Infutor_VIN',, Orbit_st, version).SubmitStats;