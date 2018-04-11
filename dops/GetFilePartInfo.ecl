import ut, STD;
EXPORT GetFilePartInfo(string filename, string esp) := function


checkoutAttributeInRecord := record
		
		string Name{xpath('name')} := filename;

	end;
	
	checkoutAttributeOutRecord := record,maxlength(300000)
		string fullxml{xpath('xmlmap')};
	end;
	
	results := SOAPCALL('http://'+esp+':8010/Wsdfu', 'Savexml', 
											checkoutAttributeInRecord, checkoutAttributeOutRecord,
											
											xpath('SavexmlResponse')
										 );
	
	string_rec := record, maxlength(300000)
		string xmlline
	end;
	
	xmlds := dataset([{Std.Str.DecodeBase64(results.fullxml)}],string_rec);
	
	crc_rec := record
		string partnumber := xmltext('@num');
		string modified := xmltext('@modified');
		string node := xmltext('@node');
	end;

	xmlout := parse(xmlds,xmlline,crc_Rec,xml('File/Part'));
	
	return xmlout;

end;