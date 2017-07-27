IMPORT SALT33;
EXPORT Config := MODULE,VIRTUAL
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT AttrValueType := SALT33.AttrValueType;
EXPORT MaxChildren := 100; // Maximum children allowed for a MULTIPLE(,LIST)
EXPORT MatchThreshold := 38;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
EXPORT JoinLimit := 10000;
// Configuration of individual fields
EXPORT prim_range_Force := 0; 
EXPORT prim_name_Force := 0; 
EXPORT RID_If_Big_Biz_Force := 0; 
EXPORT cnp_name_Force := 13; 
EXPORT company_name_Force := 0; 
EXPORT cnp_number_Force := 0; 
// Configuration of external files
END;

