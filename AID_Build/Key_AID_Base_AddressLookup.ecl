IMPORT	AID_Build,STD;
EXPORT	Key_AID_Base_AddressLookup(	STRING	pVersion							=	(STRING8)Std.Date.Today(),
																		BOOLEAN	pUseOtherEnvironment	=	FALSE,
																		BOOLEAN	isFCRA								=	FALSE)	:=	FUNCTION

	dBaseAddressLookup	:=	AID_Build.Build_Base_AddressLookup(pVersion,pUseOtherEnvironment,isFCRA);
	key_name						:=	Keynames(pVersion,pUseOtherEnvironment,FALSE/*isFCRA*/).Addrline1_Addrlinelast.QA;
	RETURN	INDEX(	
						dBaseAddressLookup,
						{hash_line1, hash_linelast}, 
						{dBaseAddressLookup},
						key_name
					);
END;