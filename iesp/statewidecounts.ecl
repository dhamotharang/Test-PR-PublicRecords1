export statewidecounts := MODULE
			
export t_GetStatewideDocumentCountsSearchBy := record
	string Jurisdiction {xpath('Jurisdiction')};
	string UniqueId {xpath('UniqueId')};
	string BusinessId {xpath('BusinessId')};
end;
		
export t_GetStatewideDocumentCountsOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
end;
		
export t_SourceCount := record
	string SourceType {xpath('SourceType')};
	integer CountInJurisdiction {xpath('CountInJurisdiction')};
	integer CountOutJurisdiction {xpath('CountOutJurisdiction')};
end;
		
export t_GetStatewideDocumentCountsRecord := record
	dataset(t_SourceCount) SourceCounts {xpath('SourceCounts/Source'), MAXCOUNT(1)};
end;
		
export t_GetStatewideDocumentCountsResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_GetStatewideDocumentCountsRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_GetStatewideDocumentCountsRequest := record (share.t_BaseRequest)
	t_GetStatewideDocumentCountsSearchBy SearchBy {xpath('SearchBy')};
	t_GetStatewideDocumentCountsOption Options {xpath('Options')};
end;
		
export t_GetStatewideDocumentCountsResponseEx := record
	t_GetStatewideDocumentCountsResponse response {xpath('response')};
end;
		

end;

