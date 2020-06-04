EXPORT Config := MODULE,VIRTUAL
EXPORT DoSliceouts := FALSE; // If set to false slice-outs do not occur (saves time)
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT MatchThreshold := 43;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
// Configuration of individual fields
EXPORT cname_devanitize_Force := 0; 
EXPORT prim_range_Force := 0; 
EXPORT prim_name_Force := 0; 
EXPORT fname_Force := 0; 
EXPORT lname_Force := 0; 
EXPORT contact_did_Force := 0; 
EXPORT contact_ssn_Force := 0; 
END;
