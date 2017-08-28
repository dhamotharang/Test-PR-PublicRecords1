IMPORT FFD, iesp;

EXPORT Layouts :=
MODULE

	EXPORT Metadata := RECORD
		iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Meta')};
	END;

	EXPORT RecordIds := RECORD(iesp.fcradataservice_common.t_FcraDataServiceRecID)
	END;

	EXPORT ComplianceFlags := RECORD		
		BOOLEAN IsOverwritten := FALSE;
		BOOLEAN IsOverride := FALSE;
		BOOLEAN IsSuppressed := FALSE;
    BOOLEAN isDisputed := FALSE;
	END;
	
	EXPORT InternalMetadata := RECORD
		ComplianceFlags compliance_flags;
		RecordIds record_ids;
		UNSIGNED6 subject_did := 0;
		STRING100 combined_record_id := '';
		DATASET(FFD.Layouts.StatementIdRec) statement_ids := DATASET([], FFD.Layouts.StatementIdRec);
	END;
	
END;