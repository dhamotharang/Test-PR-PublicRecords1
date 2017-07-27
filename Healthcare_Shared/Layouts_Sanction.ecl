EXPORT Layouts_Sanction := MODULE
	EXPORT sanction_rein_combined_layout := RECORD
		Healthcare_Shared.layouts_commonized.layout_all_sanction;
		DATASET(Healthcare_Shared.layouts_commonized.layout_all_sanction) reinstatements := DATASET([],Healthcare_Shared.layouts_commonized.layout_all_sanction);
	END;
	
	EXPORT sanction_processing_layout := RECORD
			Healthcare_Shared.layouts_commonized.layout_all_sanction;
			BOOLEAN isReinstated := false;
			BOOLEAN is113R_reinstatement := false;
	END;
END;
