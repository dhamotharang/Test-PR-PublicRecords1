import tools;

export QA_Records(

	 dataset(layouts.base.companiesforBip2	)	pBaseCompaniesFile	= files().base.companies.qa
	,dataset(layouts.base.contacts	)	pBaseContactsFile		= files().base.contacts.qa

) :=
function
	//get new records for QA

	dNewCompanies := pBaseCompaniesFile	(record_type = utilities.RecordType.New);
	dNewContacts	:= pBaseContactsFile	(record_type = utilities.RecordType.New);

	return parallel(
		 output(choosen(dNewCompanies	,100) , named('SampleNewCompaniesForQA'	))
		,output(choosen(dNewContacts	,100)	, named('SampleNewContactsForQA'	))
	);

end;
