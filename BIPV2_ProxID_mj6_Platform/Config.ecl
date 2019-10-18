EXPORT Config := MODULE,VIRTUAL
EXPORT DoSliceouts := false; // If set to false slice-outs do not occur (saves time)
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT MatchThreshold := 0; /*HACK to ensure matchthreshold is zero.  matching is done by FORCE(s) alone.*/
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
// Configuration of individual fields
EXPORT cnp_name_Force := 0; 
EXPORT cnp_number_Force := 0; 
EXPORT active_enterprise_number_Force := 0; 
EXPORT active_domestic_corp_key_Force := 0; 
EXPORT prim_range_Force := 0; 
EXPORT prim_name_derived_Force := 0; 
EXPORT v_city_name_Force := 0; 
EXPORT st_Force := 0; 
EXPORT zip_Force := 0; 
EXPORT company_csz_Force := 0; 
EXPORT company_addr1_Force := 0; 
EXPORT company_address_Force := 0; 
END;
