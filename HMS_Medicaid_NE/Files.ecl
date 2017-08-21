IMPORT tools, HMS_Medicaid_NE,HMS_Medicaid_Common;
Medicaid_State := 'NE';      
EXPORT Files(STRING pversion = '', boolean pUseProd = false) := MODULE
	// In the follwoing line SureScripts_in changed to SureScripts_input so that it remains consistent with other attributes. Also, a superfile was created & used in
	// in the line below so that other files can be added in the superfile and not have to change the definition every time.
	shared inFile_ := HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).thor_cluster_Files+ 'in::' + HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).Name + '::' + pversion;
	EXPORT baseFile := HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).thor_cluster_Files+ 'base::' + HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).Name + '::' + pversion;
	shared inFile := inFile_; //'~thor400_data::in::hms::Medicaid::' + pversion;
	//EXPORT Medicaid_File := Dataset(inFile_raw,Layouts.Medicaid_In_raw, flat);
	EXPORT Medicaid_File := Dataset(inFile,HMS_Medicaid_Common.Layouts.Medicaid_NE, csv( separator('\t'),heading(2), terminator(['\n', '\r\n']), quote('"')));  //EXPORT SureScripts_File := Dataset(inFile,Layouts.SureScripts_In_raw, flat);//csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote('')));  
	EXPORT Medicaid_input := Medicaid_File;
	//EXPORT Medicaid_input_Raw:= Medicaid_File_raw;
	tools.mac_FilesBase(HMS_Medicaid_Common.Filenames(Medicaid_State,pversion,pUseProd).Base, HMS_Medicaid_Common.layouts.Base_NE, base);

END;
   