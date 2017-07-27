import ut;
export SuperFile_List := MODULE
	EXPORT IRSG_Source_File :=           '~thor_data400::in::ExperianIRSG_build';
	EXPORT IRSG_Base_File :=             '~thor_data400::base::ExperianIRSG_build';
	EXPORT IRSG_Cache_Name_File :=       '~thor_data400::base::ExperianIRSG_build::Cache_name';
	EXPORT IRSG_Cache_Address_File :=    '~thor_data400::base::ExperianIRSG_build::Cache_addr';
	EXPORT IRSG_Source_File_Processed := '~thor_data400::base::ExperianIRSG_build::History';
	
END;