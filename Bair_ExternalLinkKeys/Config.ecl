IMPORT SALT33;
EXPORT Config := MODULE,VIRTUAL
EXPORT DoSliceouts := TRUE; // If set to false slice-outs do not occur (saves time)
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT AttrValueType := SALT33.AttrValueType;
EXPORT MaxChildren := 100; // Maximum children allowed for a MULTIPLE(,LIST)
EXPORT MatchThreshold := 38;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
EXPORT LinkpathCandidateCount := 50; // Number of candidates to consider from each linkpath in batch. Higher = better result and slower execution.
EXPORT meow_dedup := 'AUTO'; // Values: ALWAYS, NEVER, or anything else to automatically decide what to dedup from MEOW inputs
 
EXPORT MAC_MEOW_PS_Batch_Wrapper(infile,Ref='',Input_NAME_SUFFIX = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_P_CITY_NAME = '',Input_ST = '',Input_ZIP = '',Input_DOB = '',Input_PHONE = '',Input_DL_ST = '',Input_DL = '',Input_LEXID = '',Input_POSSIBLE_SSN = '',Input_CRIME = '',Input_NAME_TYPE = '',Input_CLEAN_GENDER = '',Input_CLASS_CODE = '',Input_DT_FIRST_SEEN = '',Input_DT_LAST_SEEN = '',Input_DATA_PROVIDER_ORI = '',Input_VIN = '',Input_PLATE = '',Input_LATITUDE = '',Input_LONGITUDE = '',Input_SEARCH_ADDR1 = '',Input_SEARCH_ADDR2 = '',Input_MAINNAME = '',Input_FULLNAME = '',OutFile,AsIndex='true',Stats='') := MACRO
	Bair_ExternalLinkKeys.MAC_MEOW_PS_Batch(infile,Ref,Input_NAME_SUFFIX,Input_FNAME,Input_MNAME,Input_LNAME,Input_PRIM_RANGE,Input_PRIM_NAME,Input_SEC_RANGE,Input_P_CITY_NAME,Input_ST,Input_ZIP,Input_DOB,Input_PHONE,Input_DL_ST,Input_DL,Input_LEXID,Input_POSSIBLE_SSN,Input_CRIME,Input_NAME_TYPE,Input_CLEAN_GENDER,Input_CLASS_CODE,Input_DT_FIRST_SEEN,Input_DT_LAST_SEEN,Input_DATA_PROVIDER_ORI,Input_VIN,Input_PLATE,Input_LATITUDE,Input_LONGITUDE,Input_SEARCH_ADDR1,Input_SEARCH_ADDR2,Input_MAINNAME,Input_FULLNAME,OutFile,AsIndex,Stats);
ENDMACRO;
EXPORT KeyInfix := KeyInfix;
EXPORT JoinLimit := 10000;
// Configuration of individual fields
EXPORT DOB_Force := 3; 
EXPORT MAINNAME_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
// Configuration of external files
END;

