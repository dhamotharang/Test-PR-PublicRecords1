IMPORT SALT37;
EXPORT Config := MODULE,VIRTUAL
// The wildcard match function currently being used
EXPORT WildMatch(SALT37.StrType src,SALT37.StrType Pat,BOOLEAN _NoCase) := SALT37.WildMatch(src,Pat,_NoCase);
EXPORT WildPenalty := 2.0; // Higher number means wild matches get lower scores.
EXPORT DoSliceouts := TRUE; // If set to false slice-outs do not occur (saves time)
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT AttrValueType := SALT37.AttrValueType;
EXPORT MaxChildren := 100; // Maximum children allowed for a MULTIPLE(,LIST)
alg := ENUM(UNSIGNED1, Standard=0, NoTrailingHalfEdit);
EXPORT WithinEditN(SALT37.StrType l,UNSIGNED1 ll, SALT37.StrType r,UNSIGNED1 rl,UNSIGNED1 d, UNSIGNED1 edit_threshold=0,UNSIGNED1 mode=alg.Standard, BOOLEAN edFunction(SALT37.StrType l,UNSIGNED1 ll, SALT37.StrType r,UNSIGNED1 rl,UNSIGNED1 d,UNSIGNED1 mode) = SALT37.fn_EditDistance) := 
        SALT37.WithinEditNew(l, ll, r, rl, d, edit_threshold, mode, edFunction);
EXPORT MatchThreshold := 40;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
EXPORT MeowPrefetch := 20; //Number of transforms called at once
EXPORT ExternalFilePrefetch := 30; //Number of transforms called at once
EXPORT LinkpathCandidateCount := 50; // Number of candidates to consider from each linkpath in batch. Higher = better result and slower execution.
EXPORT meow_dedup := 'AUTO'; // Values: ALWAYS, NEVER, or anything else to automatically decide what to dedup from MEOW inputs
 
EXPORT MAC_MEOW_xIDL_Batch_Wrapper(infile,Ref='',Input_DID = '',Input_SNAME = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_DERIVED_GENDER = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_CITY = '',Input_ST = '',Input_ZIP = '',Input_SSN5 = '',Input_SSN4 = '',Input_DOB = '',Input_PHONE = '',Input_DL_STATE = '',Input_DL_NBR = '',Input_SRC = '',Input_SOURCE_RID = '',Input_DT_FIRST_SEEN = '',Input_DT_LAST_SEEN = '',Input_DT_EFFECTIVE_FIRST = '',Input_DT_EFFECTIVE_LAST = '',Input_MAINNAME = '',Input_FULLNAME = '',Input_ADDR1 = '',Input_LOCALE = '',Input_ADDRESS = '',Input_fname2 = '',Input_lname2 = '',OutFile,AsIndex='true',UpdateIDs='false',Stats='', Input_disableForce = 'false') := MACRO
	InsuranceHeader_xLink.MAC_MEOW_xIDL_Batch(infile,Ref,Input_DID,Input_SNAME,Input_FNAME,Input_MNAME,Input_LNAME,Input_DERIVED_GENDER,Input_PRIM_RANGE,Input_PRIM_NAME,Input_SEC_RANGE,Input_CITY,Input_ST,Input_ZIP,Input_SSN5,Input_SSN4,Input_DOB,Input_PHONE,Input_DL_STATE,Input_DL_NBR,Input_SRC,Input_SOURCE_RID,Input_DT_FIRST_SEEN,Input_DT_LAST_SEEN,Input_DT_EFFECTIVE_FIRST,Input_DT_EFFECTIVE_LAST,Input_MAINNAME,Input_FULLNAME,Input_ADDR1,Input_LOCALE,Input_ADDRESS,Input_fname2,Input_lname2,OutFile,AsIndex,UpdateIDs,Stats, Input_disableForce);
ENDMACRO;
EXPORT KeyInfix := KeyInfix;
EXPORT KeyInfix_specificities := KeyInfix;
EXPORT JoinLimit := 10000;
// Configuration of individual fields
EXPORT SSN5_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT SSN4_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT DOB_Force := 3;
EXPORT DOB_NotUseForce := IF (Environment.Current=Environment.Values.ALPHA, TRUE, FALSE)/*HACK01a*/; 
EXPORT DOB_OR1_SSN5_Force := 0;
EXPORT DOB_OR2_SSN4_Force := 0;
EXPORT DOB_UseGenerationForce := TRUE;
EXPORT MAINNAME_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
 
EXPORT PayloadKeyName :=  InsuranceHeader_xLink.KeyNames().header_super;/*HACK01b*/;
h := DATASET([],Layout_InsuranceHeader);
d := DATASET([],RECORDOF(h));
 
EXPORT PayloadKey := INDEX(d,{DID},{d},PayloadKeyName,OPT);
EXPORT MaxMergeFiles := 100;
// Configuration of linkpath atmost/limit thresholds
EXPORT NAME_MAXBLOCKSIZE:=500;
EXPORT NAME_MAXBLOCKLIMIT:=500;
EXPORT ADDRESS_MAXBLOCKSIZE:=5000;
EXPORT ADDRESS_MAXBLOCKLIMIT:=5000;
EXPORT SSN_MAXBLOCKSIZE:=5000;
EXPORT SSN_MAXBLOCKLIMIT:=5000;
EXPORT SSN4_MAXBLOCKSIZE:=5000;
EXPORT SSN4_MAXBLOCKLIMIT:=5000;
EXPORT DOB_MAXBLOCKSIZE:=5000;
EXPORT DOB_MAXBLOCKLIMIT:=5000;
EXPORT DOBF_MAXBLOCKSIZE:=5000;
EXPORT DOBF_MAXBLOCKLIMIT:=5000;
EXPORT ZIP_PR_MAXBLOCKSIZE:=5000;
EXPORT ZIP_PR_MAXBLOCKLIMIT:=5000;
EXPORT SRC_RID_MAXBLOCKSIZE:=5000;
EXPORT SRC_RID_MAXBLOCKLIMIT:=5000;
EXPORT DLN_MAXBLOCKSIZE:=5000;
EXPORT DLN_MAXBLOCKLIMIT:=5000;
EXPORT PH_MAXBLOCKSIZE:=5000;
EXPORT PH_MAXBLOCKLIMIT:=5000;
EXPORT LFZ_MAXBLOCKSIZE:=5000;
EXPORT LFZ_MAXBLOCKLIMIT:=5000;
EXPORT RELATIVE_MAXBLOCKSIZE:=5000;
EXPORT RELATIVE_MAXBLOCKLIMIT:=5000;
EXPORT INTEGER FNAME_LENGTH_EDIT2 := 6; // fname length to use edit2 
EXPORT INTEGER LNAME_LENGTH_EDIT2 := 8; // lname length to use edit2 
EXPORT NAME_WEIGHT := 0.8; 
EXPORT ADDR_WEIGHT := 1.0; /*HACK01c*/
END;
