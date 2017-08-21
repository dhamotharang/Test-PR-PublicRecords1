import corp2,BankruptcyV2,LiensV2,UCCV2,Property,Advo,address,mdr,aid,ut;
/*
rolled up on vendor_id

*/
export fSummarize_Business_CorpV2(

	 dataset(Corp2.Layout_Corporate_Direct_Corp_Base	) pCorp						= Prep_CorpV2.fCorp()
	,dataset(Corp2.Layout_Corporate_Direct_Cont_Base	) pCorpCont				= Prep_CorpV2.fCont()
	,dataset(Corp2.Layout_Corporate_Direct_Event_Base	) pCorpEvent			= Prep_CorpV2.fEvent()
	,dataset(Layouts.laycont													)	pSummaryContact	= fSummarize_Contact_CorpV2()
	,dataset(layouts.layaddr													)	pAddrSummary		= fSummarize_Address_CorpV2()
	,string																							pPersistname		= Persistnames().fSummarizeBusinessCorpV2

) :=
function

	dRollupCorpV2Info		:= fSummarize_Business_CorpV2_rollup	(pCorp	,pCorpCont);
	dAppendSummaryInfo	:= fSummarize_Business_CorpV2_Appends	(dRollupCorpV2Info,pCorpEvent,pSummaryContact,pAddrSummary);

	dreturn := dAppendSummaryInfo
		: persist(pPersistname);
		
	return dreturn;
	
end;