import ut,header,did_regression;
#workunit('name','BDID Regression');
#option ('spillMultiCondition', true);
#stored('did_add_force','thor'); // remove or set to 'roxi' to put recs through roxie

old := bdid_regression.File_Control;
new := bdid_regression.Common_BDID : persist('persist::bdid_regression');
output(new,,'BASE::BDID_Regression_Common_DID' + bdid_regression.version, overwrite);

//****** COMPARE THE MATCHES BY RID -> DID
did_regression.MAC_DID_Diff(old, new, bdid, did_diff, rid, bdid_score, 75)

output(did_diff,,'BASE::BDID_Regression_Full_Diff' + bdid_regression.version, overwrite);



//THIS CODE HAS NOT BEEN CONVERTED YET, BUT SHOULD BE JUST FILENAME FOR FIRST BIT
//MAC_CHECK_SHIFTS MAY NEED ANOTHER PARM TO ACCEPT BIZ HEADER FILE
//did_diff := dataset('BASE::BDID_Regression_Full_Diff' + bdid_regression.version, bdid_regression.Layout_DID_Diff_full, flat);
i := 1000;
output(choosen(did_diff(what_happened = 'error in mac_did_diff'), i), NAMED('error'));
output(choosen(did_diff(what_happened = 'gained'), i), NAMED('gained'));
output(choosen(did_diff(what_happened = 'lost'), i), NAMED('lost'));
output(choosen(did_diff(what_happened = 'lost insig'), i), NAMED('lost_insig'));

ss := did_diff(what_happened= 'shift sig');
did_regression.mac_check_shifts(ss,so,rcid,bdid,business_header.File_Business_Header)
output(choosen(so,i));

// this is the old 'shift sig', replaced above.
//output(choosen(did_diff(what_happened = 'shift sig'), i));

//output(choosen(did_diff(what_happened = 'DID same - score up'), i));
//output(choosen(did_diff(what_happened = 'DID same - score down'), i));
//output(choosen(did_diff(what_happened = 'shift insig'), i));
