EXPORT MAC := MODULE

	EXPORT AppendConsumerStatements(__inf, __outf, __statements, __lout, __csf = 'ConsumerStatements') := MACRO
		__outf := PROJECT(__inf, transform(__lout, self.__csf := __statements, self := left));
	ENDMACRO;
	
	EXPORT PrepareResultRecord(__results, __outrec, __statements, __lout) := MACRO
		IMPORT FFD,iesp;
		#uniquename(__res_statements);
		%__res_statements% := IF(EXISTS(__results),__statements,FFD.Constants.BlankConsumerStatements);
		
		#uniquename(__res_layout);
		%__res_layout% := RECORD
			DATASET(__lout) Records;
			DATASET(iesp.share_fcra.t_ConsumerStatement) Statements;
   	END;   			
		__outrec := ROW ({__results, %__res_statements%}, %__res_layout%);		
	ENDMACRO;
	
	EXPORT PrepareResultRecordBatch(__results, __outrec, __statements, __lout) := MACRO
		#uniquename(__res_layout);
		%__res_layout% := RECORD
			DATASET(__lout) Records;
			DATASET(FFD.Layouts.ConsumerStatementBatchFull) Statements;
   	END;   			
		__outrec := ROW ({__results, __statements}, %__res_layout%);		
	ENDMACRO;
	
	EXPORT HDRAppendStatementIDs(__inf, __outf, __lout, __slim_pc, __showDisputedRecs) := MACRO		
		__lout xformHDR( RECORDOF(__inf) l, FFD.Layouts.PersonContextBatchSlim r ) := 
		TRANSFORM, SKIP(~__showDisputedRecs AND r.isDisputed)																				 
			SELF.StatementIDs := r.StatementIds,
			SELF.IsDisputed   := r.IsDisputed,
			SELF := l
		END;			
		__outf := JOIN(__inf, __slim_pc(datagroup = FFD.Constants.DATAGROUPS.HDR),
				((UNSIGNED) LEFT.did = (UNSIGNED) RIGHT.lexid OR RIGHT.Acctno = FFD.Constants.SingleSearchAcctno) 
				AND	LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
				xformHDR(LEFT, RIGHT),
				LEFT OUTER, KEEP(1), LIMIT(0));
	ENDMACRO;
	
END;