Layout_DID_Test_Debug := RECORD
integer4 temp_ID;
unsigned1 did_score;
unsigned1 pg_score;
string6 dob_YYYYMM;
Layout_DID_Test_Match;
END;


EXPORT File_DID_Test_Debug := DATASET('TMTEMP::DID_Test_Debug', Layout_DID_Test_Debug, THOR);