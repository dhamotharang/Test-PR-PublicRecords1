import did_regression, header;
#workunit('name', 'Relative Regression');
//set relative_regression.file_relatives_old;
//set relative_regression.file_relatives_new;

//these are the DID's i deemed interesting in the header regression test
old := relative_regression.old_recs;
new := relative_regression.new_recs;


'COUNTS BY SCORE';
a := output(choosen(relative_regression.counts_by_score, 1000),named('COUNTS_BY_SCORE'));

//counts_by_did tells what has happened to each DIDs relatives...see below for interpretation of shift
did_counts := relative_regression.counts_by_did;

counts_report_rec := record
	did_counts.shift;
	integer counted := count(group);
end;

counts_by_shift := table(did_counts, counts_report_rec, shift);
'COUNTS BY SHIFT';
b := output(counts_by_shift, named('COUNTS_BY_SHIFT'));

old_valid := old(number_cohabits >= 6);
new_valid := new(number_cohabits >= 6);

relative_regression.MAC_Pull_By_Shift(did_counts, old_valid, new_valid, did, person1, person2, 'UP', 100, upolds, upnews, uplost, upgain)
'UP';	//here we are working with the people whose relative count went UP
c := output(choosen(upgain, 9000), named('NEW_RELATIVES'));		//all of the recs that are in new but not in old


relative_regression.MAC_Pull_By_Shift(did_counts, old_valid, new_valid, did, person1, person2,'DOWN', 100, downolds, downnews, downlost, downgain)
'DOWN';	//here we are working with the people whose relative count went DOWN
d := output(choosen(downlost, 9000),named('LOST_RELATIVES'));	//all of the recs that are in old and not in new

export BWR_Regression_Relatives := parallel(a,b,c,d);