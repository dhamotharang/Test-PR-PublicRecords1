import _Control;

export Logs_Copy(

	 string pversion
	,string pSourceName				= filenames(pversion).base.logs_thor.qa
	,string pDestinationName	= filenames(pversion).input.prod_thor.sprayed
	,string pDestinationGroup	= 'thor400_92'
	,string pRemoteURL				= 'http://10.173.84.202:8010/FileSpray'

) :=
function

	return fileservices.RemotePull(pRemoteURL,pSourceName,pDestinationGroup,pDestinationName,,,,,true);

end;