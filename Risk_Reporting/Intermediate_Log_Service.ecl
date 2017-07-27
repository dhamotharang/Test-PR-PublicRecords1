/*--SOAP--
<message name="Intermediate_Log_Service" wuTimeout="300000">
	<part name="GetTransactionDetailRequest" type="tns:XmlDataSet" cols="200" rows="15"/>
</message>
*/
/*--INFO-- Intermediate Log Service - Returns Intermediate Shell XML for Realtime Transactions Stored on Roxie */
/*--HELP-- 
<pre>
&lt;GetTransactionDetailRequest&gt;
  &lt;Row&gt;
    &lt;TransactionId&gt;&lt;/TransactionId&gt;
  &lt;/Row&gt;
&lt;/GetTransactionDetailRequest&gt;
</pre>
*/


IMPORT iesp, Score_Logs, Risk_Reporting, UT, RISKWISE;

EXPORT Intermediate_Log_Service() := FUNCTION
	/* ********************************************
	 *            Grab Service Inputs             *
	 ********************************************** */
  requestIn := DATASET([], iesp.ws_support.t_GetTransactionDetailRequest)  	: STORED('GetTransactionDetailRequest', FEW);
  firstRow := requestIn[1] : INDEPENDENT; // Since this is realtime and not batch, should only have one row on input.
	transactionID := TRIM(GLOBAL(firstRow.TransactionId));
	transaction := DATASET([{transactionID}], {STRING30 transID});
	product := TRIM(StringLib.StringToUpperCase(GLOBAL(firstRow.Product)));
	
	// Due to the size of the Shells, we are exceeding the 20,000 Byte limit of Indexes, to get around this the Boca Shell XML was split up into multiple keys - you must hit all 9 to recreate the full XML
	LogFileLayoutExpanded := RECORD
		UNSIGNED1			Log__Seq := 0;
		STRING162000	Shell_XML := '';
		Score_Logs.Key_ScoreLogs_XMLIntermediatePt1;
	END;
	LogFileLayout := RECORDOF(Score_Logs.Key_ScoreLogs_XMLIntermediatePt1);
	LogFile1 := Score_Logs.Key_ScoreLogs_XMLIntermediatePt1;
	LogFile2 := Score_Logs.Key_ScoreLogs_XMLIntermediatePt2;
	LogFile3 := Score_Logs.Key_ScoreLogs_XMLIntermediatePt3;
	LogFile4 := Score_Logs.Key_ScoreLogs_XMLIntermediatePt4;
	LogFile5 := Score_Logs.Key_ScoreLogs_XMLIntermediatePt5;
	LogFile6 := Score_Logs.Key_ScoreLogs_XMLIntermediatePt6;
	LogFile7 := Score_Logs.Key_ScoreLogs_XMLIntermediatePt7;
	LogFile8 := Score_Logs.Key_ScoreLogs_XMLIntermediatePt8;
	LogFile9 := Score_Logs.Key_ScoreLogs_XMLIntermediatePt9;

	/* ********************************************
	 *        Get Input XML and Output XML        *
	 ********************************************** */
	LogFileLayoutExpanded getLogFile(transaction le, LogFileLayout keyRec, UNSIGNED1 Log_Seq) := TRANSFORM
		SELF.Log__Seq := Log_Seq; // Need to join them back together in order
		SELF.Shell_XML := keyRec.outputxml;
		SELF := keyRec;
	END;
	logResults1 := IF(transactionID != '', JOIN(transaction, LogFile1, KEYED(LEFT.transID = RIGHT.transaction_id), getLogFile(LEFT, RIGHT, 1), ATMOST(Riskwise.max_atmost), KEEP(1)),
																				DATASET([], LogFileLayoutExpanded));
	logResults2 := IF(transactionID != '', JOIN(transaction, LogFile2, KEYED(LEFT.transID = RIGHT.transaction_id), getLogFile(LEFT, RIGHT, 2), ATMOST(Riskwise.max_atmost), KEEP(1)),
																				DATASET([], LogFileLayoutExpanded));
	logResults3 := IF(transactionID != '', JOIN(transaction, LogFile3, KEYED(LEFT.transID = RIGHT.transaction_id), getLogFile(LEFT, RIGHT, 3), ATMOST(Riskwise.max_atmost), KEEP(1)),
																				DATASET([], LogFileLayoutExpanded));
	logResults4 := IF(transactionID != '', JOIN(transaction, LogFile4, KEYED(LEFT.transID = RIGHT.transaction_id), getLogFile(LEFT, RIGHT, 4), ATMOST(Riskwise.max_atmost), KEEP(1)),
																				DATASET([], LogFileLayoutExpanded));
	logResults5 := IF(transactionID != '', JOIN(transaction, LogFile5, KEYED(LEFT.transID = RIGHT.transaction_id), getLogFile(LEFT, RIGHT, 5), ATMOST(Riskwise.max_atmost), KEEP(1)),
																				DATASET([], LogFileLayoutExpanded));
	logResults6 := IF(transactionID != '', JOIN(transaction, LogFile6, KEYED(LEFT.transID = RIGHT.transaction_id), getLogFile(LEFT, RIGHT, 6), ATMOST(Riskwise.max_atmost), KEEP(1)),
																				DATASET([], LogFileLayoutExpanded));
	logResults7 := IF(transactionID != '', JOIN(transaction, LogFile7, KEYED(LEFT.transID = RIGHT.transaction_id), getLogFile(LEFT, RIGHT, 7), ATMOST(Riskwise.max_atmost), KEEP(1)),
																				DATASET([], LogFileLayoutExpanded));
	logResults8 := IF(transactionID != '', JOIN(transaction, LogFile8, KEYED(LEFT.transID = RIGHT.transaction_id), getLogFile(LEFT, RIGHT, 8), ATMOST(Riskwise.max_atmost), KEEP(1)),
																				DATASET([], LogFileLayoutExpanded));
	logResults9 := IF(transactionID != '', JOIN(transaction, LogFile9, KEYED(LEFT.transID = RIGHT.transaction_id), getLogFile(LEFT, RIGHT, 9), ATMOST(Riskwise.max_atmost), KEEP(1)),
																				DATASET([], LogFileLayoutExpanded));
																				
	logResultsCombined := SORT(logResults1 + logResults2 + logResults3 + logResults4 + logResults5 + logResults6 + logResults7 + logResults8 + logResults9, transaction_id, Log__Seq);
	
	LogFileLayoutExpanded combineLogs(LogFileLayoutExpanded le, LogFileLayoutExpanded ri) := TRANSFORM
		SELF.Shell_XML := TRIM(le.Shell_XML) + TRIM(ri.Shell_XML);
		SELF := le;
	END;
	logResults := ROLLUP(logResultsCombined, LEFT.transaction_id = RIGHT.transaction_id, combineLogs(LEFT, RIGHT));
	
	/* ***************************************
	 *      Convert Log Results to ESDL:     *
   ***************************************** */
	oneRecord := ut.ds_oneRecord;
	
	iesp.ws_support.t_TransactionDetailRecord convertLogs(LogFileLayoutExpanded le) := TRANSFORM
		SELF.DateAdded					:= IF(LENGTH(TRIM(le.datetime)) = 15, le.datetime[1..4] + '-' + le.datetime[5..6] + '-' + le.datetime[7..11] + ':' + le.datetime[12..13] + ':' + le.datetime[14..15], TRIM(le.datetime));
		SELF.VendorResponseTime	:= '';
		SELF.VendorCode					:= '';
		SELF._Type							:= '0';
		SELF.Version						:= 0;
		SELF.ProcessType				:= Risk_Reporting.ProcessType.Internal;
		SELF.ReferenceNumber		:= le.transaction_id;
		SELF.Content						:= le.Shell_XML;
	END;
	
  iesp.ws_support.t_TransactionDetailResponse intoFinal(oneRecord le) := TRANSFORM
		SELF.TransactionDetails		:= PROJECT(logResults, convertLogs(LEFT));
	END;
	final := PROJECT(oneRecord, intoFinal(LEFT));
	
	/* *****************************************
	 *   DEBUGGING OUTPUTS, DISABLE FOR PROD   *
	 ******************************************* */
	// OUTPUT(logResults1, NAMED('logResults1'));
	// OUTPUT(logResults2, NAMED('logResults2'));
	// OUTPUT(logResults3, NAMED('logResults3'));
	// OUTPUT(logResults4, NAMED('logResults4'));
	// OUTPUT(logResults5, NAMED('logResults5'));
	// OUTPUT(logResults6, NAMED('logResults6'));
	// OUTPUT(logResults7, NAMED('logResults7'));
	// OUTPUT(logResults8, NAMED('logResults8'));
	// OUTPUT(logResults9, NAMED('logResults9'));
	// OUTPUT(logResultsCombined, NAMED('logResultsCombined'));
	// OUTPUT(logResults, NAMED('logResults'));
	
	/* ***************************************
	 *              Final Output:            *
   ***************************************** */	
	RETURN OUTPUT(final, NAMED('Results'));
END;