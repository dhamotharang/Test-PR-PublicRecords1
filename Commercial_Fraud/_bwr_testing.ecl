import corp2;
pversion 	:= '20100128'	;
pCorp_key := '01-005073';

#workunit('name','Commercial Fraud Find ' + pcorp_key + ' in pversion ' + pversion);

Commercial_Fraud.fTesting(

	 pversion					:= pversion 
	,pCorp_key				:= pCorp_key
	,pBusinessSummary	:= Commercial_Fraud.Files(pversion).business_summary.logical
	,pAddressSummary	:= Commercial_Fraud.Files(pversion).address_summary.logical
	,pContactSummary	:= Commercial_Fraud.Files(pversion).contact_summary.logical
	,pCorp						:= corp2.files().base.corp.qa
	,pCont						:= corp2.files().base.cont.qa
	,pEvents					:= corp2.files().base.events.qa

);