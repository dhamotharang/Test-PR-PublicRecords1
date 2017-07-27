import ut;
export SuperFile_List := MODULE
	EXPORT Source_File :=           '~thor_data400::in::experiancred';
	EXPORT Base_File :=             '~thor_data400::base::Experiancred';
	EXPORT Base_File_slim :=        '~thor_data400::base::Experiancred::Slim';
	EXPORT Cache_Name_File :=       '~thor_data400::base::experiancred::Cache_name';
	EXPORT Cache_Address_File :=    '~thor_data400::base::experiancred::Cache_addr';
	EXPORT Source_File_Processed := '~thor_data400::base::Experiancred::History';
	EXPORT Source_Delete_File    := '~thor_data400::in::experiancred_delete';
	EXPORT Source_Delete_File_Old   := '~thor_data400::in::experiancred_delete_old24l';
	EXPORT Source_Deceased_File   := '~thor_data400::in::experiancred_deceased';
	EXPORT Source_File_After_Name_Flip  := '~thor_data400::in::experiancred_after_name_flip';
END;