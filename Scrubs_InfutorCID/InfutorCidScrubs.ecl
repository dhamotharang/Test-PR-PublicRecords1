Import ut, Scrubs, Orbit3SOA, SALT30;

Export InfutorCidScrubs(string8 Version) := Function
#workunit('name', 'Scrubs InfutorCID');
#option('multiplePersistInstances',FALSE);

F := Scrubs_InfutorCID.In_InfutorCidBase;
S :=Scrubs_InfutorCID.Scrubs; // My scrubs module
N :=S.FromNone(F); // Generate the error flags
T := S.FromBits(N.BitmapInfile);   // Use the FromBits module; makes my bitmap datafile easier to get to
U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module
// Orbit Stats
Orbit_st := U.OrbitStats() : persist('~persist::InfutorCid_orbit_stats'); 
scrubs_rpt := Scrubs.OrbitProfileStats('', , Orbit_st, version).CompareToProfile;

Return scrubs_rpt;
End;