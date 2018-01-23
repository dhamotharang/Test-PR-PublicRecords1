IMPORT SALT38;
EXPORT Config := MODULE,VIRTUAL
EXPORT DoSliceouts := TRUE; // If set to false slice-outs do not occur (saves time)
EXPORT CorrelateSampleSize := 2993259; // Size of sample used in hygiene.corelations (reduced due to large field count)
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT AttrValueType := SALT38.AttrValueType;
EXPORT MaxChildren := 100; // Maximum children allowed for a MULTIPLE(,LIST)
alg := ENUM(UNSIGNED1, Standard=0, NoTrailingHalfEdit);
EXPORT WithinEditN(SALT38.StrType l,UNSIGNED1 ll, SALT38.StrType r,UNSIGNED1 rl,UNSIGNED1 d, UNSIGNED1 edit_threshold=0,UNSIGNED1 mode=alg.Standard, BOOLEAN edFunction(SALT38.StrType l,UNSIGNED1 ll, SALT38.StrType r,UNSIGNED1 rl,UNSIGNED1 d,UNSIGNED1 mode) = SALT38.fn_EditDistance) := 
        SALT38.WithinEditNew(l, ll, r, rl, d, edit_threshold, mode, edFunction);
EXPORT JoinLimit := 10000;
// Configuration of individual fields
END;

