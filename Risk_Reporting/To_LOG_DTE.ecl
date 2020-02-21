EXPORT To_LOG_DTE := MODULE

IMPORT Risk_Reporting;

EXPORT GetDTEOutput(TaskID = '', TaskDescription = '', Request_XML = '') := 
		FUNCTIONMACRO	
			
			DTE_Log_Out := 
				DATASET([{TaskID,
									  TaskDescription,
									  Request_XML
								}],Risk_Reporting.Layouts.LOG_DTE_Layout);			
			
			RETURN DTE_Log_Out;
			
	ENDMACRO;	

END;
