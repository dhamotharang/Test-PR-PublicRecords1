IMPORT SALT311,STD;
EXPORT Config := MODULE,VIRTUAL
EXPORT DoSliceouts := TRUE; // If set to false slice-outs do not occur (saves time)
EXPORT SliceDistance := 10;
EXPORT FastSlice := TRUE; // Set to false for a more aggressive mode of slicing
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT AttrValueType := SALT311.AttrValueType;
EXPORT KeysBitmapType := UNSIGNED4;
EXPORT KeysBitmapOffset := 16;
EXPORT MaxChildren := 100; // Maximum children allowed for a MULTIPLE(,LIST)
alg := ENUM(UNSIGNED1, Standard=0, NoTrailingHalfEdit);
EXPORT WithinEditN(SALT311.StrType l,UNSIGNED1 ll, SALT311.StrType r,UNSIGNED1 rl,UNSIGNED1 d, UNSIGNED1 edit_threshold=0,UNSIGNED1 mode=alg.Standard, BOOLEAN edFunction(SALT311.StrType l,UNSIGNED1 ll, SALT311.StrType r,UNSIGNED1 rl,UNSIGNED1 d,UNSIGNED1 mode) = SALT311.fn_EditDistance) := 
        SALT311.WithinEditNew(l, ll, r, rl, d, edit_threshold, mode, edFunction);
EXPORT MatchThreshold := 41;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
EXPORT JoinLimit := 10000;
// Configuration of individual fields
EXPORT src_Permit_Number := 1; // The number of permit bits for record access control; This number needs to be in sync with fn_sources!
END;
