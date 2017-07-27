export sexualoffenderimage := MODULE
			
export t_SexualOffenderImageSearchBy := record
	string ImageLink {xpath('ImageLink')};
	string StateCode {xpath('StateCode')};
end;
		
export t_SexualOffenderImageSearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
end;
		
export t_SexualOffenderImageSearchRecord := record
	string Identifier {xpath('Identifier')};
	string Type {xpath('Type')};
	string Image {xpath('Image')};
end;
		
export t_SexualOffenderImageSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_SexualOffenderImageSearchRecord _Record {xpath('Record')};
end;
		
export t_SexualOffenderImageSearchRequest := record (share.t_BaseRequest)
	t_SexualOffenderImageSearchOption Options {xpath('Options')};
	t_SexualOffenderImageSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_SexualOffenderImageSearchResponseEx := record
	t_SexualOffenderImageSearchResponse response {xpath('response')};
end;
		

end;

