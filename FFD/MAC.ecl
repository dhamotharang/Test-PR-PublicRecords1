EXPORT MAC := MODULE

	EXPORT AppendConsumerStatements(__inf, __outf, __statements, __lout, __csf = 'ConsumerStatements') := MACRO
		__outf := PROJECT(__inf, transform(__lout, self.__csf := __statements, self := left, self:=[]));
	ENDMACRO;
	
	EXPORT PrepareResultRecord(__results, __outrec, __statements, __alerts, __lout) := MACRO
		IMPORT FFD,iesp;
		#uniquename(__res_statements);
		%__res_statements% := IF(EXISTS(__results),__statements,__statements(StatementType IN FFD.Constants.RecordType.StatementConsumerLevel));
		
		#uniquename(__res_layout);
		%__res_layout% := RECORD
			DATASET(__lout) Records;
			DATASET(iesp.share_fcra.t_ConsumerStatement) Statements;
			DATASET(iesp.share_fcra.t_ConsumerAlert) ConsumerAlerts;
   	END;   			
		__outrec := ROW ({__results, %__res_statements%, __alerts}, %__res_layout%);		
	ENDMACRO;
	
	EXPORT PrepareResultRecordBatch(__results, __outrec, __statements, __lout) := MACRO
		#uniquename(__res_layout);
		%__res_layout% := RECORD
			DATASET(__lout) Records;
			DATASET(FFD.Layouts.ConsumerStatementBatchFull) Statements;  // includes all consumer info
   	END;   			
		__outrec := ROW ({__results, __statements}, %__res_layout%);		
	ENDMACRO;
	
	EXPORT ApplyConsumerAlertsBatch(__inf, __outf, __alert_pc) := MACRO		
		#uniquename(xf_apply_alerts);
		__lout %xf_apply_alerts%( RECORDOF(__inf) l, FFD.Layouts.AlertIndicatorBatch r ) := 
		TRANSFORM, SKIP(r.suppress_records)																				 
			SELF.acctno := IF((UNSIGNED)l.acctno <> 0, l.acctno, r.acctno);
			SELF := r.consumer_flags;
			SELF := l;
		END;			
		#uniquename(__res_ftr);
		%__res_ftr% := JOIN(__inf, __alert_pc,
				LEFT.acctno = RIGHT.acctno, 
				%xf_apply_alerts%(LEFT, RIGHT), 
				FULL OUTER, KEEP(1), LIMIT(0));
    
    // now we add single record per account for all cases where we had to skip all records due to suppression
		__outf := PROJECT( __alert_pc(suppress_records),
				TRANSFORM(RECORDOF(__inf), SELF.acctno:=LEFT.acctno, SELF := r.consumer_flags, SELF :=[]) // put alert flags here
				) + %__res_ftr%;
	ENDMACRO;

	EXPORT AppendConsumerAlerts(__inf, __outf, __alerts, __lout, __caf = 'ConsumerAlerts') := MACRO
		__outf := PROJECT(__inf, transform(__lout, self.__caf := __alerts, self := left, self:=[]));
	ENDMACRO;
	
	
END;