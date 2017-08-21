import strata;
export Strata_Stats(
	 string														pinputfileversion		= 'using'
	,string														pbasefileversion		= 'built'
	,boolean													pUseOtherEnviron		= false
	,dataset(Layouts.Input.sprayed	)	pSprayedintFile			= files(pinputfileversion,pUseOtherEnviron).input.int.logical
	,dataset(Layouts.Input.sprayed	)	pSprayedprvFile			= files(pinputfileversion,pUseOtherEnviron).input.prv.logical
	,dataset(Layouts.Input.sprayed	)	pSprayedpubFile			= files(pinputfileversion,pUseOtherEnviron).input.pub.logical
	,dataset(Layouts.Input.sprayed	)	pSprayedPrivcoFile	= files(pinputfileversion,pUseOtherEnviron).input.privco.logical
	,dataset(layouts.base.companies	)	pBaseCompanies			= files(pbasefileversion,pUseOtherEnviron).base.companies.logical
	,dataset(layouts.base.contacts	)	pBaseContacts				= files(pbasefileversion,pUseOtherEnviron).base.contacts.logical
) :=
module

	shared lbaseCompanies	:= project(pBaseCompanies	,transform(layouts.temporary.companiesstrata	,self.record_type := utilities.RTToText(left.record_type);self := left));
	shared lbaseContacts	:= project(pBaseContacts	,transform(layouts.temporary.contactsstrata		,self.record_type := utilities.RTToText(left.record_type);self := left));
	
	export dInputInt						  := Strata.macf_Pops		(pSprayedintFile										,pSetFields := ['__filename']);
	export dInputPRV						  := Strata.macf_Pops		(pSprayedprvFile										,pSetFields := ['__filename']);
	export dInputPUB						  := Strata.macf_Pops		(pSprayedpubFile										,pSetFields := ['__filename']);
	export dInputPRIVCO					  := Strata.macf_Pops		(pSprayedPrivcoFile									,pSetFields := ['__filename']);
	export dCompaniesRecordType	  := Strata.macf_Pops		(lbaseCompanies			,'record_type'	);
	export dContactsRecordType	  := Strata.macf_Pops		(lbaseContacts			,'record_type'	);
	export dContactsUniques			  := Strata.macf_Uniques(lbaseContacts			,,,false,['rid','bdid','did','DOTid','EmpID','POWID','ProxID','SeleID','OrgID','UltID','physical_RawAID','physical_AceAID','mailing_RawAID','mailing_AceAID','src_rid','lncaGID','lncaGHID','lncaIID','rawfields.Enterprise_num','human_link_id']	);
	export dCompaniesUniques		  := Strata.macf_Uniques(lbaseCompanies			,,,false,['rid','bdid'      ,'DOTid','EmpID','POWID','ProxID','SeleID','OrgID','UltID','physical_RawAID','physical_AceAID','mailing_RawAID','mailing_AceAID','src_rid','lncaGID','lncaGHID','lncaIID','rawfields.Enterprise_num','rawfields.Parent_Enterprise_number','rawfields.Ultimate_Enterprise_number','killreport.kill_enterprise_nbr','killreport.company_id','MergerAcquis.seller3_enterprise_nbr','MergerAcquis.seller2_enterprise_nbr','MergerAcquis.seller1_enterprise_nbr','MergerAcquis.buyer3_enterprise_nbr','MergerAcquis.buyer2_enterprise_nbr','MergerAcquis.buyer1_enterprise_nbr','MergerAcquis.target_enterprise_nbr']	);

end;