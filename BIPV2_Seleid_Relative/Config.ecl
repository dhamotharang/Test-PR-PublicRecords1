IMPORT SALT31;
EXPORT Config := MODULE,VIRTUAL
// The wildcard match function currently being used
EXPORT WildMatch(SALT31.StrType src,SALT31.StrType Pat,BOOLEAN _NoCase) := StringLib.StringWildMatch(src,pat,_nocase);
EXPORT WildPenalty := 2.0; // Higher number means wild matches get lower scores.
EXPORT DoSliceouts := TRUE; // If set to false slice-outs do not occur (saves time)
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT AttrValueType := SALT31.AttrValueType;
EXPORT MatchThreshold := 41;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
EXPORT KeyInfix := KeyInfix;
EXPORT KeyInfix_specificities := 'qa';/*HACK*/;
// Configuration of individual fields
EXPORT prim_range_Force := 0; 
EXPORT sec_range_Force := 0; 
EXPORT active_duns_number_Force := 0; 
EXPORT active_enterprise_number_Force := 0; 
// Configuration of external files
END;
