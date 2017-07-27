/*
IMPORT BusReg,DNB_FEINV2,MDR,TopBusiness_BIPV2,BIPV2;

EXPORT Build_Industry_base := MODULE

Industry_Base_file_name :='~thor_data400::base::Industry_base'+thorlib.wuid();

	export All := sequential(
								OUTPUT(BIPV2.Industry_sources,,Industry_Base_file_name ,OVERWRITE)
								// ,fileservices.StartSuperFileTransaction 
								,fileservices.ClearSuperFile ('~thor_data400::BASE::Industry_Base') 
								,fileservices.AddSuperFile ('~thor_data400::BASE::Industry_Base', Industry_Base_file_name) 
								// ,fileservices.FinishSuperFileTransaction 
							 
	);
	
END;
*/
// Build_Industry_base(pversion, pIsTesting, pInFile)



import _control, tools,BIPV2;

export Build_Industry_base(

	 string														              pversion
	,dataset(Layouts.rec_industry_combined_layout	)	pBaseFile						= BIPV2.Industry_sources								
) :=
module
   

	Build_Base_File := tools.macf_WriteFile(Filenames(pversion).Industry_LinkIds.new	,pBaseFile);
																																
	export full_base := sequential(Build_Base_File  ,promote(pversion).new2built);
		
		
end;