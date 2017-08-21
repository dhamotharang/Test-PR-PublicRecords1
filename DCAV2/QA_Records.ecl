import tools;

export QA_Records(

dataset(layouts.base.companies	)	pBaseCompaniesFile	= files().base.companies.built
,dataset(layouts.base.contacts	)	pBaseContactsFile		= files().base.contacts.built

/* dataset(layouts.base.companies	)	pBaseCompaniesFile = dcav2.files().base.companies.built
   ,dataset(layouts.base.contacts	)	pBaseContactsFile = dcav2.files().base.contacts.built
*/

	

) :=
function
	//get new records for QA

	dNewCompanies := pBaseCompaniesFile	(record_type = utilities.RecordType.New);
	dNewContacts	:= pBaseContactsFile	(record_type = utilities.RecordType.New);
/* 	dNewCompanies := pBaseCompaniesFile	(record_type = dcav2.utilities.RecordType.New);
     dNewContacts	:= pBaseContactsFile	(record_type = dcav2.utilities.RecordType.New);
   	
*/

	return parallel(
		// output(choosen(dNewCompanies	,100) , named('SampleNewCompaniesForQA'	))
		//,output(choosen(dNewContacts	,100)	, named('SampleNewContactsForQA'	))
		
		output(choosen(sort(dNewCompanies, -date_last_seen),100) , named('SampleNewCompaniesForQA'))
		,output(choosen(sort(dNewContacts, -date_last_seen),100)	, named('SampleNewContactsForQA'))

		
	);

end;






	