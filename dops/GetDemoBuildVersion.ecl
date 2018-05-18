import dops;
export GetDemoBuildVersion(string dsname,string loc,string eflag, string dopsenv = dops.constants.dopsenvironment) := function
InputRec := record
	string dsname{xpath('dsname')} := dsname;
	string loc{xpath('loc')} := loc;
	string envflag{xpath('envflag')} := eflag;
end;
	
outrec := record,maxlength(50000)
	string datasets {xpath('GetDemoBuildVersionResponse/GetDemoBuildVersionResult')};
end;

soapresults := SOAPCALL(
	dops.constants.prboca.serviceurl(dopsenv),
	'GetDemoBuildVersion',
	InputRec,
	DATASET(outrec),
	NAMESPACE('http://lexisnexis.com/'),
	LITERAL,
	SOAPACTION('http://lexisnexis.com/GetDemoBuildVersion'));

return(soapresults);

end;