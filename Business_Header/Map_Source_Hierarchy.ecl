import mdr;
EXPORT INTEGER1 Map_Source_Hierarchy(STRING2 source) := MAP(
			
				MDR.sourceTools.SourceIsGong_Business					(source)
		or	MDR.sourceTools.SourceIsGong_Government				(source) => 1
	,			MDR.sourceTools.SourceIsYellow_Pages					(source) => 2
	,			MDR.sourceTools.SourceIsCorpV2								(source) => 3
	,			MDR.sourceTools.SourceIsDunn_Bradstreet				(source)
		or	MDR.sourceTools.SourceIsVickers								(source)
		or	MDR.sourceTools.SourceIsLiens_and_Judgments		(source) => 4
	,			MDR.sourceTools.SourceIsEdgar									(source) => 5
	,			MDR.sourceTools.SourceIsIRS_5500							(source)
		or	MDR.sourceTools.SourceIsState_Sales_Tax				(source)
		or	MDR.sourceTools.SourceIsSEC_Broker_Dealer			(source) 
		or	MDR.sourceTools.SourceIsFDIC									(source)
		or	MDR.sourceTools.SourceIsFL_Non_Profit					(source) 
		or	MDR.sourceTools.SourceIsWorkmans_Comp					(source)
		or	MDR.sourceTools.SourceIsIRS_Non_Profit				(source) 
		or	MDR.sourceTools.SourceIsProfessional_License	(source)
		or	MDR.sourceTools.SourceIsFL_FBN								(source) 
		or	MDR.sourceTools.SourceIsDea										(source)
		or	MDR.sourceTools.SourceIsSKA										(source) 
		or	MDR.sourceTools.SourceIsCredit_Unions					(source) => 6
	,			MDR.sourceTools.SourceIsBusiness_Registration	(source) => 7
	,			MDR.sourceTools.SourceIsFBNV2									(source) => 8
	,			MDR.sourceTools.SourceIsEmployee_Directories	(source) 
		or	MDR.sourceTools.SourceIsAccurint_Trade_Show		(source) => 9
	,			MDR.sourceTools.SourceIsUCCS									(source) => 10
	,			MDR.sourceTools.SourceIsBankruptcy						(source) => 11
	,			MDR.sourceTools.SourceIsWhois_domains					(source) => 12
	,																																13
);