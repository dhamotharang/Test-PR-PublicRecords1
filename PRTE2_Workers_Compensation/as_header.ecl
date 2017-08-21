IMPORT Header, Business_Header, PRTE2_Workers_Compensation, MDR,  Workers_Compensation;

EXPORT as_header := MODULE

	EXPORT business_header_linking_workers_compensation := FUNCTION
		RETURN Workers_Compensation.fAs_Business_Linking(Files.file_keybuild(bdid<>0));	
	END;

END;