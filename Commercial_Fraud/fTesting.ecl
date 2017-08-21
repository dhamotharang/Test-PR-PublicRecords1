import corp2;
export fTesting(

	 string pversion
	,string pCorp_key
	,dataset(Layouts.laybus														) pBusinessSummary	= files().business_summary.built
	,dataset(Layouts.layaddr													) pAddressSummary		= files().address_summary.built
	,dataset(Layouts.laycont													) pContactSummary		= files().contact_summary.built
	,dataset(Corp2.Layout_Corporate_Direct_Corp_Base	) pCorp							= Prep_CorpV2.fCorp()
	,dataset(Corp2.Layout_Corporate_Direct_Cont_Base	) pCont							= Prep_CorpV2.fCont()
	,dataset(Corp2.Layout_Corporate_Direct_Event_Base	) pEvents						= Prep_CorpV2.fEvent()

) :=
function

	dcorpy	:= pCorp		;
	dconty	:= pCont		;
	deventy	:= pEvents	;

	return sequential(
		 output(pBusinessSummary	(vendor_id = pcorp_key),named('pBusinessSummary'))
		,output(pAddressSummary		(vendor_id = pcorp_key),named('pAddressSummary'	))
		,output(pContactSummary		(vendor_id = pcorp_key),named('pContactSummary'	))

		,output(table(dcorpy	(corp_key = pcorp_key),{dt_first_seen, unsigned8 cnt := count(group)}, dt_first_seen,few),named('dCorpyFirstSeens'),all)
		,output(dcorpy	(corp_key = pcorp_key),named('dcorpy'),all)
		,output(dconty	(corp_key = pcorp_key),named('dconty'))
		,output(deventy	(corp_key = pcorp_key),named('deventy'))
	);
end;