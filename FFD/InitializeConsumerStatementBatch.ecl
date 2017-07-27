IMPORT FFD, BatchShare;

EXPORT FFD.Layouts.ConsumerStatementBatch 
		InitializeConsumerStatementBatch(FFD.Layouts.StatementIdRec le,
			string2 rType, string section_id,	string dgroup, integer c =0,
			typeof(BatchShare.Layouts.ShareAcct.acctno)	acctno = '',
			unsigned6 did = 0) := TRANSFORM
				self.acctno         := acctno;
        self.StatementID    := le.statementId;
        self.SequenceNumber := c;
        self.UniqueId       := did;
        self.DateAdded      := '';
        self.SectionID      := section_id;
        self.RecordType     := rType;
        self.DataGroup      := dgroup;
END;