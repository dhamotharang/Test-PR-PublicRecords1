IMPORT SALT33;
EXPORT Config := MODULE,VIRTUAL
EXPORT DoSliceouts := TRUE; // If set to false slice-outs do not occur (saves time)
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT AttrValueType := SALT33.AttrValueType;
EXPORT MaxChildren := 100; // Maximum children allowed for a MULTIPLE(,LIST)
EXPORT JoinLimit := 10000;
// Configuration of individual fields
// Configuration of external files
END;

