import ut, business_header, relative_regression;
#workunit('name', 'Business Contact Regression');

old := business_Regression.BC_sample_old;
new := business_regression.BC_sample_new;
									
//get counts by BDID for each file, see how many companies gained contacts, how many lost
bdid_counts := bc_Counts_By_BDID;

counts_report_rec := record
	bdid_counts.shift;
	integer counted := count(group);
end;

counts_by_shift := table(bdid_counts, counts_report_rec, shift);
b := output(counts_by_shift, named('COUNTS_BY_SHIFT'));

//show all contacts of big gainers and big losers
//well, for now, at least, just show a sample of gainers and losers

relative_regression.MAC_Pull_By_Shift(bdid_counts, old, new, bdid, bdid, did, 'UP', 100, upolds, upnews, uplost, upgain)
'UP';	//here we are working with the people whose relative count went UP
c := output(choosen(upgain, 9000), named('NEW_CONTACTS'));		//all of the recs that are in new but not in old


relative_regression.MAC_Pull_By_Shift(bdid_counts, old, new, bdid, bdid, did, 'DOWN', 100, downolds, downnews, downlost, downgain)
'DOWN';	//here we are working with the people whose relative count went DOWN
d := output(choosen(downlost, 9000),named('LOST_CONTACTS'));	//all of the recs that are in old and not in new

export Proc_BC_Regression_Test := parallel(b,c,d);