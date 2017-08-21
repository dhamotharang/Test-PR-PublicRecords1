IMPORT tools, HMS_Medicaid_NY, HMS_Medicaid_Common;

EXPORT Files(STRING pversion = '', boolean pUseProd = false) := MODULE
	// In the follwoing line SureScripts_in changed to SureScripts_input so that it remains consistent with other attributes. Also, a superfile was created & used in
	// in the line below so that other files can be added in the superfile and not have to change the definition every time.
	shared inFile_ := HMS_Medicaid_Common._Dataset('VT',pUseProd).thor_cluster_Files+ 'in::' + HMS_Medicaid_Common._Dataset('VT',pUseProd).Name + '::' + pversion;
	EXPORT baseFile := HMS_Medicaid_Common._Dataset('VT',pUseProd).thor_cluster_Files+ 'base::' + HMS_Medicaid_Common._Dataset('VT',pUseProd).Name + '::' + pversion;
	shared inFile := inFile_; //'~thor400_data::in::hms::Medicaid::' + pversion;
	EXPORT Medicaid_File := Dataset(inFile,HMS_Medicaid_Common.Layouts.Medicaid_VT, csv( separator('\t'),heading(2), terminator(['\n', '\r\n']), quote('"')));  //EXPORT SureScripts_File := Dataset(inFile,Layouts.SureScripts_In_raw, flat);//csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote('')));  
	EXPORT Medicaid_input := Medicaid_File;
	//EXPORT Medicaid_input_raw := Medicaid_File_raw;
	// EXPORT Medicaid_Base := Dataset(baseFile,HMS_Medicaid.Layouts.Base, THOR);
	tools.mac_FilesBase(HMS_Medicaid_Common.FileNames('VT',pversion,pUseProd).Base, HMS_Medicaid_Common.layouts.Base_VT, base);

END;