IMPORT SALT37;
EXPORT Config := MODULE,VIRTUAL
EXPORT DoSliceouts := TRUE; // If set to false slice-outs do not occur (saves time)
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT AttrValueType := SALT37.AttrValueType;
EXPORT MaxChildren := 100; // Maximum children allowed for a MULTIPLE(,LIST)
alg := ENUM(UNSIGNED1, Standard=0, NoTrailingHalfEdit);
EXPORT WithinEditN(SALT37.StrType l,UNSIGNED1 ll, SALT37.StrType r,UNSIGNED1 rl,UNSIGNED1 d, UNSIGNED1 edit_threshold=0,UNSIGNED1 mode=alg.Standard, BOOLEAN edFunction(SALT37.StrType l,UNSIGNED1 ll, SALT37.StrType r,UNSIGNED1 rl,UNSIGNED1 d,UNSIGNED1 mode) = SALT37.fn_EditDistance) := 
        SALT37.WithinEditNew(l, ll, r, rl, d, edit_threshold, mode, edFunction);
EXPORT MatchThreshold := 32;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
EXPORT JoinLimit := 10000;
// Configuration of individual fields
EXPORT prim_range_Force := 0; 
EXPORT v_city_name_Force := 0; 
EXPORT st_Force := 0; 
EXPORT zip5_Force := 0; 
EXPORT cntprimname_Force := 0; 
EXPORT cntprimname_OR1_prim_name_Force := 0;
EXPORT sec_range_Force := 0; 
EXPORT postdir_Force := 0; 
EXPORT predir_Force := 0; 
EXPORT prim_name_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT err_stat_Force := 0; 
EXPORT addr_suffix_Force := 0; 
// Configuration of linkpath atmost/limit thresholds
END;
