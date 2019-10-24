import _control, MDR, std, tools;

export Updates_Base_Files(

	 string																	pversion
	,dataset(Layouts.Input.Sprayed				)	pSprayedFile
	,dataset(layouts.input.oldcompanies		)	pInputCompaniesFile	= Files().input.oldcompanies.using
	,dataset(Layouts.Base.CompaniesForBIP2)	pBaseCompaniesFile	= Files().base.companies.qa	
	,dataset(Layouts.Base.contacts				)	pBaseContactsFile		= Files().base.contacts.qa									
	,dataset(layouts.input.oldcontacts		)	pInputContactsFile	= Files().input.oldcontacts.using		
	,boolean																pUseV1Inputs				= false
	// ,boolean																pShouldUpdateComp		= _Flags.Companies.Update
	// ,dataset(Layouts.Base.CompaniesForBIP2)	pBaseFileComp				= if(pShouldUpdateComp	,pBaseCompaniesFile	,dataset([],Layouts.Base.CompaniesForBIP2))
	// ,boolean																pShouldUpdateCont		= _Flags.Contacts.Update
	// ,dataset(Layouts.Base.contacts				)	pBaseFileCont				= if(pShouldUpdateCont	,pBaseContactsFile	,dataset([],Layouts.Base.contacts))										
	

) :=
function

	// company information
	dScrub_Number_Fields			:= Scrub_Number_Fields		(pSprayedFile					,pversion							);
	dFile_Companies_V1_Input	:= File_Companies_V1_Input(pInputCompaniesFile	,pversion							);
	dwhichfile								:= if(pUseV1Inputs	,dFile_Companies_V1_Input		,dScrub_Number_Fields	);
	
	dDeletes									:= dwhichfile(rawfields.delete_record_indicator != '');
	dActives									:= dwhichfile(rawfields.delete_record_indicator  = '');

	dIngest_Companies					:= Ingest_Companies				(dActives							,pBaseCompaniesFile	).AllRecords_NoTag;
	dProcess_Deletes					:= Process_Deletes				(dDeletes							,dIngest_Companies		);
	addGlobalSID							:= MDR.macGetGlobalSid(dProcess_Deletes, 'DNB', '', 'global_sid'); //DF-25978: Add Global_SID to Companies
	
	dAppend_AID								:= Append_AID.fall				(addGlobalSID														);
		
	// contact information
	dNorm_Contacts						:= Norm_Contacts					(pSprayedFile					,pversion							);
	dFile_Contacts_V1_Input		:= File_Contacts_V1_Input	(pInputContactsFile		,pversion							);
	ddecision									:= if(pUseV1Inputs	,dFile_Contacts_V1_Input		,dNorm_Contacts				);
	dStandardize_Contacts			:= Standardize_Contacts		(ddecision);	

	dIngest_CompCont					:= Ingest_Contacts				(dStandardize_Contacts,pBaseContactsFile).AllRecords_MapTag;
	
	// add company info to contacts
	dAppend_Company_Info			:= Append_Company_Info		(dIngest_CompCont		,dAppend_AID						);
	
	// ADL
	dAppendDid								:= Append_DID							(dAppend_Company_Info												);
	dAppendBdids							:= Append_Bdid						(dAppend_AID				,dAppendDid							);
	
	Layouts.Base.Contacts	JoinForBDID(Layouts.Base.CompaniesForBIP2 l, Layouts.Base.Contacts r)	:=	transform
			self.bdid	:=	l.bdid;
			self			:=	r;
	end;
	
	dPropagatedBDID						:= Join(dAppendBdids,
																		dAppendDid,
																		left.rid = right.rid,
																		JoinForBDID(left,right),
																		right outer
																		);			
																		
	addGlobalSID2							:= MDR.macGetGlobalSid(dPropagatedBDID, 'DNB', '', 'global_sid'); //DF-25978: Add Global_SID to Contacts
	
	tools.mac_WriteFile(Filenames(pversion).base.Companies.new	,dAppendBdids			,Build_Companies_File	,pShouldExport := false);
	tools.mac_WriteFile(Filenames(pversion).base.Contacts.new		,addGlobalSID2	,Build_Contacts_File	,pShouldExport := false);

	return	sequential(
											Build_Companies_File
											,Build_Contacts_File
										);												
										
	end;