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

  // consumer statements as they are returned from PC-service for batch input
  EXPORT PersonContextBatch := RECORD
    STRING20 acctno;
    PersonContext.Layouts.Layout_PCResponseRec
  END;
	
	// These are the FFD fileds that will be used to determine statements & disputes associated to the raw record.
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

END;
