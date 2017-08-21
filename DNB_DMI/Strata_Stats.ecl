import strata,tools;

export Strata_Stats(

	 dataset(Layouts.Input.Sprayed		)	pPrepSprayedFile		= Prep_File()
	,dataset(layouts.base.companiesforBip2		)	pBaseCompaniesFile	= files().base.companies.built
	,dataset(layouts.base.contacts		)	pBaseContactsFile		= files().base.contacts.built

) :=
module

	tools.mac_RedefineFormat(pPrepSprayedFile		,Layouts.input.Flattened		,lPrepSprayedFile		,,[30,30]	);

	shared lBaseCompaniesFile	:= project(pBaseCompaniesFile	,transform(layouts.base.companies_forstrata	,self.record_type := utilities.RTToText(left.record_type);self := left));
	shared lBaseContactsFile	:= project(pBaseContactsFile	,transform(layouts.base.contacts_forstrata	,self.record_type := utilities.RTToText(left.record_type);self.company_record_type := utilities.RTToText(left.company_record_type);self := left));

	Strata.mac_Pops		(lPrepSprayedFile		,dInputNoGrouping																											);
	Strata.mac_Pops		(lBaseCompaniesFile	,dBaseNoGrouping																											);
	Strata.mac_Pops		(lBaseCompaniesFile	,dBaseCleanMailAddressState								,'clean_mail_address.st'		);
	Strata.mac_Pops		(lBaseCompaniesFile	,dBaseCleanAddressState										,'Clean_address.st'					);
	Strata.mac_Pops		(lBaseCompaniesFile	,dBaseRecordType													,'record_type'							);
	Strata.mac_Pops		(lBaseCompaniesFile	,dBaseActiveDunsNumber										,'active_duns_number'				);
	Strata.mac_Uniques(lBaseCompaniesFile	,dUniquesBaseNoGrouping																								);
	Strata.mac_Pops		(lBaseContactsFile	,dContactsNoGrouping																									);
	Strata.mac_Pops		(lBaseContactsFile	,dContactsCleanCompanyAddressState				,'clean_company_address.st'	);
	Strata.mac_Pops		(lBaseContactsFile	,dContactsRecordType											,'record_type'							);
	Strata.mac_Pops		(lBaseContactsFile	,dContactsCompanyRecordType								,'company_record_type'			);
	Strata.mac_Pops		(lBaseContactsFile	,dContactsActiveDunsNumber								,'active_duns_number'				);
	Strata.mac_Uniques(lBaseContactsFile	,dUniquesContactsNoGrouping																						);
end;
