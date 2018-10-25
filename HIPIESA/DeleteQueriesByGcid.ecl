#OPTION('soapTraceLevel', '8');
IMPORT hipie_ecl;
IMPORT STD;
IMPORT STD.Str;

EXPORT DeleteQueriesByGcid(	string pGcID, 
													unsigned pNumberOfQueriesToKeep = 3, 
														string pRoxiePublishUrl = 'http://10.173.10.159:8010/',
														string pRoxieCluster = 'roxie' ) := FUNCTION

//STRING InternalRoxieServiceUrl  := 'http://10.173.22.201:9876/roxie/' : STORED('InternalRoxieServiceUrl'); //Dev	
//STRING InternalRoxieServiceUrl  := 'http://rampsroxieinternal.risk.regn.net:9876/roxie/' : STORED('InternalRoxieServiceUrl'); //Prod/DR DNS!
//STRING InternalRoxieServiceUrl  := 'http://10.176.71.40:9876/roxie/' : STORED('InternalRoxieServiceUrl'); //PROD IP
//STRING InternalRoxieServiceUrl  := 'http://10.191.25.4:9876/roxie/' : STORED('InternalRoxieServiceUrl'); // DR IP
//STRING InternalRoxieServiceUrl  := 'http://10.173.22.132:9876/roxie/' : STORED('InternalRoxieServiceUrl'); //Cert
//STRING InternalRoxieServiceUrl  := 'http://10.241.100.157:8002/';
//STRING InternalRoxieServiceUrl  := 'http://10.173.22.132:9876/roxie/'
//RoxiePublishUrl := 'http://ramps_dev_svc:Lexis2016@10.241.100.159:8010/';

	unsigned SleepDelay := 90;

	FindSAQueriesByGcID(string v_gcid) := FUNCTION
		searchStartsWith :='hipiesa.search_'  + v_gcid + '_';	 
		queryName := 'hipiesa*';		
		findResult:= hipie_ecl.FN_FindQuery(queryName, pRoxiePublishUrl, pRoxieCluster); 
		fResult := findResult( std.Str.StartsWith(name, searchStartsWith) );
		return fResult;
	END;

	saQueries := FindSAQueriesByGcID(pGcID);

	//find queries that aren't the most recent 3 (pNumberOfQueriesToKeep)
	sort1 := SORT(saQueries, -wuid);
	project1 := PROJECT(sort1, TRANSFORM({sort1, unsigned order}, SELF.ORDER := COUNTER; SELF := LEFT));

	//These are the queries we want to delete
	filter1 := project1( order > pNumberOfQueriesToKeep) : INDEPENDENT;
	
	//This will delete the queries from filter1
	deleteQueryAction := APPLY( filter1, hipie_ecl.FN_DeleteQuery(name, pRoxiePublishUrl, pRoxieCluster, id));

	sleepAction := OUTPUT(hipie_ecl.utils.sleep( SleepDelay ),NAMED('WAIT_90_SECS_FOR_SDS_LOCK_RELEASE'));

	doDeleteFiles(string queryName) := FUNCTION
		splitArgs := Str.SplitWords(queryName, '_');
		
		vGcID := splitArgs[2];
		vJobID := splitArgs[3];
		
		fileName := '*sa::key*' + vGcID + '::' + vJobID;
		ds := hipie_ecl.fn_findFiles(pRoxiePublishUrl, fileName);

		queryFiles := SET(ds, name);
		publishendpointUrl := ds[1].fromespurl;
		deleteAction := hipie_ecl.FN_DeleteFiles(publishendpointUrl, queryFiles);
				
		return deleteAction;
	END;
	
	deleteFilesAction := APPLY( filter1, doDeleteFiles(name) );

	/* TODO
		For each result in filter1
			Use Name field ("hipiesa.search_128591_2018013002") to find index files
			Build a Delete Files action
			1) Use Apply to complete the action on many records
			or
			2) Aggregate the fn_FindFiles results to form one call to FN_DeleteFiles
	*/

	result := SEQUENTIAL(output(filter1), deleteQueryAction, sleepAction , deleteFilesAction);
	return result;
END;