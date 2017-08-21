IMPORT SALT32;
EXPORT Config := MODULE,VIRTUAL
// The wildcard match function currently being used
EXPORT WildMatch(SALT32.StrType src,SALT32.StrType Pat,BOOLEAN _NoCase) := StringLib.StringWildMatch(src,pat,_nocase);
EXPORT WildPenalty := 2.0; // Higher number means wild matches get lower scores.
EXPORT DoSliceouts := TRUE; // If set to false slice-outs do not occur (saves time)
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT AttrValueType := SALT32.AttrValueType;
EXPORT MaxChildren := 100; // Maximum children allowed for a MULTIPLE(,LIST)
EXPORT JoinLimit := 10000;
// Configuration of individual fields
// Configuration of external files
END;
