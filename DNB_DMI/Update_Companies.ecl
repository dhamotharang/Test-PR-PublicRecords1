export Update_Companies(

	 string																			pversion
	,dataset(Layouts.Input.Sprayed						)	pSprayedFile
	,dataset(layouts.input.oldcompanies				)	pInputCompaniesFile	= Files().input.oldcompanies.using
	,dataset(Layouts.Base.companies						)	pBaseCompaniesFile	= Files().base.companies.qa	
	,boolean																		pUseV1Inputs				= false
	,boolean																		pShouldUpdate				= _Flags.Companies.Update
	,dataset(Layouts.Base.companies						)	pBaseFile						= if(pShouldUpdate	,pBaseCompaniesFile	,dataset([],Layouts.Base.companies))									
	

) :=
function

	dScrub_Number_Fields			:= Scrub_Number_Fields		(pSprayedFile					,pversion					);
	dFile_Companies_V1_Input	:= File_Companies_V1_Input(pInputCompaniesFile	,pversion					);
	dwhichfile								:= if(pUseV1Inputs	,dFile_Companies_V1_Input	,dScrub_Number_Fields);

	dDeletes									:= dwhichfile(rawfields.delete_record_indicator != '');
	dActives									:= dwhichfile(rawfields.delete_record_indicator  = '');

	dIngest_Companies					:= Ingest_Companies				(dActives							,pBaseCompaniesFile	).AllRecords_NoTag;
	dProcess_Deletes					:= Process_Deletes				(dDeletes							,dIngest_Companies);
	dAppend_AID								:= Append_AID.fall				(dProcess_Deletes												);
	dAppendBdids							:= Append_Bdid						(dAppend_AID														);
	
	return dAppendBdids;

end;
