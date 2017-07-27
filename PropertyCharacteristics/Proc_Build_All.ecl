export	Proc_Build_All(string	pVersion)	:=
function
	buildBase						:=	PropertyCharacteristics.Proc_Build_Base(pVersion)
													:	success(output('PropertyCharacteristics base files created successfully')),
														failure(FileServices.SendEmail('kgummadi@seisint.com','PropertyCharacteristics base build failure',failmessage));
	
	buildKeys						:=	PropertyCharacteristics.Proc_Build_key(pVersion)
													:	success(output('PropertyCharacteristics keys created successfully')),
														failure(FileServices.SendEmail('kgummadi@seisint.com','PropertyCharacteristics roxie build failure',failmessage));
	
	missingCommonCodes	:=	PropertyCharacteristics.Missing_Common_Codes(pVersion);
	
	return	sequential(buildBase,buildKeys,missingCommonCodes);
end;