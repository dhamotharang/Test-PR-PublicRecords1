IMPORT SALT37;
EXPORT Config := MODULE,VIRTUAL
/*---------------------------------------------------------------------------------------------------------------------------------------------*/
///////////////////////////////MODIFY FOLLOWING TWO PARAMETERS BEFORE RUNNING TESTS\\\\\\\\\\\\\\\
/*---------------------------------------------------------------------------------------------------------------------------------------------*/
EXPORT STRING PrefixMod := 'Reg_370'; //Modify this to change the output name of all files in the module
EXPORT UpdateSF := FALSE; //Change to FALSE if running a test to avoid updating the superfile and generating strata files
/*---------------------------------------------------------------------------------------------------------------------------------------------*/
////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\
/*---------------------------------------------------------------------------------------------------------------------------------------------*/
EXPORT Infix := PrefixMod + IF(PrefixMod > '', '::','') + 'InsuranceHeader_RemoteLinking';

EXPORT DoSliceouts := TRUE; // If set to false slice-outs do not occur (saves time)
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT AttrValueType := SALT37.AttrValueType;
EXPORT MaxChildren := 100; // Maximum children allowed for a MULTIPLE(,LIST)
alg := ENUM(UNSIGNED1, Standard=0, NoTrailingHalfEdit);
/*HACK-O-MATIC*/ EXPORT WithinEditN(SALT37.StrType l,UNSIGNED1 ll, SALT37.StrType r,UNSIGNED1 rl,UNSIGNED1 d, UNSIGNED1 edit_threshold=0,UNSIGNED1 mode=alg.NoTrailingHalfEdit, BOOLEAN edFunction(SALT37.StrType l,UNSIGNED1 ll, SALT37.StrType r,UNSIGNED1 rl,UNSIGNED1 d,UNSIGNED1 mode) = SALT37.fn_EditDistance) := 
        SALT37.WithinEditNew(l, ll, r, rl, d, edit_threshold, mode, edFunction);
EXPORT MatchThreshold := 46;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
EXPORT JoinLimit := 10000;
// Configuration of individual fields
EXPORT ADDRESS_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT SSN_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT FULLNAME_Force := -3; 
EXPORT FULLNAME_OR1_SSN_Force := 15;
EXPORT FULLNAME_OR1_DOB_Force := 5;
EXPORT FULLNAME_OR1_FNAME_Force := 0;
EXPORT FULLNAME_OR2_ADDRESS_Force := 15;
EXPORT FULLNAME_OR2_DOB_Force := 5;
EXPORT FULLNAME_OR2_FNAME_Force := 0;
EXPORT MAINNAME_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT DOB_Force := 3; 
EXPORT DOB_UseGenerationForce := TRUE;
EXPORT FNAME_Force := 0; 
// Configuration of linkpath atmost/limit thresholds
/*HACK-O-MATIC*/ EXPORT SSN_Score_Min_MAINNAME 	:= 1500;
/*HACK-O-MATIC*/ EXPORT DOB_Score_Min_MAINNAME 	:= 500;
/*HACK-O-MATIC*/ EXPORT DL_NBR_Score_Min_MAINNAME:= 1000;
/*HACK-O-MATIC*/ EXPORT SSN_Score_Min_SNAME 			:= 1500;
/*HACK-O-MATIC*/ EXPORT DOB_Score_Min_SNAME 			:= 500;
/*HACK-O-MATIC*/ EXPORT SSN_Score_Min_FULLNAME 	:= 1500;
/*HACK-O-MATIC*/ EXPORT DOB_Score_Min_FULLNAME 	:= 500;
/*HACK-O-MATIC*/ EXPORT Addr_Score_Min_FULLNAME 	:= 1500;
/*HACK-O-MATIC*/ EXPORT Mismatch_Score_DERIVED_GENDER	:= -5000;
/*HACK-O-MATIC*/ EXPORT Threshold_Score_SNAME					:= -2000;
/*HACK-O-MATIC*/ EXPORT Superfile_Name					:= '' : STORED('Superfile_Name');
END;
