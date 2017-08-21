import strata, tools;

export strata_asBusinessHeaderStats(

	 string																		pversion
	,boolean																	pIsTesting	= false
	,boolean																	pOverwrite	= false
	,dataset(Layout_YellowPages_Base_V2_BIP	)	pBaseFile		= Files().Base.built

) :=
function

	strata.mac_Pops(fYellowPages_As_Business_Header	(pBaseFile)	,dasbhpops	,'source,state',,,,,,,['vl_id','rawaid'									]);

	Strata.mac_CreateXMLStats(dasbhpops	,'Yellow Pages'	,'DataV1',pversion, Email_Notification_Lists().Stats	,AsBHPopsOut, 'AsBusinessHeader'	,'Population',,pIsTesting,pOverwrite,pShouldExport := true);
	
	return if(tools.fun_IsValidVersion(pversion),
	sequential(
		 AsBHPopsOut		
	));

end;
