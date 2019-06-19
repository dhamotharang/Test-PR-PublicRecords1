key := Score_Logs.Key_ScoreLogs_XMLTransactionID (datetime[1..6] >= ut.Month_Math(ut.GetDate[1..6], -6)); // Only keep transactions for the past month
FCRAkey := Score_Logs.Key_FCRA_ScoreLogs_XMLTransactionID (datetime[1..6] >= ut.Month_Math(ut.GetDate[1..6], -6));

productRec := RECORD
	STRING8 Date := key.datetime[1..8];
	UNSIGNED8 RecordCount := COUNT(GROUP);
END;
keyTable := TABLE(key, productRec, datetime[1..8], FEW, UNSORTED);

sorts := SORT(keyTable, Date);

OUTPUT(sorts, NAMED('LoggingTable'));

FCRAproductRec := RECORD
	STRING8 Date := FCRAkey.datetime[1..8];
	UNSIGNED8 RecordCount := COUNT(GROUP);
END;
FCRAkeyTable := TABLE(FCRAkey, FCRAproductRec, datetime[1..8], FEW, UNSORTED);

FCRAsorts := SORT(FCRAkeyTable, Date);

OUTPUT(FCRAsorts, NAMED('LoggingTable_FCRA'));