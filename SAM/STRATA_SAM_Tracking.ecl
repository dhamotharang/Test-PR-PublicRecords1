import SAM, Statistics, strata;

export STRATA_SAM_Tracking(string filedate) := function 

ds := pull(SAM.key_linkID.key);
	//no grouping
Statistics.mac_Strata_Pops(ds,dNoGrouping);
strata.createXMLStats(dNoGrouping,'SAM','data',filedate,'Wenhong.Ma@lexisnexis.com',resultsNoGrouping,'View_Deprecated','Population');

	//group on state
	Statistics.mac_Strata_Pops(ds,dstate, 'state');
	strata.createXMLStats(dstate,'SAM','data',filedate,'Wenhong.Ma@lexisnexis.com',resultstate,'State_Deprecated','Population');

	return parallel(
								 resultsNoGrouping		
								,resultstate	);

END;

