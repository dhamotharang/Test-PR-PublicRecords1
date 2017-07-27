IMPORT FFD, BatchShare;
/*--SOAP-
<part name="IncludeAllPersonContext" type="xsd:boolean"/>
<part name="Batch_In" type="tns:XmlDataSet" cols="70" rows="25"/>	
<part name="Gateways" type="tns:XmlDataSet" cols="70" rows="8"/>
*/
EXPORT FetchPersonContextBatchServiceFCRA () := FUNCTION

	BatchIn   := 	dataset([], FFD.Layouts.DidBatch) : STORED('Batch_In');
	 
	// Standardize input
	BatchShare.MAC_SequenceInput(BatchIn, BatchInProcessed);
	InputParams := FFD_Services.iParam.getBatchParams(true);
	
	boolean isShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(InputParams.FFDOptionsMask);
												
	PersonContext := FFD.FetchPersonContext(BatchInProcessed, InputParams.Gateways);

	PersonContextOut := if(InputParams.IncludeAllPersonContext,
														PersonContext,
														PersonContext(RecordType = FFD.Constants.RecordType.CS));
	
	CSDResultsPre := project(PersonContextOut, 
													transform(FFD.Layouts.ConsumerStatementBatchFull,
														self.acctno 				:= left.acctno,
														self.SequenceNumber := 0,
														self.UniqueId				:= (integer)Left.LexId,
														self.DateAdded 			:= Left.DateAdded,
														self.SectionID			:= '',
														self.StatementID 		:= Left.StatementID,
														self.RecordType 		:= Left.RecordType,
														self.DataGroup 			:= Left.DataGroup,
														self.Content        := Left.Content ));
														
	//Restore account numbers
	BatchShare.MAC_RestoreAcctno(BatchInProcessed,CSDResultsPre, CSDResults, false, false);
	
	OUTPUT(BatchIn, NAMED('Results'));
RETURN OUTPUT(if(isShowConsumerStatements,CSDResults), NAMED('CSDResults'));
END;