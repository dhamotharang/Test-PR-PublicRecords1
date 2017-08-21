EXPORT CleanUpLogicalReport(string lClusterFilter='thor400_30') := function
return
			apply(CleanUpLogicalSearch(lClusterFilter),fileservices.sendemail(
																													email
																													,CleanUpLogicalConstants(lClusterFilter).subj
																													,CleanUpLogicalConstants(lClusterFilter).p1 + trim(spaceUsed) + ' bytes\n\n'
																													+CleanUpLogicalConstants(lClusterFilter).p2
																													+cmd
																													,
																													,
																													,'julianne.franzer@lexisnexis.com'
																																				)
				  	);

end;