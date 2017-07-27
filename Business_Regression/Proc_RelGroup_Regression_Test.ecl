import did_regression,relative_regression, header;
#workunit('name', 'Business Relative Regression');

//these are the DID's i deemed interesting in the header regression test
old := relgroup_sample_old;
new := relgroup_sample_new;


'COUNTS BY SCORE';
a := output(choosen(relgroup_counts_by_type, 1000),named('GROUP_COUNTS_BY_TYPE'));

//counts_by_did tells what has happened to each DIDs relatives...see below for interpretation of shift
bdid_counts := Relgroup_Counts_By_BDID;

counts_report_rec := record
	bdid_counts.shift;
	integer counted := count(group);
end;

counts_by_shift := table(bdid_counts, counts_report_rec, shift);
'COUNTS BY SHIFT';
b := output(counts_by_shift, named('GROUP_COUNTS_BY_SHIFT'));

old_valid := old;
new_valid := new;

relative_regression.MAC_Pull_By_Shift(bdid_counts, old_valid, new_valid, bdid, bdid, bdid, 'UP', 100, upolds, upnews, uplost, upgain)
'UP';	//here we are working with the people whose relative count went UP
c := output(choosen(upgain, 9000), named('GROUP_NEW_RELATIVES'));		//all of the recs that are in new but not in old


relative_regression.MAC_Pull_By_Shift(bdid_counts, old_valid, new_valid, bdid, bdid, bdid, 'DOWN', 100, downolds, downnews, downlost, downgain)
'DOWN';	//here we are working with the people whose relative count went DOWN
d := output(choosen(downlost, 9000),named('GROUP_LOST_RELATIVES'));	//all of the recs that are in old and not in new

export Proc_RelGroup_Regression_Test := parallel(a,b,c,d);