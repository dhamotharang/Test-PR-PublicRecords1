IMPORT AccountMonitoring;

// Interface used to easily pass parameters to a function during the monitoring process 
EXPORT i_Monitoring_Product_Config := 
	INTERFACE
	
		// Scalar values.
		EXPORT UNSIGNED8 product_mask_value;
		EXPORT BOOLEAN   product_is_in_mask;
		EXPORT BOOLEAN   monitorable_entities;	// TODO: remove; it's unused.
		EXPORT STRING    history_file_name;
		
		// Datasets.
		EXPORT DATASET(layouts.history) history_file;
		
		// Functions.
		EXPORT DATASET(layouts.history) generate_candidates();	
		
	END;