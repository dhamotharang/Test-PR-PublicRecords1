// Used to write text to attributes in the repository.

EXPORT UpdateAttributeText(string modulename, string attributename, string text) := FUNCTION
	
	SaveAttributeRequest := record
		string ModuleName{xpath('ModuleName')};
		string AttributeName{xpath('AttributeName')} ;
		string Text{xpath('Text')} ;
	end;
	
	myds := dataset([{modulename,attributename,text}],SaveAttributeRequest);
	
	ECLAttribute := Record
		string ModuleName{xpath('ModuleName')};
		string Name{xpath('Name')}; 
		string Type{xpath('Type')};
	end;
	
	SaveAttributesRec := Record
		Dataset(SaveAttributeRequest) Attributes{xpath('Attributes/SaveAttributeRequest')} := myds;
	End;

	UpdateAttributesResponse := record
		dataset(ECLAttribute) outAttributes{xpath('outAttributes/ECLAttribute')};
	end;
	
	result := SOAPCALL('http://10.241.12.204:8145/WsAttributes',
					'SaveAttributes',
					SaveAttributesRec,
					ECLAttribute,
					xpath('UpdateAttributesResponse')
				);
	return result;

END;