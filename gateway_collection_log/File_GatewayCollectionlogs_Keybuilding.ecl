import dx_gateway,std;

EXPORT File_GatewayCollectionlogs_Keybuilding(STRING pVersion	=	(STRING8)Std.Date.Today(),
                                              Constants.buildType	pBuildType	=	Constants.buildType.Daily)	:=	FUNCTION
dsLog := Files(,constants.useprod).File_GatewayCollectionlog_base;

dx_gateway.Layouts.i_GatewayCollectionlog_DID intoKeylayout (dsLog L):= transform
self.did           := Map(L.response_did = 0 => L.lexid_in,
                          L.response_did );
self.request_data  := L.cln_request_data; 
self.response_data := L.cln_response_data; 
self := L;
end;

dsLogkeyrecords := project(dslog,intoKeylayout(left));

// If this is a daily build then only create a key with today's records
dKeyResult      := If(pBuildType	= Constants.buildType.Daily,
											dsLogkeyrecords(process_date=pVersion),
											dsLogkeyrecords);

return(dKeyResult);

End;