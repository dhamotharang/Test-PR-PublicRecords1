// test with suppression 
// to test this, run with just the modified code in doxie/lookups.ecl (and comment out the original code)

import RoxieKeyBuild, Doxie;

string filedate := '20200716_suppression_test_true';

RoxieKeyBuild.Mac_SK_BuildProcess_Local(Doxie.Key_Did_Lookups_v2,'~thor_data400::key::header::'+filedate+'::lookups_v2','',build_); // builds the key 

sequential(build_);

// this produces a file that is used for input for logicalKeysCompare.ecl
