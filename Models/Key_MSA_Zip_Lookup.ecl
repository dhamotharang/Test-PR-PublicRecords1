import Models, doxie, ut, Data_Services, lib_Stringlib;


EXPORT Key_MSA_Zip_Lookup(boolean IsFCRA = false) := function

	msa_zip_lookup_base := Models.File_MSA_Zip_Lookup.MSA_Zip_Base;

	Models.File_MSA_Zip_Lookup.layout_msa_zip cleanup(Models.File_MSA_Zip_Lookup.layout_msa_zip le) := TRANSFORM
		self.zip := INTFORMAT((integer)le.zip,5,1);
		self.msa := StringLib.StringToUpperCase(le.msa);
	END;

	final := project(msa_zip_lookup_base, cleanup(left));

	filename := if (IsFCRA, 
									Data_Services.Data_location.Prefix('DEFAULT') + 'thor_data400::key::models::fcra::' + doxie.Version_SuperKey + '::msa_zip_lookup',
									Data_Services.Data_location.Prefix('DEFAULT') + 'thor_data400::key::models::' + doxie.Version_SuperKey + '::msa_zip_lookup');

	return index(final, {zip}, {final}, filename);								
								
end;