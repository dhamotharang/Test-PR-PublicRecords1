BeginDate := '20131201';
EndDate := '20140325';

AccountIDs := ['107966'];

key :=  DISTRIBUTE(PULL(Score_Logs.Key_ScoreLogs_XMLTransactionID (datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs)));
FCRAkey :=  DISTRIBUTE(PULL(Score_Logs.Key_FCRA_ScoreLogs_XMLTransactionID (datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs)));

productRec := RECORD
	STRING10 AccountID := key.customer_id;
	STRING40 Product := key.Product;
	UNSIGNED8 TransactionCount := COUNT(GROUP);
END;
keyTable := TABLE(key, productRec, customer_id, Product); //, FEW, UNSORTED);

sorts := SORT(keyTable, AccountID, Product, -TransactionCount); //, Product, -ProductCount, SKEW(1));

OUTPUT(sorts, NAMED('Products_Used'));

FCRAproductRec := RECORD
	STRING10 AccountID := FCRAkey.customer_id;
	STRING40 Product := FCRAkey.Product;
	UNSIGNED8 TransactionCount := COUNT(GROUP);
END;
FCRAkeyTable := TABLE(FCRAkey, FCRAproductRec, customer_id, Product); //, FEW, UNSORTED);

FCRAsorts := SORT(FCRAkeyTable, AccountID, Product, -TransactionCount); //, Product, -ProductCount, SKEW(1));

OUTPUT(FCRAsorts, NAMED('Products_Used_FCRA'));