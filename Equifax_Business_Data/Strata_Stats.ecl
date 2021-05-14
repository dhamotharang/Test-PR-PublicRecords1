IMPORT strata;

EXPORT Strata_Stats(
	 DATASET(Equifax_Business_Data.layouts.base)	                 pBaseFile			      = Equifax_Business_Data.Files().base.companies.built
	,STRING															                           pfileversion		      = 'using'
	,BOOLEAN														                           pUseOtherEnviron     = Equifax_Business_Data._Constants().isdataland
	,DATASET(Equifax_Business_Data.Layouts.Sprayed_Input)          pSprayedFile         = Equifax_Business_Data.Files(pfileversion,pUseOtherEnviron).Input.Companies.logical
	,DATASET(Equifax_Business_Data.layouts.base_contacts)	         pBaseContactsFile		= Equifax_Business_Data.Files().base.contacts.built
	,DATASET(Equifax_Business_Data.Layouts.Sprayed_Input_Contacts) pSprayedContactsFile = Equifax_Business_Data.Files(pfileversion,pUseOtherEnviron).Input.Contacts.using

) := MODULE

	Strata.mac_Pops		(pSprayedFile	,dInputNoGrouping	            );
	Strata.mac_Uniques(pSprayedFile	,dUniqueInputNoGrouping,'',false,true,false,
	                      ['efx_id'	]
												,false);
	Strata.mac_Pops		(pBaseFile		,dNoGrouping					        );
	Strata.mac_Pops		(pBaseFile		,dCleanAddressState	     ,'st');
	Strata.mac_Uniques(pBaseFile		,dUniqueNoGrouping,'',false,true,false,
	                      ['source','rcid','efx_id','UltID','OrgID','SELEID','ProxID','POWID','EmpID','DotID','record_sid','global_sid']
												,false);
	Strata.mac_Uniques(pBaseFile		,dUniqueCleanAddressState,'st',false,true,false,
	                      ['source','rcid','efx_id','UltID','OrgID','SELEID','ProxID','POWID','EmpID','DotID','record_sid','global_sid']
	                     	,false);
												
	Strata.mac_Pops		(pSprayedContactsFile	,dContactsNoGrouping	            );
	Strata.mac_Uniques(pSprayedContactsFile	,dContactsUniqueNoGrouping,'',false,true,false,
	                      ['efx_id'	]
												,false);
	Strata.mac_Pops		(pBaseContactsFile		,dBaseContactsNoGrouping					        );
	Strata.mac_Uniques(pBaseContactsFile		,dBaseContactsUniqueNoGrouping,'',false,true,false,
	                      ['rcid','efx_id','did','UltID','OrgID','SELEID','ProxID','POWID','EmpID','DotID','record_sid','global_sid']
												,false);

END;