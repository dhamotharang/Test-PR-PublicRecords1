EXPORT MAC := MODULE

	EXPORT AppendConsumerAlertsAndStatements(__inf, __outf, __statements, __alerts, __consumer, __lout, __csf = 'ConsumerStatements', __caf = 'ConsumerAlerts', __cnsmr = 'Consumer') := MACRO
		__outf := PROJECT(__inf, transform(__lout, 
                                        self.__caf := __alerts, 
                                        self.__csf := __statements, 
                                        self.__cnsmr := __consumer, 
                                        self := left, self:=[]));
	ENDMACRO;
	
	EXPORT PrepareConsumerRecord(__lexId, __isByLexId = TRUE, __searchby = '') := FUNCTIONMACRO
		IMPORT FFD,iesp, AutoStandardI;

	  iesp.share_fcra.t_FcraConsumer SetConsumerRecord() := TRANSFORM
		  SELF.Lexid := __lexId;
			#IF(__isByLexId)
			  SELF.Inquiry.UniqueId := __lexId;  // for report ESDL queries we have only input UniqueId
			#ELSIF(#TEXT(__searchby)<>'')
		    SELF.Inquiry.DOB := iesp.ECL2ESP.t_DateToString8(__searchby.DOB);
		    SELF.Inquiry := __searchby;
			#END
		  SELF := [];
	  END;
		__outrec := ROW(SetConsumerRecord()); 
    RETURN 	__outrec;	
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
//			DATASET(iesp.share_fcra.t_FcraConsumer) Consumer;
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
	
	EXPORT ApplyConsumerAlertsBatch(__inf, __alert_flags, __statementids, __lout, LexidField='') := FUNCTIONMACRO		

		__lout xf_apply_alerts( RECORDOF(__inf) l, FFD.Layouts.ConsumerFlagsBatch r ) := 
		TRANSFORM, SKIP(r.suppress_records)																				 
			SELF.acctno := IF((UNSIGNED)l.acctno <> 0, l.acctno, r.acctno);
			// in batch we filter consumer statements to keep only referencing actual results. Person context may contain more record level statements than what is returned. Alert flag is set only if statements are returned
			SELF.alert_cnsmr_statement := IF(r.has_consumer_statement OR EXISTS(l.__statementids(RecordType IN FFD.Constants.RecordType.StatementRecordLevel)), FFD.Constants.subject_has_alert, '');
			SELF := r.consumer_flags;
			 #if(#TEXT(LexidField)<>'')
					SELF.LexidField	:= IF((UNSIGNED)l.LexidField <> 0, l.LexidField, r.UniqueID); 
				#end
			SELF := l;
		END;			

		__res_ftr := JOIN(__inf, __alert_flags,
			#if(#TEXT(LexidField)<>'')
					(UNSIGNED) LEFT.LexidField	= (UNSIGNED) RIGHT.UniqueID  AND 
				#end
				LEFT.acctno = RIGHT.acctno, 
				xf_apply_alerts(LEFT, RIGHT), 
				FULL OUTER, LIMIT(0));
    
    // now we add single record per account for all cases where we had to skip all records due to suppression
		__rec_suppr := PROJECT( __alert_flags(suppress_records),
				TRANSFORM(__lout, SELF.acctno:=LEFT.acctno, 
			 #if(#TEXT(LexidField)<>'')
					SELF.LexidField	:= LEFT.UniqueID, 
				#end
				SELF.alert_cnsmr_statement := IF(LEFT.has_consumer_statement, FFD.Constants.subject_has_alert, ''),
				SELF := LEFT.consumer_flags,  // put other alert flags here
				SELF :=[]) 
				); 
				
		__outf := __rec_suppr + __res_ftr;
				
		RETURN __outf;
	ENDMACRO;

END;