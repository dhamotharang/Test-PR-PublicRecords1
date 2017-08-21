import ut,header;
#workunit('name','DID Regression');
#option ('spillMultiCondition', true);
#stored('did_add_force','thor'); // remove or set to 'roxi' to put recs through roxie
#stored('production',false);  //set to true if running regression on prod slimsorts

old := did_regression.File_Control;
new := did_regression.Common_DID : persist('persist::regression');
output(new,,'BASE::DID_Regression_Common_DID' + did_regression.version, overwrite);

//****** COMPARE THE MATCHES BY RID -> DID
did_regression.MAC_DID_Diff(old, new, did, did_diff)

output(did_diff,,'BASE::DID_Regression_Full_Diff' + did_regression.version, overwrite);
