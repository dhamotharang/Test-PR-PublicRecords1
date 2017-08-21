import tools;
export QA_Records(
	 dataset(layouts.base.companies	)	pBaseCompaniesFile	= files().base.companies.qa
	,dataset(layouts.base.contacts	)	pBaseContactsFile		= files().base.contacts.qa
) :=
function
	//get new records for QA
	dNewCompanies := pBaseCompaniesFile	(record_type = utilities.RecordType.New);
	dNewContacts	:= pBaseContactsFile	(record_type = utilities.RecordType.New);
	return parallel(
		 output(dNewCompanies , named('SampleNewCompaniesForQA'	))
		,output(dNewContacts	, named('SampleNewContactsForQA'	))
	);
end;
