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
EXPORT MatchThreshold := 60;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
EXPORT JoinLimit := 10000;
// Configuration of individual fields
EXPORT orgid_Force := 0; 
EXPORT fname_Force := 0; 
EXPORT mname_Force := 0; 
EXPORT lname_Force := 0; 
EXPORT name_suffix_Force := 0; 
// Configuration of external files
END;
