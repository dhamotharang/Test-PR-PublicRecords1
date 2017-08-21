IMPORT	AID_Build,STD, doxie;

EXPORT Keys := module

EXPORT	AID_Base_AddressLookup(boolean isFCRA	=	FALSE):=	FUNCTION

	dBaseAddressLookup	:=	dataset([], AID_Build.layouts.rFinal_AddressLookup);
	RETURN	INDEX(dBaseAddressLookup,	{hash_line1, hash_linelast}, {dBaseAddressLookup},
																			if(isFCRA, '~prte::key::aid::fcra::','~prte::key::aid::')+ doxie.Version_SuperKey +  '::addrline1_addrlinelast');
	
	END;

END;
