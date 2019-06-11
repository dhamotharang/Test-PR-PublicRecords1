IMPORT SALT311,STD;
EXPORT Config := MODULE,VIRTUAL
EXPORT CorrelateSampleSize := 623925; // Size of sample used in hygiene.corelations (reduced due to large field count)
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT AttrValueType := SALT311.AttrValueType;
EXPORT KeysBitmapType := UNSIGNED4;
EXPORT KeysBitmapOffset := 16;
EXPORT MaxChildren := 100; // Maximum children allowed for a MULTIPLE(,LIST)
alg := ENUM(UNSIGNED1, Standard=0, NoTrailingHalfEdit);
EXPORT WithinEditN(SALT311.StrType l,UNSIGNED1 ll, SALT311.StrType r,UNSIGNED1 rl,UNSIGNED1 d, UNSIGNED1 edit_threshold=0,UNSIGNED1 mode=alg.Standard, BOOLEAN edFunction(SALT311.StrType l,UNSIGNED1 ll, SALT311.StrType r,UNSIGNED1 rl,UNSIGNED1 d,UNSIGNED1 mode) = SALT311.fn_EditDistance) := 
        SALT311.WithinEditNew(l, ll, r, rl, d, edit_threshold, mode, edFunction);
EXPORT JoinLimit := 10000;
// Configuration of individual fields
EXPORT msaddr1_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT msaddr2_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT mscity_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
END;
