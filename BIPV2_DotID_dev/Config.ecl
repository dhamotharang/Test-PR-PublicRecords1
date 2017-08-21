EXPORT Config := MODULE,VIRTUAL
EXPORT DoSliceouts := TRUE; // If set to false slice-outs do not occur (saves time)
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT MatchThreshold := 39;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
// Configuration of individual fields
EXPORT cnp_name_Force := 0; 
EXPORT corp_legal_name_Force := 0; 
EXPORT cnp_number_Force := 0; 
EXPORT company_fein_Force := 0; 
EXPORT active_enterprise_number_Force := 0; 
EXPORT active_domestic_corp_key_Force := 0; 
EXPORT prim_range_Force := 0; 
EXPORT prim_name_Force := 0; 
EXPORT sec_range_Force := 0; 
EXPORT st_Force := 0; 
EXPORT csz_Force := -2; 
EXPORT address_Force := 0; 
EXPORT isContact_Force := 0; 
EXPORT fname_Force := 0; 
EXPORT mname_Force := 0; 
EXPORT lname_Force := 0; 
EXPORT name_suffix_Force := 0; 
END;
