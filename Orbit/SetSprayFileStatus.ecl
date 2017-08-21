export SetSprayFileStatus(
													string intoken,
													string filename,
													string filepath,
													string wuid
													) := function

inrec := record, maxlength(10000)
 string requestString {xpath('xml')} := 
		'<OrbitRequest xmlns='+orbit.EnvironmentVariables.xmlns+'>'+
	 		 '<Files>'  +
			    '<File>' +
				   '<FileName>'+fileName+'</FileName>'+
				   '<FilePath>'+filePath+'</FilePath>'+
				   '<DFUNumber>'+wuid+'</DFUNumber>'	+
				'</File>'+
			 '</Files>'+
		 '<Token>'+intoken+'</Token>'+
  '</OrbitRequest>';
END;

outrec := RECORD, MAXLENGTH(50000)
		string outdata {xpath('AddSprayFilesResponse/AddSprayFilesResult')};
END;

retval := SOAPCALL(
		orbit.EnvironmentVariables.serviceurl,
		'AddSprayFiles',
		inrec,
		outrec,
		NAMESPACE(orbit.EnvironmentVariables.namespace),
		LITERAL,
		SOAPACTION(orbit.EnvironmentVariables.soapactionprefix +'AddSprayFiles'));

RETURN retval;


end;