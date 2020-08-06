// test with no suppression 
// to test this, run with just the original code in doxie/lookups.ecl (and leave the modified code commented out)
import RoxieKeyBuild, Doxie;

string filedate := '20200716_suppression_test_false';

RoxieKeyBuild.Mac_SK_BuildProcess_Local(Doxie.Key_Did_Lookups_v2,'~thor_data400::key::header::'+filedate+'::lookups_v2','',build_); // builds the key 

sequential(build_);

// this produces a file that is used for input for logicalKeysCompare.ecl
