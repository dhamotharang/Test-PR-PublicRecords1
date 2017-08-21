import _control,Business_Header;

pversion						:= '20110516'													;
pServerIP						:= _control.IPAddress.edata10					;
pDirectory					:= '/prod_data_build_13/eval_data/debt_settlement/';
pFilename						:= 'attroney_file_did_stats*.csv';
pFilename2					:= 'DebtSettlementCreditCounsel*.csv';
pUseBusHeader				:= true;
pGroupName					:= Debt_Settlement._Constants().groupname	;																
pIsTesting					:= false															;
pOverwrite					:= false															;		
pUpdateRSIHFile			:= Debt_Settlement.Files().InputRSIH.Using;												
pBaseFile						:= Debt_Settlement.Files().Base.QA;
pUpdateCCFile				:= Debt_Settlement.Files().InputCC.Using;
pBusHeaderBestFile 	:= Business_Header.Files().Base.Business_Header_Best.QA;
pBusSICRecs 				:= Business_Header.Persists().BHBDIDSIC;

#workunit('name', Debt_Settlement._Constants().Name + ' Build ' + pversion);
Debt_Settlement.Build_All(
	 pversion		 
	,pServerIP
	,pDirectory	
	,pFilename	
	,pFilename2
	,pUseBusHeader
	,pGroupName	
	,pIsTesting	
	,pOverwrite	
	,pUpdateRSIHFile
	,pBaseFile
	,pUpdateCCFile
	,pBusHeaderBestFile
	,pBusSICRecs

).All;