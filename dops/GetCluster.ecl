EXPORT GetCluster(string logicalname, string esp) := function
	checkoutAttributeInRecord := record
		
		string LogicalName{xpath('LogicalName')} := logicalname;

	end;
	
	checkoutAttributeOutRecord := record,maxlength(30000)
		string cluster{xpath('DFULogicalFile/ClusterName')};
	end;
	
	results := SOAPCALL('http://'+ esp +':8010/Wsdfu', 'DFUQuery', 
											checkoutAttributeInRecord, checkoutAttributeOutRecord,
											
											xpath('DFUQueryResponse/DFULogicalFiles')
										 );

	return results;
end;