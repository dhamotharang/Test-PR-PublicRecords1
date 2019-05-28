import ut;
export getdfuinfo(string filename, string esp = '10.173.84.202') := function

	checkoutAttributeInRecord := record
		
		string Name{xpath('Name')} := filename;

	end;
	
	checkoutAttributeOutRecord := record,maxlength(30000)
		string fullxml{xpath('FileDetail/Ecl')};
	end;
	
	results := SOAPCALL('http://' + esp + ':8010/Wsdfu/?ver_=1.22', 'DFUInfo', 
											checkoutAttributeInRecord, checkoutAttributeOutRecord,
											
											xpath('DFUInfoResponse')
											,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
										 );

	return results;
	
end;
