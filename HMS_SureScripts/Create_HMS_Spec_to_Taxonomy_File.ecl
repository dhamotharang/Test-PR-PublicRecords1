IMPORT HMS_SureScripts;
EXPORT Create_HMS_Spec_to_Taxonomy_File(STRING pversion, BOOLEAN pprod = false):= MODULE
	SHARED DoTheBuild  := Function
		MyFile := HMS_SureScripts.Update_HMS_SPEC_To_Taxonomy_Base(pversion, pprod)._base;
		
		//count(myFile);
		output(MyFile,,'~Thor400_Data::BASE::HMS::SureScripts::HMS_SPEC_To_Taxonomy::'+'HMS_SPEC_To_Taxonomy', Compressed, overwrite,THOR);
	Return '';
	End; //Function
		EXPORT ALL := 		DOTheBuild;
END;