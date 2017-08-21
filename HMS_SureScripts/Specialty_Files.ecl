IMPORT tools, HMS_SureScripts;

EXPORT Specialty_Files(STRING pversion = '', boolean pUseProd = false) := MODULE
	// In the follwoing line SureScripts_in changed to SureScripts_input so that it remains consistent with other attributes. Also, a superfile was created & used in
	// in the line below so that other files can be added in the superfile and not have to change the definition every time.
	EXPORT inFile := _Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Specialty_Name + '::' + pversion;
	EXPORT baseFile := _Dataset(pUseProd).thor_cluster_Files+ 'base::' + _Dataset().Specialty_Name + '::' + pversion;
	//EXPORT Raw_Specs_File := Dataset('~Thor400_Data::IN::HMS::SureScripts::SpecCodes::' + pversion,HMS_SureScripts.Layouts.Spec_Codes, csv( separator('\t'),heading(1), terminator(['\n', '\r\n']), quote('"')));	
	EXPORT Raw_Specs_File := Dataset(inFile,HMS_SureScripts.Layouts.Spec_Codes, csv( separator('\t'),heading(1), terminator(['\n', '\r\n']), quote('"')));	
	EXPORT Specialty_Base := Dataset(baseFile,HMS_SureScripts.Layouts.Spec_Codes, THOR);
	tools.mac_FilesBase(Filenames_SpecCodes(pversion,pUseProd).Base, HMS_SureScripts.layouts.Base_Spec_Codes, Base);

END;