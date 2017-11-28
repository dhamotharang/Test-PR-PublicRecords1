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
EXPORT MatchThreshold := 37;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
EXPORT MeowPrefetch := 20; //Number of transforms called at once
EXPORT ExternalFilePrefetch := 30; //Number of transforms called at once
EXPORT LinkpathCandidateCount := 50; // Number of candidates to consider from each linkpath in batch. Higher = better result and slower execution.
EXPORT meow_dedup := 'AUTO'; // Values: ALWAYS, NEVER, or anything else to automatically decide what to dedup from MEOW inputs
 
EXPORT MAC_MEOW_LocationID_Batch_Wrapper(infile,Ref='',Input_LocId = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_v_city_name = '',Input_st = '',Input_zip5 = '',OutFile,AsIndex='true',UpdateIDs='false',Stats='') := MACRO
	LocationId_xLink.MAC_MEOW_LocationID_Batch(infile,Ref,Input_LocId,Input_prim_range,Input_predir,Input_prim_name,Input_addr_suffix,Input_postdir,Input_unit_desig,Input_sec_range,Input_v_city_name,Input_st,Input_zip5,OutFile,AsIndex,UpdateIDs,Stats);
ENDMACRO;
EXPORT KeyInfix := KeyInfix;
EXPORT JoinLimit := 10000;
// Configuration of individual fields
// Configuration of linkpath atmost/limit thresholds
EXPORT STATECITY_MAXBLOCKSIZE:=10000;
EXPORT STATECITY_MAXBLOCKLIMIT:=10000;
EXPORT ZIP_MAXBLOCKSIZE:=10000;
EXPORT ZIP_MAXBLOCKLIMIT:=10000;
END;
