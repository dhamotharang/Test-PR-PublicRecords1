IMPORT GlobalWatchLists;

ds := GlobalWatchLists.File_GlobalWatchLists;

dist := distribute(ds,hash(pty_key));

ds1 := distribute(pull(GlobalWatchLists.Key_GlobalWatchLists_Key()),hash(pty_key));

j1 := join (dist,ds1,
           left.pty_key=right.pty_key AND
					 (left.orig_pty_name = right.orig_pty_name OR
					 left.orig_vessel_name = right.orig_pty_name),
					 transform(GlobalWatchLists.Layout_GlobalWatchLists,self := left),
					 left only,local);
					 
MissingRecs	:= count(j1);

EXPORT ValidateBase_to_key := IF(MissingRecs > 0, FAIL(MissingRecs + ' Records missing from GlobalWatchLists_key'))
															: SUCCESS(output('ALL GLOBAL WATCH LISTS BASE RECORDS FOUND IN KEY')),
																FAILURE(output(MissingRecs + ' GLOBAL WATCH LISTS RECORDS MISSING FROM KEY'));