import Data_Services;
export SuperFile_List := MODULE
  SHARED lc := Data_Services.Data_location.prefix('ExperianCred');
	EXPORT Source_File			              := lc+'thor_data400::in::experiancred';
  EXPORT Base_File			                := lc+'thor_data400::base::Experiancred';
  EXPORT Base_File_slim			            := lc+'thor_data400::base::Experiancred::Slim';
  EXPORT Cache_Name_File			          := lc+'thor_data400::base::experiancred::Cache_name';
  EXPORT Cache_Address_File			        := lc+'thor_data400::base::experiancred::Cache_addr';
  EXPORT Source_File_History			    	:= lc+'thor_data400::in::Experiancred::History';
  EXPORT Source_Delete_File			        := lc+'thor_data400::in::experiancred_delete';
  EXPORT Source_Delete_File_Old			    := lc+'thor_data400::in::experiancred_delete_old24l';
  EXPORT Source_Delete_File_History			:= lc+'thor_data400::in::experiancred_delete_history';
  EXPORT Source_Deceased_File			      := lc+'thor_data400::in::experiancred_deceased';
  EXPORT Source_Deceased_File_history		:= lc+'thor_data400::in::experiancred_deceased_history';
  EXPORT Source_File_After_Name_Flip		:= lc+'thor_data400::in::experiancred_after_name_flip';
	
	EXPORT Source_Full_File_History			  		:= lc+'thor_data400::in::Experiancred_full::History';
  EXPORT Source_Delete_Full_File_History		:= lc+'thor_data400::in::experiancred_full_delete_history';
  EXPORT Source_Deceased_Full_File_history	:= lc+'thor_data400::in::experiancred_full_deceased_history';
END;