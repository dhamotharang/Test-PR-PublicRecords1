EXPORT fn_report(string lClusterFilter='thor400_30') := function
return
			// fn_search(lClusterFilter);
			apply(fn_search(lClusterFilter),fileservices.sendemail(
											email
											,_Constants(lClusterFilter).subj
											,_Constants(lClusterFilter).p1 + trim(spaceUsed) + ' bytes\n\n'
											+_Constants(lClusterFilter).p2
											+cmd
											,
											,
											,'valerie.minnis@lexisnexis.com'
											)
								);
end;