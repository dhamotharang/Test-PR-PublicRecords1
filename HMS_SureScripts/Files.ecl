IMPORT tools, HMS_SureScripts;

EXPORT Files(STRING pversion = '', boolean pUseProd = false) := MODULE
	// In the follwoing line SureScripts_in changed to SureScripts_input so that it remains consistent with other attributes. Also, a superfile was created & used in
	// in the line below so that other files can be added in the superfile and not have to change the definition every time.
	shared inFile_raw := _Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name + '::' + pversion;
	shared inProf_Lic_File := _Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Prof_Lic_Name + '::' + 'in_prof_lic_taxonomy_map';
	shared inHMS_Spec_to_Taxonomy_File := _Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().HMS_Spec_to_Taxonomy + '::' + 'HMS_Spec_to_Taxonomy';	
	EXPORT baseFile := _Dataset(pUseProd).thor_cluster_Files+ 'base::' + _Dataset().Name + '::' + pversion;
	shared inFile := inFile_raw; //'~thor400_data::in::hms::surescripts::' + pversion;
	EXPORT SureScripts_File_raw := Dataset(inFile_raw,Layouts.SureScripts_In_raw, flat);
	EXPORT inProf_Lic_File_Raw := Dataset(inProf_Lic_File,Layouts.Prof_lic_Taxonomy_Input, flat);
	EXPORT SureScripts_File := Dataset(inFile,Layouts.SureScripts_In, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote('')));  //
	EXPORT Proc_Lic_File_Input := Dataset(inProf_Lic_File,Layouts.Prof_lic_Taxonomy_Input, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote('')));  
	EXPORT Proc_Lic_Mapping := _Dataset(pUseProd).thor_cluster_Files+ 'base::' + _Dataset().Prof_Lic_Name + '::' + pversion;
	EXPORT Proc_Lic_Mapping_base := Dataset(Proc_Lic_Mapping,HMS_SureScripts.Layouts.Prof_lic_Taxonomy_Mapping,THOR);
	EXPORT Spec_Details_Input := _Dataset(pUseProd).thor_cluster_Files+ 'In::' + _Dataset().Specialty_Name + '::' + 'SpecDetails';
	EXPORT Spec_Details_In := Dataset(Spec_Details_Input,HMS_SureScripts.Layouts.SpecDetails, csv( separator('\t'),heading(1), terminator(['\n', '\r\n']), quote('"')));
	EXPORT Spec_Details_Base := _Dataset(pUseProd).thor_cluster_Files+ 'Base::' + _Dataset().Specialty_Name + '::' + 'SpecDetails';	
	EXPORT HMS_Spec_to_Taxonomy_Input := Dataset(inHMS_Spec_to_Taxonomy_File,Layouts.HMS_Spec_to_Taxonomy_Input, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote('')));  
	EXPORT SureScripts_input := SureScripts_File;
	EXPORT SureScripts_input_raw := SureScripts_File_raw;
	EXPORT SureScripts_Base_LessOrig := Dataset('~thor400_data::base::hms::surescripts::Base_Less_Orig',Layouts.Base_Less_Orig, flat);
	EXPORT SureScripts_Base := Dataset(baseFile,HMS_SureScripts.Layouts.Base, THOR);
	tools.mac_FilesBase(Filenames(pversion,pUseProd).Base, layouts.Base, base);

END;