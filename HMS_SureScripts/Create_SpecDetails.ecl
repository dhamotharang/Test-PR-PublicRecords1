IMPORT HMS_SureScripts;
EXPORT Create_SpecDetails(string pVersion) := MODULE
	SHARED DoTheBuild := Function
		MyFile := HMS_SureScripts.Files(pVersion).Spec_Details_In;
		MyFile_Base := HMS_SureScripts.Files(pVersion).Spec_Details_base;
		output(MyFile,, MyFile_Base, Compressed, Overwrite);
		Return '';
	END; // Function
	EXPORT ALL :=
		DOTheBuild;
END;
