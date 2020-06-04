IMPORT SALT311,STD;
EXPORT Config := MODULE,VIRTUAL
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
EXPORT MatchThreshold := 45;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
EXPORT MeowPrefetch := 20; //Number of transforms called at once
EXPORT ExternalFilePrefetch := 30; //Number of transforms called at once
EXPORT LinkpathCandidateCount := 50; // Number of candidates to consider from each linkpath in batch. Higher = better result and slower execution.
EXPORT STRING meow_dedup := 'AUTO'; // Values: ALWAYS, NEVER, or anything else to automatically decide what to dedup from MEOW inputs
 
EXPORT MAC_MEOW_XNOMATCH_Batch_Wrapper(infile,Ref='',Input_nomatch_id = '',Input_SRC = '',Input_SSN = '',Input_DOB = '',Input_LEXID = '',Input_SUFFIX = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_GENDER = '',Input_PRIM_NAME = '',Input_PRIM_RANGE = '',Input_SEC_RANGE = '',Input_CITY_NAME = '',Input_ST = '',Input_ZIP = '',Input_DT_FIRST_SEEN = '',Input_DT_LAST_SEEN = '',Input_MAINNAME = '',Input_ADDR1 = '',Input_LOCALE = '',Input_ADDRESS = '',Input_FULLNAME = '',OutFile,AsIndex = 'true',In_UpdateIDs = 'false',Stats = '',Input_disableForce = 'false',DoClean = 'true') := MACRO
	HealthcareNoMatchHeader_ExternalLinking.MAC_MEOW_XNOMATCH_Batch(infile,Ref,Input_nomatch_id,Input_SRC,Input_SSN,Input_DOB,Input_LEXID,Input_SUFFIX,Input_FNAME,Input_MNAME,Input_LNAME,Input_GENDER,Input_PRIM_NAME,Input_PRIM_RANGE,Input_SEC_RANGE,Input_CITY_NAME,Input_ST,Input_ZIP,Input_DT_FIRST_SEEN,Input_DT_LAST_SEEN,Input_MAINNAME,Input_ADDR1,Input_LOCALE,Input_ADDRESS,Input_FULLNAME,OutFile,AsIndex,In_UpdateIDs,Stats,Input_disableForce,DoClean);
ENDMACRO;
EXPORT JoinLimit := 10000;
// Configuration of individual fields
EXPORT DOB_Force := 3; 
EXPORT DOB_UseGenerationForce := TRUE;
EXPORT FNAME_Force := 0; 
EXPORT MAINNAME_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
// Configuration of linkpath atmost/limit thresholds
EXPORT NOMATCH_MAXBLOCKSIZE:=10000;
EXPORT NOMATCH_MAXBLOCKLIMIT:=10000;
END;
