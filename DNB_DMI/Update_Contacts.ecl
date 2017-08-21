export Update_Contacts(

	 string																pversion
	,dataset(Layouts.Input.Sprayed			)	pSprayedFile
	,dataset(Layouts.Base.contacts			)	pBaseContactsFile		= Files().base.contacts.qa									
	,dataset(Layouts.Base.companies			)	pBaseCompaniesFile	= Files().base.companies.built	//new one					
	,dataset(layouts.input.oldcontacts	)	pInputContactsFile	= Files().input.oldcontacts.using							
	,boolean															pUseV1Inputs				= false
	,boolean															pShouldUpdate				= _Flags.Contacts.Update
	,dataset(Layouts.Base.contacts			)	pBaseFile						= if(pShouldUpdate	,pBaseContactsFile	,dataset([],Layouts.Base.contacts))									
	

) :=
function

	dNorm_Contacts							:= Norm_Contacts					(pSprayedFile				,pversion);
	dFile_Contacts_V1_Input			:= File_Contacts_V1_Input	(pInputContactsFile	,pversion);
	ddecision										:= if(pUseV1Inputs	,dFile_Contacts_V1_Input	,dNorm_Contacts);
	dStandardize_Contacts				:= Standardize_Contacts		(ddecision);	
	dIngest_Companies						:= Ingest_Contacts				(dStandardize_Contacts	,pBaseContactsFile	).AllRecords_MapTag;
	dAppend_Company_Info				:= Append_Company_Info		(dIngest_Companies			,pBaseCompaniesFile	);
	dAppendDid									:= Append_DID							(dAppend_Company_Info												);
	
	return dAppendDid;

end;
