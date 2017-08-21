/*
IMPORT FCC, MDR,TopBusiness_BIPV2,BIPV2;

EXPORT Build_License_base := MODULE

License_Base_file_name :='~thor_data400::base::License_base'+thorlib.wuid();

	export All := sequential(
								OUTPUT(BIPV2.License_sources,,License_Base_file_name ,OVERWRITE)
								// ,fileservices.StartSuperFileTransaction 
								,fileservices.ClearSuperFile ('~thor_data400::BASE::License_Base') 
								,fileservices.AddSuperFile ('~thor_data400::BASE::License_Base', License_Base_file_name) 
								// ,fileservices.FinishSuperFileTransaction 
							 
	);
	
END;
*/
// Build_License_base(pversion, pIsTesting, pInFile)



import _control, tools,BIPV2;

export Build_License_base(

	 string														            pversion
	,dataset(Layouts.rec_license_combined_layout)	pBaseFile	= BIPV2.License_sources								
) :=
module
   

	Build_Base_File := tools.macf_WriteFile(Filenames(pversion).License_linkids.new	,pBaseFile  );
																																
	export full_base := sequential(Build_Base_File,promote(pversion).new2built);
		
end;