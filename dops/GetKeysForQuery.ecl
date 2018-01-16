/*
  GetKeysForQuery
    Gets the keys used by a query.  returns the logical names, superkey names and the sizes and counts.
  
  Example:
    dops.GetKeysForQuery('BizLinkFull.svcBatch','B','Q','N');
*/
EXPORT GetKeysForQuery(
   string pdatasetname  // Query name or '*' to get all queries
  ,string plocation     // 'B' - Boca   , 'A' - Alpharetta
  ,string penvironment  // 'Q' - QA     , 'P' - Prod
  ,string pcluster      // 'N' - Nonfcra, 'F' - FCRA        , 'S' - Customer Supp, 'T' - Customer Test, 'FS' - FCRA Cust Support
	,string dopsenv = dops.constants.dopsenvironment
) := 
function

	InputRec := 
  record
		string queryName    {xpath('queryName'    )} := pdatasetname  ;
		string location     {xpath('location'     )} := plocation     ;
		string environment  {xpath('environment'  )} := penvironment  ;
		string cluster      {xpath('cluster'      )} := pcluster      ;
	end;
	
  roxielist_rec := 
  record
    string superkey   {xpath('superkey'  )};
    string logicalkey {xpath('logicalkey')};
    string dname      {xpath('dname'     )};
    string errormsg   {xpath('errormsg'  )};
    string count_     {xpath('count'     )};
    string size_      {xpath('size'      )};
		string queryname	{xpath('queryname')}
  end;
	
	soapresults := SOAPCALL(
				 dops.constants.prboca.serviceurl(dopsenv,pcluster)
				,'GetKeysForQuery'
				,InputRec
				,dataset(roxielist_rec)
				,xpath('GetKeysForQueryResponse/GetKeysForQueryResult/roxielist')
				,NAMESPACE('http://lexisnexis.com/')
				,LITERAL
				,SOAPACTION('http://lexisnexis.com/GetKeysForQuery')
  );
				
	return soapresults;
end;
										