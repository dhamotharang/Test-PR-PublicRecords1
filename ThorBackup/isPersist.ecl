import ut;
EXPORT isPersist(string filename, string esp) := function


checkoutAttributeInRecord := record
		
		string Name{xpath('Name')} := filename;

	end;
	
	checkoutAttributeOutRecord := record
		string ispersist{xpath('Persistent')};
	end;
	
	results := SOAPCALL('http://'+esp+':8010/Wsdfu', 'DFUInfo', 
											checkoutAttributeInRecord, checkoutAttributeOutRecord,
											
											xpath('DFUInfoResponse/FileDetail')
										 );
	
	
	
	return if(results.ispersist = '1',true,false);

end;