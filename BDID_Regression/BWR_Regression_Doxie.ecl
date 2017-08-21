import ut,header,did_regression;
#workunit('name','BDID Regression Doxie');
#option ('spillMultiCondition', true);

old := bdid_regression.File_Control_doxie;
new := bdid_regression.Common_BDID_doxie  : persist('persist::bdid_regression_doxie');
output(new,,'BASE::BDID_Regression_Common_DID_doxie' + bdid_regression.version, overwrite);

//****** COMPARE THE MATCHES BY RID -> DID
did_regression.MAC_DID_Diff(old, new, bdid, did_diff, rid, bdid_score, 75)

output(did_diff,,'BASE::BDID_Regression_Full_Diff_doxie' + bdid_regression.version, overwrite);



//did_diff := dataset('BASE::BDID_Regression_Full_Diff_doxie' + bdid_regression.version, bdid_regression.Layout_DID_Diff_full, flat);
i := 1000;
output(choosen(did_diff(what_happened = 'error in mac_did_diff'), i), NAMED('error'));
output(choosen(did_diff(what_happened = 'gained'), i), NAMED('gained'));
output(choosen(did_diff(what_happened = 'lost'), i), NAMED('lost'));
output(choosen(did_diff(what_happened = 'shift sig'), i), NAMED('shift_sig'));
output(choosen(did_diff(what_happened = 'lost insig'), i), NAMED('lost_insig'));

