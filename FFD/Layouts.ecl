IMPORT PersonContext, iesp, doxie;

EXPORT Layouts := MODULE 

  EXPORT StatementIdRec := RECORD(iesp.share_fcra.t_StatementIdRec)
    STRING5			RecordType {xpath('StatementType')} := ''; // needed to distinguish ids for header, xpath statement type to be consistent with iesp.share_fcra.t_ConsumerStatement.
  END;

  // Statements as they appear in the batch output
  EXPORT ConsumerStatementBatch := RECORD
    STRING20 		acctno := '0';
    INTEGER			SequenceNumber;
    TYPEOF(doxie.layout_references.did) UniqueId;	//ie, LexId
    STRING22		DateAdded;			// timestamp when statement added to file
    STRING50   	SectionID; 			//...or CD_Id?
    UNSIGNED5		StatementID;		// Unique ID created per statement. Used here to associate statement with it's record
    STRING5			RecordType;	    // Which type of statement is returned. Values on p.18 of design
    STRING50		DataGroup;			// Type of data the statement pertains to.
  END;
  
  EXPORT ConsumerStatementBatchFull := RECORD(ConsumerStatementBatch)
    STRING3000	Content;				// The actual statement itself
  END;
  
  EXPORT ConsumerStatementBatchFullFlat := RECORD
    STRING20 		acctno := '0';
    STRING20		SequenceNumber;
    STRING20		UniqueId;	//ie, LexId
    STRING22		DateAdded;			// timestamp when statement added to file
    STRING50   	SectionID; 			//...or CD_Id?
    STRING20		StatementID;		// Unique ID created per statement. Used here to associate statement with it's record
    STRING5			RecordType;	    // Which type of statement is returned. Values on p.18 of design
    STRING50		DataGroup;			// Type of data the statement pertains to.
    STRING3000	Content;				// The actual statement itself
  END;

  //TODO: coonsider moving it to batch-share
  EXPORT DidBatch := RECORD
    STRING20 acctno;
    doxie.layout_references.did;
  END;

  SHARED SecurityFreezeSuppression := RECORD
    BOOLEAN apply_to_all := FALSE; // set if we find * in content field.
    SET OF INTEGER set_FCRA_purpose := []; // list of FCRA permissible purposes for which Security Freeze Alert should be applied
  END; 

  // expanded layout with consumer info as it is returned from PC-service 
  EXPORT PersonContextBatch := RECORD
    STRING20 acctno;  //for batch input
    BOOLEAN suppress_for_legal_hold := FALSE; // indicator whether all data has to be suppressed if Legal Hold alert is set
    SecurityFreezeSuppression security_freeze_suppression;
    PersonContext.Layouts.Layout_PCResponseRec;
  END;
  
  EXPORT PersonContextBatchResponse := RECORD
    iesp.share.t_ResponseHeader _Header;
    DATASET(PersonContextBatch) Records;
  END;

  // These are the FFD fields that will be used to determine statements & disputes associated to the raw record.
  EXPORT CommonRawRecordElements:= RECORD
    DATASET(StatementIdRec) StatementIds {xpath('StatementIdRecs/StatementIdRec')} := DATASET([], StatementIdRec);
    BOOLEAN isDisputed {xpath('IsDisputed')} := FALSE;
  END;
  
  // StatementID and RecordType should be added to the not list. 
  EXPORT PersonContextBatchSlim := RECORD(CommonRawRecordElements)
    STRING20 acctno;	
    PersonContext.Layouts.Layout_PCResponseRec AND NOT [StatementID, RecordType, SearchStatus, CD_Id, DataTypeVersion,
                                                        DateAdded, EventType, SourceSystem, StatementSequence, Content];
  END;

  
  EXPORT ConsumerFlags := RECORD
    STRING1 alert_security_freeze {xpath('alert_security_freeze')} := '';
    STRING1 alert_security_fraud {xpath('alert_security_fraud')} := '';
    STRING1 alert_identity_theft {xpath('alert_identity_theft')} := '';
    STRING1 alert_legal_flag {xpath('alert_legal_flag')} := '';
    STRING1 alert_cnsmr_statement {xpath('alert_cnsmr_statement')} := ''; 
  END;

  EXPORT ConsumerFlagsBatch := RECORD
    STRING20 		acctno := '0';
    STRING20		UniqueId;	//ie, LexId
    BOOLEAN     suppress_records := FALSE; 
    ConsumerFlags  consumer_flags;  
    BOOLEAN has_record_statement := FALSE;  // keeping for internal use to set alert_cnsmr_statement later
    BOOLEAN has_consumer_statement := FALSE;  // keeping for internal use to set alert_cnsmr_statement later
  END;
  
  EXPORT ConsumerLogInquiry := RECORD (iesp.share_fcra.t_FcraConsumer)
  END;
    
  EXPORT CIA_data := RECORD
    BOOLEAN  suppress_records := FALSE; 
    DATASET(iesp.share_fcra.t_ConsumerAlert) ConsumerAlerts;
    DATASET(iesp.share_fcra.t_ConsumerStatement) ConsumerStatements;
    DATASET(PersonContextBatch) PersonContext;
  END;

END;
