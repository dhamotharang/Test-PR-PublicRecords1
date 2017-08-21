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
EXPORT MatchThreshold := 38;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
EXPORT MeowPrefetch := 20; //Number of transforms called at once
EXPORT ExternalFilePrefetch := 30; //Number of transforms called at once
EXPORT LinkpathCandidateCount := 50; // Number of candidates to consider from each linkpath in batch. Higher = better result and slower execution.
EXPORT meow_dedup := 'AUTO'; // Values: ALWAYS, NEVER, or anything else to automatically decide what to dedup from MEOW inputs
 
EXPORT MAC_MEOW_PS_Batch_Wrapper(infile,Ref='',Input_NAME_SUFFIX = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_P_CITY_NAME = '',Input_ST = '',Input_ZIP = '',Input_DOB = '',Input_PHONE = '',Input_DL_ST = '',Input_DL = '',Input_LEXID = '',Input_POSSIBLE_SSN = '',Input_CRIME = '',Input_NAME_TYPE = '',Input_CLEAN_GENDER = '',Input_CLASS_CODE = '',Input_DT_FIRST_SEEN = '',Input_DT_LAST_SEEN = '',Input_DATA_PROVIDER_ORI = '',Input_VIN = '',Input_PLATE = '',Input_LATITUDE = '',Input_LONGITUDE = '',Input_SEARCH_ADDR1 = '',Input_SEARCH_ADDR2 = '',Input_CLEAN_COMPANY_NAME = '',Input_MAINNAME = '',Input_FULLNAME = '',OutFile,AsIndex='true',Stats='', Input_disableForce = 'false') := MACRO
	Bair_ExternalLinkKeys_V2.MAC_MEOW_PS_Batch(infile,Ref,Input_NAME_SUFFIX,Input_FNAME,Input_MNAME,Input_LNAME,Input_PRIM_RANGE,Input_PRIM_NAME,Input_SEC_RANGE,Input_P_CITY_NAME,Input_ST,Input_ZIP,Input_DOB,Input_PHONE,Input_DL_ST,Input_DL,Input_LEXID,Input_POSSIBLE_SSN,Input_CRIME,Input_NAME_TYPE,Input_CLEAN_GENDER,Input_CLASS_CODE,Input_DT_FIRST_SEEN,Input_DT_LAST_SEEN,Input_DATA_PROVIDER_ORI,Input_VIN,Input_PLATE,Input_LATITUDE,Input_LONGITUDE,Input_SEARCH_ADDR1,Input_SEARCH_ADDR2,Input_CLEAN_COMPANY_NAME,Input_MAINNAME,Input_FULLNAME,OutFile,AsIndex,Stats, Input_disableForce);
ENDMACRO;
EXPORT KeyInfix := KeyInfix;
EXPORT JoinLimit := 10000;
// Configuration of individual fields
EXPORT LNAME_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT DOB_Force := 3; 
// Configuration of linkpath atmost/limit thresholds
EXPORT NAME_MAXBLOCKSIZE:=500;
EXPORT NAME_MAXBLOCKLIMIT:=10000;
EXPORT ADDRESS_MAXBLOCKSIZE:=5000;
EXPORT ADDRESS_MAXBLOCKLIMIT:=10000;
EXPORT DOB_MAXBLOCKSIZE:=5000;
EXPORT DOB_MAXBLOCKLIMIT:=10000;
EXPORT ZIP_PR_MAXBLOCKSIZE:=5000;
EXPORT ZIP_PR_MAXBLOCKLIMIT:=10000;
EXPORT DLN_MAXBLOCKSIZE:=5000;
EXPORT DLN_MAXBLOCKLIMIT:=10000;
EXPORT PH_MAXBLOCKSIZE:=5000;
EXPORT PH_MAXBLOCKLIMIT:=10000;
EXPORT LFZ_MAXBLOCKSIZE:=5000;
EXPORT LFZ_MAXBLOCKLIMIT:=10000;
EXPORT VIN_MAXBLOCKSIZE:=5000;
EXPORT VIN_MAXBLOCKLIMIT:=10000;
EXPORT LEXID_MAXBLOCKSIZE:=5000;
EXPORT LEXID_MAXBLOCKLIMIT:=10000;
EXPORT SSN_MAXBLOCKSIZE:=5000;
EXPORT SSN_MAXBLOCKLIMIT:=10000;
EXPORT LATLONG_MAXBLOCKSIZE:=5000;
EXPORT LATLONG_MAXBLOCKLIMIT:=10000;
EXPORT PLATE_MAXBLOCKSIZE:=5000;
EXPORT PLATE_MAXBLOCKLIMIT:=10000;
EXPORT COMPANY_MAXBLOCKSIZE:=5000;
EXPORT COMPANY_MAXBLOCKLIMIT:=10000;
END;

