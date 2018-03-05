IMPORT doxie, FFD, Gateway;

EXPORT functions := module



export fetchConsumerStatementsForDID(typeof(doxie.layout_references.did) DID,
																		 dataset(Gateway.Layouts.Config) Gateways) := function

	dsDID := dataset([{FFD.Constants.SingleSearchAcctno,DID}],FFD.Layouts.DidBatch);											
	PersonContext := FFD.FetchPersonContext(dsDID, Gateways);

	PersonContextOut := PersonContext(RecordType = FFD.Constants.RecordType.CS);
	ConsumerStatements := FFD.prepareConsumerStatements(PersonContextOut);
	
return(ConsumerStatements);
end;


export varstring StatusMessages(integer c , string equifax_message = '') :=
	CASE(c,	
		 0 => 'Hit : record exists for input SSN',
		 1	=> 'No Hit : LN could not find a unique LexID for the customer input information',
		 2	=> 'No Hit : LN could not find a unique LexID for the output information coming back from Vendor',
		 3	=> 'No Hit : Mismatch. The LexID captured on input did not match the LexID resolved to from Vendor’s output',
		 4	=> 'No Hit : Vendor Error.  Please call your LN Sales Rep or try again later : ' + equifax_message,
							 'No Hit :  Database Error');
											 
end;