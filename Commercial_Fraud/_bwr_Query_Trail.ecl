import corp2;

lBizName					:= 'PLYBOR INDUSTRY CORPORATION';
lCorp_keys				:= []	;
lApp_ref_keys			:= ['803474087'];

set_dfs_example_app_ref_keys := [
 803448066
,803451223
,803488259
,803433197
,803490706
];

#workunit('name','Comm Fraud ' + lBizName + ' Query');

Commercial_Fraud.Query_Trail(
	 pBizName						:= lBizName
	,pCorp_keys					:= lCorp_keys
	,pCharter_Number		:= ''
	,pApp_ref_keys			:= lApp_ref_keys
	,pBdids							:= []
	,pDids							:= []
	,pAce_Aids					:= []
	,pDellOut						:= Commercial_Fraud.files().Dell_out.built
	,pDellInput					:= Commercial_Fraud.files().Input.Dell.sprayed
	,pDellOutAppend			:= Commercial_Fraud.files().Dell_out_Append.built
	,pAddressSummary		:= Commercial_Fraud.files().address_summary.built
	,pBusinessSummary		:= Commercial_Fraud.files().business_summary.built
	,pContactSummary		:= Commercial_Fraud.files().contact_summary.built	
	,pCorp2							:= corp2.files().base.corp.qa	
	,pCorp2Cont					:= corp2.files().base.cont.qa	
	,pCorp2Events				:= corp2.files().base.events.qa	
);


//look for PLYBOR INDUSTRY CORPORATION 
// at 1 CROSS ISLAND PLZ   ROSEDALE  NY 11422   
// kim finds 184 biz at address, 110 delinquent biz at address
// why is there not any derog biz at address
