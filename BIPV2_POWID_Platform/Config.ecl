IMPORT SALT32;
EXPORT Config := MODULE,VIRTUAL
// The wildcard match function currently being used
EXPORT WildMatch(SALT32.StrType src,SALT32.StrType Pat,BOOLEAN _NoCase) := StringLib.StringWildMatch(src,pat,_nocase);
EXPORT WildPenalty := 2.0; // Higher number means wild matches get lower scores.
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT AttrValueType := SALT32.AttrValueType;
EXPORT MaxChildren := 100; // Maximum children allowed for a MULTIPLE(,LIST)
EXPORT MatchThreshold := 38;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
EXPORT JoinLimit := 10000;
// Configuration of individual fields
EXPORT RID_If_Big_Biz_Force := 0; 
EXPORT company_name_Force := 0; 
EXPORT cnp_name_Force := 13; 
EXPORT cnp_number_Force := 0; 
EXPORT prim_range_Force := 0; 
EXPORT prim_name_Force := 0; 
// Configuration of external files
END;
