export Dell__Process(

	 dataset(Layouts.Input.Dell									)	pRawFile					= files().input.dell.sprayed
	,dataset(Layouts.layaddr										) pAddressSummary		= files().address_summary.built
	,dataset(Layouts.laybus											) pBusinessSummary	= files().business_summary.built
	,dataset(Layouts.laycont										) pContactSummary		= files().contact_summary.built	
	,dataset(Layouts.Temporary.PrepAdvo					) pAdvo							= Prep_Advo									()
	,dataset(Layouts.Temporary.PrepForeclosure	) pForeclosure 			= Prep_Foreclosure					()
	,dataset(Layouts.Temporary.PrepPhonesPlus		) pEda							= Prep_Gong									()
	,dataset(Layouts.Temporary.PrepPhonesPlus		)	pPhonesPlus				= Prep_PhonesPlus						()
	,dataset(layouts.temporary.PrepUSPISHotList	) pUSPIS_HotList		= Prep_USPIS_HotList				()

) :=
function

	dStandardizedInputFile	:= Dell_Standardize_Input.fAll	(pRawFile								);
	dAppendIds							:= Dell_Append_Ids.fAll					(dStandardizedInputFile	);
	dSummaryAppends					:= Dell_Summary_Appends.fAll		(dAppendIds							,pAddressSummary,pBusinessSummary,pContactSummary);
	dMiscAppends						:= Dell_Append_Miscellaneous		(dSummaryAppends				,pAdvo,pForeclosure,pEda,pPhonesPlus,pUSPIS_HotList);
	
	return dMiscAppends;

end;