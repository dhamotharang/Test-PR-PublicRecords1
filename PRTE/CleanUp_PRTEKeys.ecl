/*
Function to delete PRTE Keys.  This will be running on schedule
to cleanup old keys on THOR.
*/
import lib_stringlib, LIB_Date, ut;
EXPORT CleanUp_PRTEKeys(dataset({string filename}) allPRTEKeysPkg
												,Boolean yesDelete = False) := function

//Filter for PRTE keys on THOR which are over 10 days old.
OldPRTEKeysThor := fileservices.logicalfilelist('prte*key*')(LIB_Date.DaysApart(ut.getdate, regexreplace('-',modified[..10],'')) >= 10);  

get_rec := record
	string filename;
	string modified_dt;
end;

get_rec join_recs(OldPRTEKeysThor l, allPRTEKeysPkg r) := transform	
	self.filename := '~'+l.name;
	self.modified_dt := l.modified;
end;

get_recs_out := join(OldPRTEKeysThor, allPRTEKeysPkg,
		'~'+left.name = right.filename, 
		join_recs(left,right),
		left only,
		lookup): persist('~thor_data400::persist::pretekeys::cleanup_checkpoint');

get_rec existing_recs(OldPRTEKeysThor l, allPRTEKeysPkg r) := transform
		self.filename := '~'+l.name;
		self.modified_dt := l.modified;
end;
		
existing_out := join(OldPRTEKeysThor,allPRTEKeysPkg,'~'+trim(left.name,left,right) = right.filename,
										existing_recs(left,right),
										lookup);		

run_counts := sequential(output(count(OldPRTEKeysThor), named('Total_keys_on_Thor_older_than_10_days')),
									output(count(allPRTEKeysPkg),named('Total_keys_in_pkg')),
									output(count(existing_out),named('Total_in_pkg_on_thor')),
									output(count(get_recs_out),named('Total_keys_to_Delete')),
									);
									
doCleanUp := apply(get_recs_out,
									if (regexfind('prte',filename) and yesDelete = True ,sequential(output('Deleting ..' + filename),fileservices.deletelogicalfile(filename))));
									
doAll := sequential(run_counts,
										doCleanUp);

return doAll;									
end;