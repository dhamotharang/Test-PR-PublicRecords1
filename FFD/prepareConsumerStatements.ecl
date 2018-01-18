IMPORT FFD, iesp, STD;

/*  This  function needs input of person context with the right datagroups. 
    It returns the ESDL version of the consumer statement output */
EXPORT  prepareConsumerStatements (DATASET (FFD.Layouts.PersonContextBatch) PersonContext) := FUNCTION


  // At this time we do not need disputed records: D-flag is returned within the results
  statements := PROJECT (PersonContext(RecordType IN [FFD.Constants.RecordType.StatementRecordLevel,
                                                      FFD.Constants.RecordType.StatementConsumerLevel
																											]),
                         TRANSFORM(iesp.share_fcra.t_ConsumerStatement,
                           SELF.UniqueId      := LEFT.LexID,    
                           SELF.Timestamp     := iesp.ECL2ESP.toTimeStamp(STD.Str.FilterOut(LEFT.DateAdded, '-:')),
                           SELF.StatementID   := LEFT.StatementID,
                           SELF.StatementType := LEFT.RecordType,
                           SELF.DataGroup     := LEFT.DataGroup,
                           SELF.Content       := LEFT.Content));

  RETURN statements;
END;
