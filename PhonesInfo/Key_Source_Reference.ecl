Import Data_Services, doxie;
EXPORT Key_Source_Reference := MODULE;

inFile	:=PhonesInfo.File_Source_Reference.main;
	
export ocn_name := index(inFile
																				,{ocn,name}
																				,{inFile}
																				,Data_Services.Data_location.Prefix()+'thor_data400::key::phonesmetadata::carrier_reference_'+doxie.Version_SuperKey);

END;