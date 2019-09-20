import _Control,ut;
export isCompressed(string filename) := function
	InputRec := record
		string Name{xpath('Name')} := filename;
		
	end;
	
	outrec := record,maxlength(50000)
		string keysxml {xpath('DFUInfoResponse/FileDetail/ZipFile')};
	end;
	
	
	
	soapresults :=  SOAPCALL(
				'http://'+ _control.ThisEnvironment.ESP_IPAddress +':8010/WsDfu',
				'DFUInfo',
				InputRec,
				outrec,
				LITERAL
				,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
				);
	
	return if (soapresults.keysxml = '1', true, false);
	

	
end;