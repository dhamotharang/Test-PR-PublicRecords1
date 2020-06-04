import doxie,std;
EXPORT KeyPrep_GatewayCollectionlog_DID (STRING pVersion	=	(STRING8)Std.Date.Today(),
														             Constants.buildType	pBuildType	=	Constants.buildType.Daily)	:=	FUNCTION
														
df 	:= File_GatewayCollectionlogs_Keybuilding(pVersion,pBuildType);

RETURN INDEX(df/*(did != 0)*/,{df.did},{df}, gateway_collection_log.Keynames().kGatewayCollectionDid.QA);
END;