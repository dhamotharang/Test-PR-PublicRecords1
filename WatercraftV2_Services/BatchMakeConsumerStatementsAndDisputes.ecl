#warning('this attribute has been deprecated');
import FFD;

export BatchMakeConsumerStatementsAndDisputes(dataset(WatercraftV2_Services.Layouts.batch_out_pre) batch_out_pre , 
																		dataset(FFD.Layouts.PersonContextBatch) PersonContext
																		) := function


	out :=  normalize(batch_out_pre,left.Statements,
											transform(FFD.Layouts.ConsumerStatementBatch,
																 self.SequenceNumber := left.SequenceNumber,
																 self.acctno := left.acctno, 
																 self := right));

	StatementsAndDisputes := FFD.prepareConsumerStatementsBatch(out,PersonContext);

//		output(out,named('out'));
//		output(StatementsAndDisputes,named('StatementsAndDisputes'));

	return(StatementsAndDisputes);
end;
