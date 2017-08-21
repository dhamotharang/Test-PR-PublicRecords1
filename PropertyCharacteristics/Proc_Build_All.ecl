import PropertyFieldFillInByLA2;
export	Proc_Build_All(string	pVersion, string emailList='')	:=
function
  buildLocAvg    			:=  PropertyFieldFillInByLA2.fn_FillinVars_Hedonics(pVersion);
	buildBase						:=	PropertyCharacteristics.Proc_Build_Base(pVersion, emailList)
													:	success(output('PropertyCharacteristics base files created successfully')),
														failure(FileServices.SendEmail('terri.hardy-george@lexisnexis.com','PropertyCharacteristics base build failure',failmessage));
	
	buildKeys						:=	PropertyCharacteristics.Proc_Build_key(pVersion)
													:	success(output('PropertyCharacteristics keys created successfully')),
														failure(FileServices.SendEmail('terri.hardy-george@lexisnexis.com','PropertyCharacteristics roxie build failure',failmessage));
	
	missingCommonCodes	:=	PropertyCharacteristics.Missing_Common_Codes(pVersion);
	
	return	sequential(buildLocAvg,buildBase,buildKeys,missingCommonCodes);
end;

