
IMPORT PRTE2_X_Ins_PropertyScramble as SCR;

DS := SCR.Files.XRef_Enhanced_SF_DS;
// DSO := DS(is_property='Y' AND prim_range='');
DSO := DS(SSN='');
OUTPUT(CHOOSEN(DSO,1000));
OUTPUT(COUNT(DSO));

//   2/9/2015 - found 499 failures