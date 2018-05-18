import dops;
export GetDataSets(string location, string dopsenv = dops.constants.dopsenvironment) := function
InputRec := record
	string location{xpath('location')} := location;
//	string envflag{xpath('envflag')} := 'N';
end;
	
outrec := record,maxlength(50000)
	string datasets {xpath('GetDatasetsResponse/GetDatasetsResult')};
end;

soapresults := SOAPCALL(
	dops.constants.prboca.serviceurl(dopsenv),
	'GetDatasets',
	InputRec,
	DATASET(outrec),
	NAMESPACE('http://lexisnexis.com/'),
	LITERAL,
	SOAPACTION('http://lexisnexis.com/GetDatasets'));

return (soapresults);

end;