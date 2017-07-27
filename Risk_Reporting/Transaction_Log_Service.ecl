/*--SOAP--
<message name="Transaction_Log_Service" wuTimeout="300000">
	<part name="GetTransactionLogOnlineRequest" type="tns:XmlDataSet" cols="200" rows="15"/>
</message>
*/
/*--INFO-- Transaction Log Service - Returns Input XML and Output XML for Realtime Transactions Stored on Roxie */
/*--HELP-- 
<pre>
&lt;GetTransactionLogOnlineRequest&gt;
  &lt;Row&gt;
    &lt;TransactionId&gt;&lt;/TransactionId&gt;
  &lt;/Row&gt;
&lt;/GetTransactionLogOnlineRequest&gt;
</pre>
*/


IMPORT iesp, Score_Logs, Risk_Reporting, UT;

EXPORT Transaction_Log_Service := MACRO
	/* ********************************************
	 *            Grab Service Inputs             *
	 ********************************************** */
  requestIn := DATASET([], iesp.ws_support.t_GetTransactionLogOnlineRequest)  	: STORED('GetTransactionLogOnlineRequest', FEW);
  firstRow := requestIn[1] : INDEPENDENT; // Since this is realtime and not batch, should only have one row on input.
	transactionID := TRIM(GLOBAL(firstRow.TransactionId));
	transaction := DATASET([{transactionID}], {STRING30 transID});
	product := TRIM(StringLib.StringToUpperCase(GLOBAL(firstRow.Product)));
	
	LogFile := Score_Logs.Key_ScoreLogs_XMLTransactionID;

	/* ********************************************
	 *        Get Input XML and Output XML        *
	 ********************************************** */
	RECORDOF(LogFile) getLogFile(transaction le, LogFile keyRec) := TRANSFORM
		SELF := keyRec;
	END;
	logResults := IF(transactionID != '', JOIN(transaction, LogFile, KEYED(LEFT.transID = RIGHT.transaction_id), getLogFile(LEFT, RIGHT), ATMOST(Riskwise.max_atmost), KEEP(1)),
																				DATASET([], RECORDOF(LogFile)));
	
	/* ***************************************
	 *      Convert Log Results to ESDL:     *
   ***************************************** */
	oneRecord := ut.ds_oneRecord;
	
	iesp.ws_support.t_TransactionLogOnline convertLogs(logResults le) := TRANSFORM
		SELF._type						:= '0';
		SELF.request_format		:= 'XML';
		SELF.request_data			:= TRIM((STRING3072)le.inputxml[1..3072]);
		SELF.response_format	:= 'XML';
		SELF.response_data		:= TRIM((STRING30720)le.outputxml[1..30720]);
		SELF.date_added				:= IF(LENGTH(TRIM(le.datetime)) = 15, le.datetime[1..4] + '-' + le.datetime[5..6] + '-' + le.datetime[7..11] + ':' + le.datetime[12..13] + ':' + le.datetime[14..15], TRIM(le.datetime));
	END;
	
  iesp.ws_support.t_GetTransactionLogOnlineResponse intoFinal(oneRecord le) := TRANSFORM
		SELF.TransactionLogOnline		:= PROJECT(logResults, convertLogs(LEFT))[1];
		SELF.source									:= 'roxie';
		SELF.DebugText							:= MAP(EXISTS(logResults) => '',
																	 transactionID = ''			=> 'No TransactionID passed in',
																														 'No Transaction Records Found for ' + transactionID);
	END;
	final := PROJECT(oneRecord, intoFinal(LEFT));
	
	OUTPUT(final, NAMED('Results'));
ENDMACRO;