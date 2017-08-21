IMPORT tools, HMS_Medicaid_NY, HMS_Medicaid_Common;

EXPORT Files(STRING pversion = '', boolean pUseProd = false) := MODULE
	shared inFile_ := HMS_Medicaid_Common._Dataset('NY',pUseProd).thor_cluster_Files+ 'in::' + HMS_Medicaid_Common._Dataset('NY',pUseProd).Name + '::' + pversion + '::' + 'AllSheets';
	EXPORT baseFile := HMS_Medicaid_Common._Dataset('NY',pUseProd).thor_cluster_Files+ 'base::' + HMS_Medicaid_Common._Dataset('NY',pUseProd).Name + '::' + pversion;
	shared inFile := inFile_; //'~thor400_data::in::hms::Medicaid::' + pversion;
	EXPORT Medicaid_File := Dataset(inFile,HMS_Medicaid_Common.Layouts.Medicaid_NY, THOR);  
	EXPORT Medicaid_input := Medicaid_File;
	tools.mac_FilesBase(HMS_Medicaid_Common.FileNames('NY',pversion,pUseProd).Base, HMS_Medicaid_Common.layouts.Base_NY, base);

END;