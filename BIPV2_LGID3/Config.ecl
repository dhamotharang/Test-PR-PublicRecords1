IMPORT SALT311,STD;
EXPORT Config := MODULE,VIRTUAL
EXPORT DoSliceouts := false/*HACKConfig*/; // If set to false slice-outs do not occur (saves time)
EXPORT SliceDistance := 10;
EXPORT FastSlice := TRUE; // Set to false for a more aggressive mode of slicing
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 7; // PERSIST file expiration time in days.
EXPORT AttrValueType := SALT311.AttrValueType;
EXPORT PartitionFieldType := STRING2;
EXPORT KeysBitmapType := UNSIGNED4;
EXPORT KeysBitmapOffset := 16;
EXPORT MaxChildren := 100; // Maximum children allowed for a MULTIPLE(,LIST)
alg := ENUM(UNSIGNED1, Standard=0, NoTrailingHalfEdit);
EXPORT WithinEditN(SALT311.StrType l,UNSIGNED1 ll, SALT311.StrType r,UNSIGNED1 rl,UNSIGNED1 d, UNSIGNED1 edit_threshold=0,UNSIGNED1 mode=alg.Standard, BOOLEAN edFunction(SALT311.StrType l,UNSIGNED1 ll, SALT311.StrType r,UNSIGNED1 rl,UNSIGNED1 d,UNSIGNED1 mode) = SALT311.fn_EditDistance) := 
        SALT311.WithinEditNew(l, ll, r, rl, d, edit_threshold, mode, edFunction);
EXPORT MatchThreshold := 40;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
EXPORT JoinLimit := 10000;
// Configuration of individual fields
EXPORT sbfe_id_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT Lgid3IfHrchy_Force := 0; 
EXPORT company_name_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT cnp_number_Force := 0; 
EXPORT cnp_number_OR1_sbfe_id_Force := 0;
EXPORT active_duns_number_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT duns_number_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT duns_number_concept_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT company_fein_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT company_inc_state_Force := 0; 
EXPORT company_inc_state_OR1_active_duns_number_Force := 0;
EXPORT company_inc_state_OR2_duns_number_Force := 0;
EXPORT company_inc_state_OR3_duns_number_concept_Force := 0;
EXPORT company_inc_state_OR4_company_fein_Force := 0;
EXPORT company_inc_state_OR5_sbfe_id_Force := 0;
END;
