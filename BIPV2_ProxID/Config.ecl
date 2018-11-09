IMPORT SALT311,STD;
EXPORT Config := MODULE,VIRTUAL
EXPORT DoSliceouts := false/*HACKConfig*/; // If set to false slice-outs do not occur (saves time)
EXPORT SliceDistance := 10;
EXPORT FastSlice := TRUE; // Set to false for a more aggressive mode of slicing
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT AttrValueType := SALT311.AttrValueType;
EXPORT PartitionFieldType := STRING2;
EXPORT KeysBitmapType := UNSIGNED4;
EXPORT KeysBitmapOffset := 16;
EXPORT MaxChildren := 100; // Maximum children allowed for a MULTIPLE(,LIST)
alg := ENUM(UNSIGNED1, Standard=0, NoTrailingHalfEdit);
EXPORT WithinEditN(SALT311.StrType l,UNSIGNED1 ll, SALT311.StrType r,UNSIGNED1 rl,UNSIGNED1 d, UNSIGNED1 edit_threshold=0,UNSIGNED1 mode=alg.Standard, BOOLEAN edFunction(SALT311.StrType l,UNSIGNED1 ll, SALT311.StrType r,UNSIGNED1 rl,UNSIGNED1 d,UNSIGNED1 mode) = SALT311.fn_EditDistance) := 
        SALT311.WithinEditNew(l, ll, r, rl, d, edit_threshold, mode, edFunction);
EXPORT MatchThreshold := 30;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
EXPORT JoinLimit := 10000;
// Configuration of individual fields
EXPORT active_duns_number_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT active_enterprise_number_Force := 0; 
EXPORT active_domestic_corp_key_Force := 0; 
EXPORT company_fein_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT cnp_name_Force := 6; 
EXPORT cnp_name_OR1_active_domestic_corp_key_Force := 0;
EXPORT cnp_name_OR2_active_duns_number_Force := 0;
EXPORT cnp_name_OR3_company_fein_Force := 0;
EXPORT cnp_number_Force := 0; 
EXPORT prim_name_derived_Force := 5; 
EXPORT st_Force := 0; 
EXPORT prim_range_derived_Force := 0; 
EXPORT company_csz_Force := -2; 
EXPORT company_address_Force := 0; 
END;
