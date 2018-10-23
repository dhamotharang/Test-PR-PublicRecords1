IMPORT DemoSearchTool, Data_Services;

EXPORT Constants := 
  MODULE
    
    EXPORT UNSIGNED2 JOIN_LIMIT        := 10000;
    EXPORT UNSIGNED1 BEST_JOIN_LIMIT   := 1;
    EXPORT UNSIGNED1 MAX_RECS_RETURNED := 100;
    EXPORT UNSIGNED1 HALF_MAX_RECS     := 50;
    EXPORT BOOLEAN   DEFAULT_BOOLEAN   := FALSE;
    EXPORT INTEGER2  DEFAULT_INTEGER   := -1;
    
    
    EXPORT UNSIGNED4 BIZ_HEADER_KFETCH_MAX_LIMIT := 10000;
    
    // used when neither Legacy or BIP keys search selection is made
    EXPORT BOOLEAN   SEARCH_BIP_KEYS_DEFAULT := TRUE; 
    
		EXPORT SearchTool_Prefix := Data_Services.default_data_location + 'thor_data400::key::searchtool::';
  END;