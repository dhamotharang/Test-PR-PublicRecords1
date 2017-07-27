IMPORT FFD, iesp, STD;

/*  This  function needs input of person context with the right datagroups. 
    This returns the ESDL version of the consumer statement output */
EXPORT  prepareConsumerStatements (DATASET (FFD.Layouts.PersonContextBatch) PersonContext) := FUNCTION


  // At this time we do not need disputed records: D-flag is returned within the results
  statements := PROJECT (PersonContext(RecordType IN [FFD.Constants.RecordType.RS,
                                                      FFD.Constants.RecordType.CS,
                                                      FFD.Constants.RecordType.HS,
                                                      FFD.Constants.RecordType.HSN,
                                                      FFD.Constants.RecordType.HSA,
                                                      FFD.Constants.RecordType.HSD,
                                                      FFD.Constants.RecordType.HSS,
                                                      FFD.Constants.RecordType.HSP,
                                                      FFD.Constants.RecordType.HSL
																											]),
                         TRANSFORM(iesp.share_fcra.t_ConsumerStatement,
                           self.UniqueId      := left.LexID,    
                           self.Timestamp     := iesp.ECL2ESP.toTimeStamp(STD.Str.FilterOut(left.DateAdded, '-:')),
                           self.StatementID   := left.StatementID,
                           self.StatementType := left.RecordType,
                           self.DataGroup     := left.DataGroup,
                           self.Content       := left.Content));

  RETURN statements;
END;
